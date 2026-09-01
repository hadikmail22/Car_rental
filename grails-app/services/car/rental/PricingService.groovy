package car.rental

import grails.gorm.transactions.Transactional

import java.math.RoundingMode
import java.time.LocalDate
import java.time.ZoneId

@Transactional(readOnly = true)
class PricingService {

    PricingRule findApplicableRule(
            Car car,
            Date date) {

        validateCarAndDate(car, date)

        LocalDate pricingDate =
                toLocalDate(date)

        Date startOfPricingDay =
                java.sql.Date.valueOf(pricingDate)

        Date startOfNextDay =
                java.sql.Date.valueOf(
                        pricingDate.plusDays(1)
                )

        List<PricingRule> candidates =
                PricingRule.createCriteria().list {

                    eq('active', true)
                    lt('startDate', startOfNextDay)
                    ge('endDate', startOfPricingDay)
                }

        List<PricingRule> matchingRules =
                candidates.findAll { PricingRule rule ->
                    appliesToCar(rule, car)
                }

        selectWinningRule(matchingRules)
    }

    BigDecimal calculateDailyPrice(
            Car car,
            Date date) {

        validateCarAndDate(car, date)

        if (car.pricePerDay == null) {
            throw new IllegalArgumentException(
                    'Car base price is required.'
            )
        }

        BigDecimal basePrice =
                car.pricePerDay.setScale(
                        2,
                        RoundingMode.HALF_UP
                )

        PricingRule rule =
                findApplicableRule(car, date)

        applyRuleToBasePrice(
                basePrice,
                rule
        )
    }

    BigDecimal calculateRentalPrice(
            Car car,
            Date startDate,
            Date endDate) {

        if (!car) {
            throw new IllegalArgumentException(
                    'Car is required.'
            )
        }

        if (!startDate || !endDate) {
            throw new IllegalArgumentException(
                    'Start date and end date are required.'
            )
        }

        LocalDate firstDay =
                toLocalDate(startDate)

        LocalDate lastDay =
                toLocalDate(endDate)

        if (lastDay.isBefore(firstDay)) {
            throw new IllegalArgumentException(
                    'End date cannot be before start date.'
            )
        }

        BigDecimal total = 0.00G
        LocalDate currentDay = firstDay

        while (!currentDay.isAfter(lastDay)) {

            total += calculateDailyPrice(
                    car,
                    java.sql.Date.valueOf(currentDay)
            )

            currentDay = currentDay.plusDays(1)
        }

        total.setScale(
                2,
                RoundingMode.HALF_UP
        )
    }

    Map calculateRentalQuote(
            Car car,
            Date startDate,
            Date endDate) {

        if (!car) {
            throw new IllegalArgumentException(
                    'Car is required.'
            )
        }

        if (!startDate || !endDate) {
            throw new IllegalArgumentException(
                    'Start date and end date are required.'
            )
        }

        if (car.pricePerDay == null) {
            throw new IllegalArgumentException(
                    'Car base price is required.'
            )
        }

        LocalDate firstDay =
                toLocalDate(startDate)

        LocalDate lastDay =
                toLocalDate(endDate)

        if (lastDay.isBefore(firstDay)) {
            throw new IllegalArgumentException(
                    'End date cannot be before start date.'
            )
        }

        BigDecimal basePrice =
                car.pricePerDay.setScale(
                        2,
                        RoundingMode.HALF_UP
                )

        BigDecimal baseTotal = 0.00G
        BigDecimal finalTotal = 0.00G

        List<Map> dailyPrices = []
        Map<Long, Map> appliedRuleMap = [:]

        LocalDate currentDay = firstDay

        while (!currentDay.isAfter(lastDay)) {

            Date pricingDate =
                    java.sql.Date.valueOf(currentDay)

            PricingRule rule =
                    findApplicableRule(
                            car,
                            pricingDate
                    )

            BigDecimal finalPrice =
                    applyRuleToBasePrice(
                            basePrice,
                            rule
                    )

            baseTotal += basePrice
            finalTotal += finalPrice

            dailyPrices << [
                    date          : currentDay.toString(),
                    basePrice     : basePrice,
                    finalPrice    : finalPrice,
                    ruleName      : rule?.name,
                    adjustmentType: rule?.adjustmentType,
                    percentage    : rule?.percentage,
                    scope         : rule?.scope
            ]

            if (rule) {
                appliedRuleMap[rule.id] = [
                        id            : rule.id,
                        name          : rule.name,
                        adjustmentType: rule.adjustmentType,
                        percentage    : rule.percentage,
                        scope         : rule.scope
                ]
            }

            currentDay =
                    currentDay.plusDays(1)
        }

        baseTotal =
                baseTotal.setScale(
                        2,
                        RoundingMode.HALF_UP
                )

        finalTotal =
                finalTotal.setScale(
                        2,
                        RoundingMode.HALF_UP
                )

        [
                rentalDays      : dailyPrices.size(),
                basePricePerDay : basePrice,
                baseTotal       : baseTotal,
                totalPrice      : finalTotal,
                adjustmentAmount:
                        (finalTotal - baseTotal).setScale(
                                2,
                                RoundingMode.HALF_UP
                        ),
                hasDynamicPricing:
                        !appliedRuleMap.isEmpty(),
                appliedRules    :
                        appliedRuleMap.values() as List,
                dailyPrices     : dailyPrices
        ]
    }

