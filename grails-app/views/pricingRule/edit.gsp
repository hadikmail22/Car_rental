<!doctype html>
<html>

<head>

    <meta
            name="layout"
            content="main"/>

    <title>
        Edit Pricing Rule
    </title>

</head>


<body>

<div class="container mt-4 pricing-form-page">


    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-start mb-4 flex-wrap gap-3">

        <div>

            <h2 class="mb-1">
                Edit Pricing Rule
            </h2>

            <p class="text-muted mb-0">
                Existing rentals keep their previously agreed total price
            </p>

        </div>


        <g:link
                action="index"
                class="btn btn-outline-secondary">

            Back to Pricing Rules

        </g:link>

    </div>


    <!-- Edit Form -->
    <g:form
            action="update"
            id="${pricingRule.id}"
            method="PUT">

        <g:render
                template="form"
                model="${[
                        pricingRule: pricingRule,
                        categoryList: categoryList,
                        carOptions: carOptions,
                        submitLabel: 'Save Changes'
                ]}"/>

    </g:form>


</div>

</body>

</html>