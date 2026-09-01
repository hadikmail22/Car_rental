<!doctype html>
<html>

<head>
    <meta name="layout" content="main"/>
    <title>Rent Car</title>

    <style>
        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --taillight:#e5484d;
            --brake-red:#c0392b;
            --go-green:#1f8a52;
            --blue-signal:#2560c4;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }

        .rent-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
        }

        .rent-page h2{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            letter-spacing:-0.01em;
            color:var(--asphalt-900);
        }

        .rent-page .text-muted{
            color:var(--ink-soft) !important;
        }

        .alert-danger{
            background:#fdecea;
            border:1px solid #f3b8b2;
            color:var(--brake-red);
            border-radius:8px;
        }

        .alert-warning{
            background:#fff3e0;
            border:1px solid #f2d49b;
            color:var(--headlight-dim);
            border-radius:8px;
        }

        .alert-success{
            background:#e8f6ee;
            border:1px solid #b9e3c9;
            color:var(--go-green);
            border-radius:8px;
        }

        /* ---------- Car info card ---------- */
        .rent-car-card{
            border:1px solid var(--hairline) !important;
            border-radius:14px;
            overflow:hidden;
        }

        .rent-car-card h3{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
        }

        .rent-car-card p strong{
            font-family:'JetBrains Mono', monospace;
            font-size:0.78rem;
            font-weight:600;
            letter-spacing:0.04em;
            color:var(--ink-soft);
            display:inline-block;
            min-width:110px;
        }

        .status-badge{
            font-family:'JetBrains Mono', monospace;
            font-weight:600;
            font-size:0.72rem;
            letter-spacing:0.06em;
            padding:0.35rem 0.65rem;
            border-radius:999px;
            display:inline-flex;
            align-items:center;
            gap:0.4rem;
        }

        .status-badge::before{
            content:"";
            width:6px;
            height:6px;
            border-radius:50%;
            display:inline-block;
        }

        .status-badge.available{ background:#e8f6ee; color:var(--go-green); }
        .status-badge.available::before{ background:var(--go-green); box-shadow:0 0 6px var(--go-green); }

        .status-badge.rented{ background:#eaf1fb; color:var(--blue-signal); }
        .status-badge.rented::before{ background:var(--blue-signal); box-shadow:0 0 6px var(--blue-signal); }

        .status-badge.maintenance{ background:#fff3e0; color:var(--headlight-dim); }
        .status-badge.maintenance::before{ background:var(--headlight); box-shadow:0 0 6px var(--headlight); }

        /* ---------- Rental details card ---------- */
        .rental-details-card{
            border:1px solid var(--hairline) !important;
            border-radius:14px;
        }

        .rental-details-card h4{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
        }

        .rental-details-card h5{
            font-family:'Space Grotesk', sans-serif;
            font-weight:600;
            font-size:1.05rem;
            color:var(--asphalt-900);
        }

        .rental-details-card ul li strong{
            font-family:'JetBrains Mono', monospace;
        }

        /* ---------- Form fields ---------- */
        .field-group{
            margin-bottom:1.5rem;
        }

        .field-group .form-label{
            font-family:'JetBrains Mono', monospace;
            font-size:0.72rem;
            font-weight:600;
            letter-spacing:0.08em;
            text-transform:uppercase;
            color:var(--ink-soft);
            margin-bottom:0.4rem;
        }

        .form-control{
            border:1px solid var(--hairline);
            border-radius:8px;
            padding:0.6rem 0.9rem;
        }

        .form-control:focus{
            border-color:var(--headlight);
            box-shadow:0 0 0 0.2rem rgba(245,166,35,0.18);
        }

        /* ---------- Price summary: signature odometer panel ---------- */
        .price-box{
            border:1px solid var(--hairline) !important;
            border-radius:12px;
            background:var(--asphalt-900) !important;
            color:#fff;
        }

        .price-box h5{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:#fff;
        }

        .price-box small{
            font-family:'JetBrains Mono', monospace;
            font-size:0.7rem;
            letter-spacing:0.06em;
            text-transform:uppercase;
            color:#9a9ba1 !important;
        }

        .price-box strong{
            font-family:'JetBrains Mono', monospace;
            color:#fff;
        }

        .price-box #totalPrice{
            font-family:'Space Grotesk', sans-serif;
            color:var(--headlight) !important;
        }

        .price-adjustment{
            padding-top:1rem;
            border-top:1px solid rgba(255,255,255,0.12);
        }

        .price-adjustment-value{
            font-family:'JetBrains Mono', monospace;
            font-weight:700;
        }

        .price-adjustment-value.discount{
            color:#68d391;
        }

        .price-adjustment-value.increase{
            color:#f6c453;
        }

        .pricing-rules{
            display:flex;
            flex-wrap:wrap;
            gap:0.5rem;
            margin-top:0.75rem;
        }

        .pricing-rule-badge{
            display:inline-flex;
            align-items:center;
            gap:0.35rem;
            padding:0.35rem 0.6rem;
            border:1px solid rgba(245,166,35,0.35);
            border-radius:999px;
            background:rgba(245,166,35,0.1);
            color:#f6c453;
            font-family:'JetBrains Mono', monospace;
            font-size:0.72rem;
        }

        .daily-pricing{
            margin-top:1rem;
            padding-top:1rem;
            border-top:1px solid rgba(255,255,255,0.12);
        }

        .daily-pricing summary{
            color:#fff;
            font-family:'JetBrains Mono', monospace;
            font-size:0.78rem;
            cursor:pointer;
        }

        .daily-price-list{
            margin-top:0.75rem;
            border:1px solid rgba(255,255,255,0.1);
            border-radius:8px;
            overflow:hidden;
        }

        .daily-price-row{
            display:grid;
            grid-template-columns:minmax(95px, 1fr) minmax(85px, auto) minmax(120px, 2fr);
            gap:0.75rem;
            align-items:center;
            padding:0.65rem 0.75rem;
            border-bottom:1px solid rgba(255,255,255,0.08);
            font-family:'JetBrains Mono', monospace;
            font-size:0.75rem;
        }

        .daily-price-row:last-child{
            border-bottom:none;
        }

        .daily-price-date{
            color:#d6d6d8;
        }

        .daily-price-amount{
            color:#fff;
            font-weight:700;
            text-align:right;
        }

        .daily-price-rule{
            color:#9a9ba1;
            text-align:right;
        }

        .pricing-note{
            margin-top:0.8rem;
            color:#9a9ba1;
            font-size:0.78rem;
        }

        @media (max-width: 575.98px){
            .daily-price-row{
                grid-template-columns:1fr auto;
            }

            .daily-price-rule{
                grid-column:1 / -1;
                text-align:left;
            }
        }

        #dateError{
            border-radius:8px;
        }

        /* ---------- Buttons ---------- */
        .btn-primary{
            background:var(--headlight);
            border:none;
            color:var(--asphalt-900);
            font-weight:600;
            border-radius:8px;
        }
        .btn-primary:hover,
        .btn-primary:focus-visible{
            background:var(--headlight-dim);
            color:var(--asphalt-900);
        }
        .btn-primary:disabled{
            background:#e4e2dc;
            color:#a9a7a0;
        }

        .btn-secondary{
            background:transparent;
            border:1px solid var(--hairline);
            color:var(--ink-soft);
            border-radius:8px;
            font-weight:600;
        }
        .btn-secondary:hover,
        .btn-secondary:focus-visible{
            background:var(--paper);
            color:var(--ink);
        }

        /* ---------- Booking confirmation notice ---------- */
        .booking-notice{
            margin:1.75rem 0;
            overflow:hidden;
            background:linear-gradient(145deg,#111318,#191b20);
            border:1px solid rgba(245,166,35,0.28);
            border-radius:14px;
            box-shadow:0 14px 35px rgba(16,17,20,0.13);
        }

        .booking-notice-header{
            display:flex;
            align-items:center;
            gap:12px;
            padding:1.05rem 1.2rem;
            border-bottom:1px solid rgba(255,255,255,0.08);
        }

        .booking-notice-icon{
            width:40px;
            height:40px;
            display:flex;
            align-items:center;
            justify-content:center;
            flex-shrink:0;
            color:var(--headlight);
            background:rgba(245,166,35,0.10);
            border:1px solid rgba(245,166,35,0.24);
            border-radius:10px;
        }

        .booking-notice-title{
            margin:0;
            color:#fff !important;
            font-family:'Space Grotesk', sans-serif;
            font-size:1rem;
            font-weight:700;
        }

        .booking-notice-subtitle{
            margin-top:3px;
            color:#9b9da4;
            font-size:0.78rem;
        }

        .booking-notice-body{
            padding:1.2rem;
        }

        .booking-rule{
            display:flex;
            gap:12px;
            padding:0.85rem 0;
            border-bottom:1px solid rgba(255,255,255,0.06);
        }

        .booking-rule:last-of-type{
            border-bottom:none;
        }

        .booking-rule-number{
            width:28px;
            height:28px;
            display:flex;
            align-items:center;
            justify-content:center;
            flex-shrink:0;
            color:var(--asphalt-900);
            background:var(--headlight);
            border-radius:50%;
            font-family:'JetBrains Mono', monospace;
            font-size:0.68rem;
            font-weight:700;
        }

        .booking-rule strong{
            display:block;
            margin-bottom:4px;
            color:#f4f4f2;
            font-size:0.88rem;
        }

        .booking-rule p{
            margin:0;
            color:#a5a7ae;
            font-size:0.8rem;
            line-height:1.6;
        }

        .booking-amount{
            color:var(--headlight);
            font-family:'JetBrains Mono', monospace;
            font-weight:700;
        }

        .terms-check{
            margin-top:1rem;
            padding:1rem;
            color:#d5d5d2;
            background:rgba(255,255,255,0.035);
            border:1px solid rgba(255,255,255,0.07);
            border-radius:10px;
        }

        .terms-check input{
            accent-color:var(--headlight);
        }

        .terms-check label{
            margin-left:6px;
            font-size:0.82rem;
            line-height:1.55;
            cursor:pointer;
        }

    </style>
</head>

<body>

<div class="container mt-4 rent-page">

    <div class="mb-4">

        <h2>
            Rent ${car.brand} ${car.model}
        </h2>

        <p class="text-muted">
            Select your rental dates
        </p>

    </div>


    <!-- Error Message -->
    <g:if test="${flash.message}">
        <div class="alert alert-danger">
            ${flash.message}
        </div>
    </g:if>


    <!-- Car Information -->
    <div class="card shadow-sm mb-4 rent-car-card">

        <div class="row g-0">

            <!-- Image -->
            <div class="col-md-5">

                <g:if test="${car?.carImage}">

                    <img
                        src="${createLink(
                            controller: 'car',
                            action: 'image',
                            id: car.id
                        )}"
                        alt="${car.brand} ${car.model}"
                        style="
                            width:100%;
                            height:280px;
                            object-fit:contain;
                            background:#f8f9fa;
                        "/>

                </g:if>
                <g:else>

                    <div
                        class="bg-light d-flex align-items-center justify-content-center"
                        style="height:280px;">

                        <span class="text-muted">
                            No Image Available
                        </span>

                    </div>

                </g:else>

            </div>


            <!-- Car Details -->
            <div class="col-md-7">

                <div class="card-body p-4">

                    <h3 class="mb-4">
                        ${car.brand} ${car.model}
                    </h3>

                    <p>
                        <strong>Year:</strong>
                        ${car.year}
                    </p>

                    <p>
                        <strong>Plate:</strong>
                        ${car.plateNumber}
                    </p>

                    <p>
                        <strong>Price Per Day:</strong>
                        ${car.pricePerDay}
                    </p>

                    <p>
                        <strong>Status:</strong>

                        <g:if test="${car.status == 'AVAILABLE'}">
                            <span class="status-badge available">
                                AVAILABLE
                            </span>
                        </g:if>
                        <g:elseif test="${car.status == 'RENTED'}">
                            <span class="status-badge rented">
                                RENTED
                            </span>
                        </g:elseif>
                        <g:else>
                            <span class="status-badge maintenance">
                                ${car.status}
                            </span>
                        </g:else>

                    </p>

                </div>

            </div>

        </div>

    </div>


    <!-- Rental Form -->
    <div class="card shadow-sm rental-details-card">

        <div class="card-body p-4">

            <h4 class="mb-4">
                Rental Details
            </h4>


            <!-- Booked Dates -->
            <div class="mb-4">

                <h5 class="mb-3">
                    Booked Dates
                </h5>

                <g:if test="${bookings && !bookings.isEmpty()}">

                    <div class="alert alert-warning">

                        <strong>
                            This car is unavailable during:
                        </strong>

                        <ul class="mt-3 mb-0">

                            <g:each in="${bookings}" var="booking">

                                <li class="mb-2">

                                    <strong>
                                        <g:formatDate
                                            date="${booking.startDate}"
                                            format="dd MMM yyyy"/>
                                    </strong>

                                    →

                                    <strong>
                                        <g:formatDate
                                            date="${booking.endDate}"
                                            format="dd MMM yyyy"/>
                                    </strong>

                                    <span class="badge bg-secondary ms-2">
                                        ${booking.status}
                                    </span>

                                </li>

                            </g:each>

                        </ul>

                    </div>

                </g:if>
                <g:else>

                    <div class="alert alert-success">
                        No active bookings for this car.
                        You can select any available dates.
                    </div>

                </g:else>

            </div>


            <g:form action="save" method="POST">

                <g:hiddenField
                    name="carId"
                    value="${car.id}"/>


                <!-- Start Date -->
                <div class="mb-3 field-group">

                    <label
                        for="startDate"
                        class="form-label">

                        Start Date

                    </label>

                    <input
                        type="date"
                        id="startDate"
                        name="startDate"
                        class="form-control"
                        required/>

                </div>


                <!-- End Date -->
                <div class="mb-4 field-group">

                    <label
                        for="endDate"
                        class="form-label">

                        End Date

                    </label>

                    <input
                        type="date"
                        id="endDate"
                        name="endDate"
                        class="form-control"
                        required/>

                </div>


                <!-- Price Summary -->
                <div
                    id="priceBox"
                    class="card border-0 mb-4 price-box">

                    <div class="card-body">

                        <h5 class="mb-3">
                            Price Summary
                        </h5>

                        <div class="row">


                            <!-- Base Price Per Day -->
                            <div class="col-md-6 col-xl-3 mb-3">

                                <small class="d-block">
                                    Base Price Per Day
                                </small>

                                <strong
                                    id="basePricePerDay"
                                    class="fs-5">

                                    ${car.pricePerDay}

                                </strong>

                            </div>


                            <!-- Rental Days -->
                            <div class="col-md-6 col-xl-3 mb-3">

                                <small class="d-block">
                                    Rental Days
                                </small>

                                <strong
                                    id="rentalDays"
                                    class="fs-5">

                                    Select dates

                                </strong>

                            </div>


                            <!-- Base Total -->
                            <div class="col-md-6 col-xl-3 mb-3">

                                <small class="d-block">
                                    Base Total
                                </small>

                                <strong
                                    id="baseTotal"
                                    class="fs-5">

                                    Select dates

                                </strong>

                            </div>


                            <!-- Final Total Price -->
                            <div class="col-md-6 col-xl-3 mb-3">

                                <small class="d-block">
                                    Final Total
                                </small>

                                <strong
                                    id="totalPrice"
                                    class="fs-3">

                                    Select dates

                                </strong>

                            </div>

                        </div>


                        <!-- Dynamic Pricing Result -->
                        <div
                            id="pricingAdjustment"
                            class="price-adjustment"
                            style="display:none;">

                            <div class="d-flex justify-content-between gap-3">

                                <small id="pricingAdjustmentLabel">
                                    Pricing Adjustment
                                </small>

                                <span
                                    id="pricingAdjustmentValue"
                                    class="price-adjustment-value">
                                </span>

                            </div>

                            <div
                                id="appliedPricingRules"
                                class="pricing-rules">
                            </div>

                        </div>


                        <!-- Daily Price Breakdown -->
                        <details
                            id="dailyPricing"
                            class="daily-pricing"
                            style="display:none;">

                            <summary>
                                View daily price breakdown
                            </summary>

                            <div
                                id="dailyPriceList"
                                class="daily-price-list">
                            </div>

                        </details>


                        <div class="pricing-note">
                            The final booking price is calculated and locked
                            when the rental request is created.
                        </div>

                    </div>

                </div>


                <!-- Date Error -->
                <div
                    id="dateError"
                    class="alert alert-danger"
                    style="display:none;">

                    End date cannot be before start date.

                </div>



                <!-- Booking Terms / Important Notice -->
                <div class="booking-notice">

                    <div class="booking-notice-header">

                        <div class="booking-notice-icon">
                            <i class="bi bi-shield-check"></i>
                        </div>

                        <div>
                            <h5 class="booking-notice-title">
                                Important Before You Continue
                            </h5>

                            <div class="booking-notice-subtitle">
                                Please review the booking, deposit and pickup conditions.
                            </div>
                        </div>

                    </div>


                    <div class="booking-notice-body">

                        <div class="booking-rule">

                            <div class="booking-rule-number">01</div>

                            <div>
                                <strong>
                                    Your reservation is not confirmed yet
                                </strong>

                                <p>
                                    Submitting this form creates a PENDING rental request.
                                    The vehicle is officially reserved only after the
                                    booking deposit is successfully paid.
                                </p>
                            </div>

                        </div>


                        <div class="booking-rule">

                            <div class="booking-rule-number">02</div>

                            <div>
                                <strong>
                                    Booking Deposit —
                                    <span class="booking-amount">50.00</span>
                                </strong>

                                <p>
                                    A booking deposit of
                                    <span class="booking-amount">50.00</span>
                                    is required to confirm your reservation.
                                    Until it is paid, the request remains pending
                                    and the vehicle is not guaranteed for those dates.
                                </p>
                            </div>

                        </div>


                        <div class="booking-rule">

                            <div class="booking-rule-number">03</div>

                            <div>
                                <strong>
                                    Refundable Security Deposit —
                                    <span class="booking-amount">200.00</span>
                                </strong>

                                <p>
                                    A refundable security deposit of
                                    <span class="booking-amount">200.00</span>
                                    is handled during the vehicle pickup process.
                                    It is returned after the vehicle is returned,
                                    subject to any applicable damage deductions.
                                </p>
                            </div>

                        </div>


                        <div class="booking-rule">

                            <div class="booking-rule-number">04</div>

                            <div>
                                <strong>
                                    Insurance & Pickup Procedures
                                </strong>

                                <p>
                                    Identity verification, driving licence verification,
                                    vehicle inspection and the remaining insurance/security
                                    procedures are completed when you collect the vehicle.
                                </p>
                            </div>

                        </div>


                        <div class="terms-check">

                            <input
                                type="checkbox"
                                id="acceptBookingTerms"
                                name="acceptBookingTerms"
                                value="true"
                                required/>

                            <label for="acceptBookingTerms">
                                I understand that this is initially a pending rental request,
                                that the reservation is confirmed only after paying the booking
                                deposit, and that the refundable security deposit and pickup
                                procedures are completed separately.
                            </label>

                        </div>

                    </div>

                </div>


                <button
    type="submit"
    id="createRentalButton"
    class="btn btn-primary">

    <i class="bi bi-arrow-right-circle me-1"></i>
    Create Rental