    Map<Long, List<Map>> getPricingHighlightsForCars(
            Collection<Car> cars,
            Date referenceDate = new Date(),
            Integer maxHighlightsPerCar = 2) {

        List<Car> distinctCars =
                (cars ?: [])
                        .findAll { Car car ->
                            car?.id
                        }
                        .unique { Car car ->
                            car.id
                        }

        if (!distinctCars) {
            return [:]
        }

        LocalDate today =
                toLocalDate(
                        referenceDate ?: new Date()
                )

        Date startOfToday =
                java.sql.Date.valueOf(today)

        List<PricingRule> candidateRules =
                PricingRule.createCriteria().list {

                    eq('active', true)
                    ge('endDate', startOfToday)

                    order('startDate', 'asc')
                    order('priority', 'desc')
                    order('id', 'desc')
                }

        int highlightLimit =
                Math.max(
                        maxHighlightsPerCar ?: 2,
                        1
                )

        Map<Long, List<Map>> highlightsByCar = [:]

        distinctCars.each { Car car ->

            List<PricingRule> rulesForCar =
                    candidateRules.findAll { PricingRule rule ->
                        appliesToCar(rule, car)
                    }

            highlightsByCar[car.id] =
                    buildPricingHighlights(
                            car,
                            rulesForCar,
                            today,
                            highlightLimit
                    )
        }

        highlightsByCar
    }

    private boolean appliesToCar(
            PricingRule rule,
            Car car) {

        switch (rule.scope) {

            case 'ALL':
                return true

            case 'CATEGORY':
                return car.category &&
                        rule.category == car.category

            case 'CAR':
                return rule.car == car

            default:
                return false
        }
    }

    private int scopeRank(String scope) {

        switch (scope) {
            case 'CAR':
                return 3

            case 'CATEGORY':
                return 2

            case 'ALL':
                return 1

            default:
                return 0
        }
    }

    private PricingRule selectWinningRule(
            Collection<PricingRule> rules) {

        if (!rules) {
            return null
        }

        List<PricingRule> orderedRules =
                rules.toList()

        orderedRules.sort { PricingRule first, PricingRule second ->

            int priorityComparison =
                    (second.priority ?: 0) <=>
                    (first.priority ?: 0)

            if (priorityComparison != 0) {
                return priorityComparison
            }

            int scopeComparison =
                    scopeRank(second.scope) <=>
                    scopeRank(first.scope)

            if (scopeComparison != 0) {
                return scopeComparison
            }
            (second.id ?: 0L) <=>
                    (first.id ?: 0L)
        }

        orderedRules.first()
    }

