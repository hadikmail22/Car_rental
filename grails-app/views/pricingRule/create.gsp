<!doctype html>
<html>

<head>

    <meta
            name="layout"
            content="main"/>

    <title>
        Create Pricing Rule
    </title>

</head>


<body>

<div class="container mt-4 pricing-form-page">


    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-start mb-4 flex-wrap gap-3">

        <div>

            <h2 class="mb-1">
                Create Pricing Rule
            </h2>

            <p class="text-muted mb-0">
                Create a seasonal price, promotion or vehicle-specific offer
            </p>

        </div>


        <g:link
                action="index"
                class="btn btn-outline-secondary">

            Back to Pricing Rules

        </g:link>

    </div>


    <!-- Create Form -->
    <g:form
            action="save"
            method="POST">

        <g:render
                template="form"
                model="${[
                        pricingRule: pricingRule,
                        categoryList: categoryList,
                        carOptions: carOptions,
                        submitLabel: 'Create Pricing Rule'
                ]}"/>

    </g:form>


</div>

</body>

</html>