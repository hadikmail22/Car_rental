<style>
    :root{
        --asphalt-900:#101114;
        --asphalt-800:#17181c;
        --headlight:#f5a623;
        --headlight-dim:#c9860f;
        --taillight:#e5484d;
        --paper:#f6f5f2;
        --ink:#101114;
        --ink-soft:#5b5d63;
        --hairline:#e4e2dc;
    }

    .pricing-form-page{
        max-width:900px;
        font-family:'Inter', -apple-system, sans-serif;
        color:var(--ink);
    }

    .pricing-form-page h2,
    .pricing-form-page h5{
        font-family:'Space Grotesk', sans-serif;
        font-weight:700;
        color:var(--asphalt-900);
    }

    .pricing-form-card{
        border:1px solid var(--hairline);
        border-radius:14px;
        background:#fff;
        padding:2rem;
    }

    .section-title{
        padding-bottom:.75rem;
        margin-bottom:1.25rem;
        border-bottom:1px solid var(--hairline);
    }

    .form-label{
        font-family:'JetBrains Mono', monospace;
        font-size:.72rem;
        font-weight:600;
        letter-spacing:.07em;
        text-transform:uppercase;
        color:var(--ink-soft);
    }

    .form-control,
    .form-select{
        border-color:var(--hairline);
        border-radius:8px;
        padding:.65rem .85rem;
    }

    .form-control:focus,
    .form-select:focus{
        border-color:var(--headlight);
        box-shadow:0 0 0 .2rem rgba(245,166,35,.18);
    }

    .field-help{
        color:var(--ink-soft);
        font-size:.82rem;
        margin-top:.35rem;
    }

    .target-box{
        background:var(--paper);
        border:1px solid var(--hairline);
        border-radius:10px;
        padding:1rem;
    }

    .alert-danger{
        background:#fdecea;
        border:1px solid #f3b8b2;
        color:#a93226;
        border-radius:8px;
    }

    .btn-primary{
        background:var(--asphalt-900);
        border-color:var(--asphalt-900);
        border-radius:8px;
        font-weight:700;
        padding:.65rem 1.25rem;
    }

    .btn-primary:hover{
        background:var(--asphalt-800);
        border-color:var(--asphalt-800);
    }

    .btn-outline-secondary{
        border-radius:8px;
        font-weight:600;
        padding:.65rem 1.25rem;
    }

    .form-check-input:checked{
        background-color:var(--headlight);
        border-color:var(--headlight-dim);
    }
</style>


<!-- Validation Errors -->
<g:hasErrors bean="${pricingRule}">

    <div class="alert alert-danger mb-4">

        <div class="fw-bold mb-2">
            Please correct the pricing rule:
        </div>

        <ul class="mb-0">

            <g:eachError
                    bean="${pricingRule}"
                    var="error">

                <li>
                    <g:message error="${error}"/>
                </li>

            </g:eachError>

        </ul>

    </div>

</g:hasErrors>