</button>


                <g:link
                    controller="car"
                    action="index"
                    class="btn btn-secondary">

                    Cancel

                </g:link>

            </g:form>

        </div>

    </div>

</div>


<script>

const rentalQuoteUrl =
    '${g.createLink(controller: 'rental', action: 'quote')}';

let activeQuoteRequest = null;
let latestQuoteRequestNumber = 0;


function formatMoney(value) {

    const number = Number(value);

    return Number.isFinite(number) ?
        number.toFixed(2) :
        '0.00';
}


function resetDynamicPricingDetails() {

    document.getElementById('pricingAdjustment').style.display =
        'none';

    document.getElementById('appliedPricingRules').replaceChildren();

    const dailyPricing =
        document.getElementById('dailyPricing');

    dailyPricing.style.display =
        'none';

    dailyPricing.open =
        false;

    document.getElementById('dailyPriceList').replaceChildren();
}


function showQuoteError(message) {

    const dateError =
        document.getElementById('dateError');

    dateError.textContent =
        message;

    dateError.style.display =
        'block';

    document.getElementById('rentalDays').textContent =
        '-';

    document.getElementById('baseTotal').textContent =
        '-';

    document.getElementById('totalPrice').textContent =
        '-';

    document.getElementById('createRentalButton').disabled =
        true;

    resetDynamicPricingDetails();
}