    private List<Map> buildPricingHighlights(
            Car car,
            List<PricingRule> rules,
            LocalDate today,
            int highlightLimit) {

        if (!rules) {
            return []
        }

        Set<LocalDate> changeDates =
                new TreeSet<LocalDate>()

        changeDates.add(today)

        rules.each { PricingRule rule ->

            LocalDate ruleStart =
                    toLocalDate(rule.startDate)

            LocalDate ruleEnd =
                    toLocalDate(rule.endDate)

            if (!ruleEnd.isBefore(today)) {

                changeDates.add(
                        ruleStart.isBefore(today) ?
                                today :
                                ruleStart
                )

                changeDates.add(
                        ruleEnd.plusDays(1)
                )
            }
        }

        List<LocalDate> orderedChangeDates =
                changeDates.toList().sort()

        List<Map> highlights = []

        for (
                int index = 0;
                index < orderedChangeDates.size() - 1;
                index++
        ) {

            LocalDate periodStart =
                    orderedChangeDates[index]

            LocalDate periodEnd =
                    orderedChangeDates[index + 1]
                            .minusDays(1)

            if (periodEnd.isBefore(periodStart)) {
                continue
            }

            List<PricingRule> matchingRules =
                    rules.findAll { PricingRule rule ->

                        LocalDate ruleStart =
                                toLocalDate(rule.startDate)

                        LocalDate ruleEnd =
                                toLocalDate(rule.endDate)

                        !periodStart.isBefore(ruleStart) &&
                                !periodStart.isAfter(ruleEnd)
                    }

            PricingRule winningRule =
                    selectWinningRule(matchingRules)

            if (!winningRule) {
                continue
            }

            Map previousHighlight =
                    highlights ?
                            highlights.last() :
                            null

            if (previousHighlight &&
                    previousHighlight.ruleId == winningRule.id &&
                    LocalDate.parse(
                            previousHighlight.endDate as String
                    ).plusDays(1) == periodStart) {

                previousHighlight.endDate =
                        periodEnd.toString()

                continue
            }

            BigDecimal basePrice =
                    car.pricePerDay?.setScale(
                            2,
                            RoundingMode.HALF_UP
                    )

            highlights << [
                    ruleId        : winningRule.id,
                    name          : winningRule.name,
                    adjustmentType:
                            winningRule.adjustmentType,
                    percentage    : winningRule.percentage,
                    scope         : winningRule.scope,
                    startDate     : periodStart.toString(),
                    endDate       : periodEnd.toString(),
                    current       : periodStart == today,
                    basePrice     : basePrice,
                    dailyPrice    : basePrice == null ?
                            null :
                            applyRuleToBasePrice(
                                    basePrice,
                                    winningRule
                            )
            ]
        }

        highlights.take(highlightLimit)
    }

    private BigDecimal applyRuleToBasePrice(
            BigDecimal basePrice,
            PricingRule rule) {

        if (!rule) {
            return basePrice
        }

        BigDecimal adjustmentAmount =
                basePrice
                        .multiply(rule.percentage)
                        .divide(
                                100G,
                                2,
                                RoundingMode.HALF_UP
                        )

        BigDecimal finalPrice

        if (rule.adjustmentType == 'DISCOUNT') {
            finalPrice =
                    basePrice - adjustmentAmount
        } else if (rule.adjustmentType == 'INCREASE') {
            finalPrice =
                    basePrice + adjustmentAmount
        } else {
            throw new IllegalStateException(
                    'Unsupported pricing adjustment type.'
            )
        }

        finalPrice
                .max(0G)
                .setScale(
                        2,
                        RoundingMode.HALF_UP
                )
    }

    private LocalDate toLocalDate(Date date) {

        if (date instanceof java.sql.Date) {
            return ((java.sql.Date) date).toLocalDate()
        }

        date
                .toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate()
    }

    private void validateCarAndDate(
            Car car,
            Date date) {

        if (!car) {
            throw new IllegalArgumentException(
                    'Car is required.'
            )
        }

        if (!date) {
            throw new IllegalArgumentException(
                    'Pricing date is required.'
            )
        }
    }
}