<div class="pricing-form-card">

    <!-- Rule Details -->
    <div class="section-title">

        <h5 class="mb-1">
            Rule Details
        </h5>

        <div class="text-muted small">
            The base price on the car remains unchanged.
        </div>

    </div>


    <!-- Rule Name -->
    <div class="mb-4">

        <label
                for="name"
                class="form-label">

            Rule Name

        </label>

        <g:textField
                name="name"
                value="${pricingRule?.name}"
                maxlength="100"
                required="required"
                placeholder="Example: Eid Luxury Increase"
                class="form-control"/>

    </div>


    <!-- Dates -->
    <div class="row g-3 mb-4">

        <div class="col-md-6">

            <label
                    for="startDate"
                    class="form-label">

                Start Date

            </label>

            <input
                    type="date"
                    id="startDate"
                    name="startDate"
                    value="${pricingRule?.startDate ?
                            g.formatDate(
                                    date: pricingRule.startDate,
                                    format: 'yyyy-MM-dd'
                            ) :
                            ''}"
                    required
                    class="form-control"/>

        </div>


        <div class="col-md-6">

            <label
                    for="endDate"
                    class="form-label">

                End Date

            </label>

            <input
                    type="date"
                    id="endDate"
                    name="endDate"
                    value="${pricingRule?.endDate ?
                            g.formatDate(
                                    date: pricingRule.endDate,
                                    format: 'yyyy-MM-dd'
                            ) :
                            ''}"
                    required
                    class="form-control"/>

            <div class="field-help">
                Both start and end dates are included.
            </div>

        </div>

    </div>


    <!-- Adjustment -->
    <div class="row g-3 mb-4">

        <div class="col-md-6">

            <label
                    for="adjustmentType"
                    class="form-label">

                Adjustment Type

            </label>

            <g:select
                    name="adjustmentType"
                    from="${[
                            'INCREASE',
                            'DISCOUNT'
                    ]}"
                    value="${pricingRule?.adjustmentType}"
                    class="form-select"/>

        </div>


        <div class="col-md-6">

            <label
                    for="percentage"
                    class="form-label">

                Percentage

            </label>

            <div class="input-group">

                <g:field
                        type="number"
                        name="percentage"
                        value="${pricingRule?.percentage}"
                        min="0.01"
                        max="100"
                        step="0.01"
                        required="required"
                        class="form-control"/>

                <span class="input-group-text">
                    %
                </span>

            </div>

        </div>

    </div>


    <!-- Target Section -->
    <div class="section-title mt-5">

        <h5 class="mb-1">
            Target
        </h5>

        <div class="text-muted small">
            Apply the rule to the fleet, one category or one specific car.
        </div>

    </div>


    <div class="target-box mb-4">

        <!-- Scope -->
        <div class="mb-3">

            <label
                    for="scope"
                    class="form-label">

                Scope

            </label>

            <g:select
                    name="scope"
                    from="${[
                            'ALL',
                            'CATEGORY',
                            'CAR'
                    ]}"
                    value="${pricingRule?.scope}"
                    class="form-select"/>

        </div>


        <!-- Category Target -->
        <div
                id="categoryTarget"
                class="mb-3 d-none">

            <label
                    for="categoryId"
                    class="form-label">

                Category

            </label>

            <g:select
                    name="categoryId"
                    from="${categoryList}"
                    optionKey="id"
                    optionValue="name"
                    value="${pricingRule?.category?.id}"
                    noSelection="${[
                            '': 'Select a category'
                    ]}"
                    class="form-select"/>

        </div>


        <!-- Car Target -->
        <div
                id="carTarget"
                class="mb-3 d-none">

            <label
                    for="carId"
                    class="form-label">

                Car

            </label>

            <g:select
                    name="carId"
                    from="${carOptions}"
                    optionKey="id"
                    optionValue="label"
                    value="${pricingRule?.car?.id}"
                    noSelection="${[
                            '': 'Select a car'
                    ]}"
                    class="form-select"/>

        </div>


        <div class="field-help">
            If multiple rules match, higher priority wins.
            On a tie: CAR, CATEGORY, then ALL.
        </div>

    </div>


    <!-- Priority and Active -->
    <div class="row g-3 mb-4 align-items-end">

        <div class="col-md-6">

            <label
                    for="priority"
                    class="form-label">

                Priority

            </label>

            <g:field
                    type="number"
                    name="priority"
                    value="${pricingRule?.priority ?: 0}"
                    min="0"
                    step="1"
                    required="required"
                    class="form-control"/>

            <div class="field-help">
                A larger number has higher priority.
            </div>

        </div>


        <div class="col-md-6 pb-2">

            <div class="form-check form-switch">

                <g:checkBox
                        name="active"
                        value="${pricingRule?.active != false}"
                        class="form-check-input"/>

                <label
                        for="active"
                        class="form-check-label fw-semibold">

                    Active rule

                </label>

            </div>

        </div>

    </div>


    <!-- Actions -->
    <div class="d-flex gap-2 pt-3 border-top">

        <button
                type="submit"
                class="btn btn-primary">

            ${submitLabel}

        </button>

        <g:link
                action="index"
                class="btn btn-outline-secondary">

            Cancel

        </g:link>

    </div>

</div>


<script>
    (function () {

        const scopeField =
                document.getElementById('scope');

        const categoryTarget =
                document.getElementById('categoryTarget');

        const carTarget =
                document.getElementById('carTarget');

        const categoryField =
                document.getElementById('categoryId');

        const carField =
                document.getElementById('carId');


        function updateTargetFields() {

            const scope =
                    scopeField.value;

            const usesCategory =
                    scope === 'CATEGORY';

            const usesCar =
                    scope === 'CAR';


            categoryTarget.classList.toggle(
                    'd-none',
                    !usesCategory
            );

            carTarget.classList.toggle(
                    'd-none',
                    !usesCar
            );


            categoryField.disabled =
                    !usesCategory;

            carField.disabled =
                    !usesCar;


            categoryField.required =
                    usesCategory;

            carField.required =
                    usesCar;
        }


        scopeField.addEventListener(
                'change',
                updateTargetFields
        );

        updateTargetFields();

    }());
</script>