function renderAppliedRules(rules) {

    const rulesContainer =
        document.getElementById('appliedPricingRules');

    rulesContainer.replaceChildren();

    rules.forEach(function (rule) {

        const badge =
            document.createElement('span');

        badge.className =
            'pricing-rule-badge';

        const sign =
            rule.adjustmentType === 'DISCOUNT' ? '-' : '+';

        badge.textContent =
            rule.name +
            ' (' +
            sign +
            formatMoney(rule.percentage) +
            '%, ' +
            rule.scope +
            ')';

        rulesContainer.appendChild(badge);
    });
}


function renderDailyPrices(dailyPrices) {

    const dailyPricing =
        document.getElementById('dailyPricing');

    const dailyPriceList =
        document.getElementById('dailyPriceList');

    dailyPriceList.replaceChildren();

    dailyPrices.forEach(function (dailyPrice) {

        const row =
            document.createElement('div');

        row.className =
            'daily-price-row';

        const date =
            document.createElement('span');

        date.className =
            'daily-price-date';

        date.textContent =
            dailyPrice.date;

        const amount =
            document.createElement('span');

        amount.className =
            'daily-price-amount';

        amount.textContent =
            formatMoney(dailyPrice.finalPrice);

        const rule =
            document.createElement('span');

        rule.className =
            'daily-price-rule';

        if (dailyPrice.ruleName) {

            const sign =
                dailyPrice.adjustmentType === 'DISCOUNT' ? '-' : '+';

            rule.textContent =
                dailyPrice.ruleName +
                ' ' +
                sign +
                formatMoney(dailyPrice.percentage) +
                '%';

        } else {

            rule.textContent =
                'Base price';
        }

        row.append(date, amount, rule);
        dailyPriceList.appendChild(row);
    });

    dailyPricing.style.display =
        dailyPrices.length ? 'block' : 'none';
}


function renderRentalQuote(quote) {

    const rentalDays =
        Number(quote.rentalDays);

    document.getElementById('basePricePerDay').textContent =
        formatMoney(quote.basePricePerDay);

    document.getElementById('rentalDays').textContent =
        rentalDays +
        (rentalDays === 1 ? ' day' : ' days');

    document.getElementById('baseTotal').textContent =
        formatMoney(quote.baseTotal);

    document.getElementById('totalPrice').textContent =
        formatMoney(quote.totalPrice);

    resetDynamicPricingDetails();

    if (quote.hasDynamicPricing) {

        const adjustment =
            Number(quote.adjustmentAmount);

        const isDiscount =
            adjustment < 0;

        const adjustmentValue =
            document.getElementById('pricingAdjustmentValue');

        document.getElementById('pricingAdjustmentLabel').textContent =
            isDiscount ?
                'Discount Applied' :
                'Seasonal Price Increase';

        adjustmentValue.className =
            'price-adjustment-value ' +
            (isDiscount ? 'discount' : 'increase');

        adjustmentValue.textContent =
            (isDiscount ? '-' : '+') +
            formatMoney(Math.abs(adjustment));

        document.getElementById('pricingAdjustment').style.display =
            'block';

        renderAppliedRules(
            Array.isArray(quote.appliedRules) ?
                quote.appliedRules :
                []
        );
    }

    renderDailyPrices(
        Array.isArray(quote.dailyPrices) ?
            quote.dailyPrices :
            []
    );
}


async function calculateRentalPrice() {

    const startValue =
        document.getElementById('startDate').value;

    const endValue =
        document.getElementById('endDate').value;

    const rentalDaysElement =
        document.getElementById('rentalDays');

    const baseTotalElement =
        document.getElementById('baseTotal');

    const totalPriceElement =
        document.getElementById('totalPrice');

    const dateError =
        document.getElementById('dateError');

    const createButton =
        document.getElementById('createRentalButton');


    if (activeQuoteRequest) {
        activeQuoteRequest.abort();
        activeQuoteRequest = null;
    }


    if (!startValue || !endValue) {

        rentalDaysElement.textContent =
            'Select dates';

        baseTotalElement.textContent =
            'Select dates';

        totalPriceElement.textContent =
            'Select dates';

        dateError.style.display =
            'none';

        createButton.disabled =
            false;

        resetDynamicPricingDetails();

        return;
    }


    if (endValue < startValue) {

        showQuoteError(
            'End date cannot be before start date.'
        );

        return;
    }


    const requestNumber =
        ++latestQuoteRequestNumber;

    activeQuoteRequest =
        new AbortController();

    dateError.style.display =
        'none';

    rentalDaysElement.textContent =
        'Calculating...';

    baseTotalElement.textContent =
        'Calculating...';

    totalPriceElement.textContent =
        'Calculating...';

    createButton.disabled =
        true;

    resetDynamicPricingDetails();


    const query =
        new URLSearchParams({
            carId: '${car.id}',
            startDate: startValue,
            endDate: endValue
        });


    try {

        const response =
            await fetch(
                rentalQuoteUrl + '?' + query.toString(),
                {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    },
                    credentials: 'same-origin',
                    signal: activeQuoteRequest.signal
                }
            );


        let responseBody = {};

        try {
            responseBody = await response.json();
        } catch (ignored) {
            responseBody = {};
        }


        if (requestNumber !== latestQuoteRequestNumber) {
            return;
        }


        if (!response.ok) {

            throw new Error(
                responseBody.error ||
                'Unable to calculate the rental price.'
            );
        }


        renderRentalQuote(responseBody);

        dateError.style.display =
            'none';

        createButton.disabled =
            false;

    } catch (error) {

        if (error.name === 'AbortError') {
            return;
        }

        if (requestNumber !== latestQuoteRequestNumber) {
            return;
        }

        showQuoteError(
            error.message ||
            'Unable to calculate the rental price.'
        );

    } finally {

        if (requestNumber === latestQuoteRequestNumber) {
            activeQuoteRequest = null;
        }
    }
}


document.addEventListener('DOMContentLoaded', function () {

    document.getElementById('startDate').addEventListener(
        'change',
        calculateRentalPrice
    );

    document.getElementById('endDate').addEventListener(
        'change',
        calculateRentalPrice
    );
});

</script>

</body>
</html>
