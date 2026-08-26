<!doctype html>
<html>

<head>
    <meta name="layout" content="main"/>
    <title>Add Car</title>
</head>

<body>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2>Add New Car</h2>

        <g:link
            action="index"
            class="btn btn-outline-secondary">

            Back to Cars

        </g:link>

    </div>


    <!-- Flash Message -->
    <g:if test="${flash.message}">

        <div class="alert alert-danger">
            ${flash.message}
        </div>

    </g:if>


    <!-- Validation Errors -->
    <g:hasErrors bean="${car}">

        <div class="alert alert-danger">
            Please correct the errors below.
        </div>

    </g:hasErrors>


    <!-- Car Form -->
    <g:uploadForm action="save">


        <!-- Brand -->
        <div class="mb-3">

            <label
                for="brand"
                class="form-label">

                Brand

            </label>

            <g:textField
                name="brand"
                value="${car?.brand}"
                class="form-control ${hasErrors(bean: car, field: 'brand', 'is-invalid')}"/>

            <div class="text-danger">

                <g:fieldError
                    bean="${car}"
                    field="brand"/>

            </div>

        </div>


        <!-- Model -->
        <div class="mb-3">

            <label
                for="model"
                class="form-label">

                Model

            </label>

            <g:textField
                name="model"
                value="${car?.model}"
                class="form-control ${hasErrors(bean: car, field: 'model', 'is-invalid')}"/>

            <div class="text-danger">

                <g:fieldError
                    bean="${car}"
                    field="model"/>

            </div>

        </div>


        <!-- Year -->
        <div class="mb-3">

            <label
                for="year"
                class="form-label">

                Year

            </label>

            <g:field
                type="number"
                name="year"
                value="${car?.year}"
                min="1900"
                class="form-control ${hasErrors(bean: car, field: 'year', 'is-invalid')}"/>

            <div class="text-danger">

                <g:fieldError
                    bean="${car}"
                    field="year"/>

            </div>

        </div>


        <!-- Plate Number -->
        <div class="mb-3">

            <label
                for="plateNumber"
                class="form-label">

                Plate Number

            </label>

            <g:textField
                name="plateNumber"
                value="${car?.plateNumber}"
                class="form-control ${hasErrors(bean: car, field: 'plateNumber', 'is-invalid')}"/>

            <div class="text-danger">

                <g:fieldError
                    bean="${car}"
                    field="plateNumber"/>

            </div>

        </div>


        <!-- Price Per Day -->
        <div class="mb-3">

            <label
                for="pricePerDay"
                class="form-label">

                Price Per Day

            </label>

            <g:field
                type="number"
                step="0.01"
                min="0"
                name="pricePerDay"
                value="${car?.pricePerDay}"
                class="form-control ${hasErrors(bean: car, field: 'pricePerDay', 'is-invalid')}"/>

            <div class="text-danger">

                <g:fieldError
                    bean="${car}"
                    field="pricePerDay"/>

            </div>

        </div>


        <!-- Status -->
        <div class="mb-3">

            <label
                for="status"
                class="form-label">

                Status

            </label>

            <g:select
                name="status"
                from="${['AVAILABLE', 'RENTED', 'MAINTENANCE']}"
                value="${car?.status ?: 'AVAILABLE'}"
                class="form-select"/>

            <div class="text-danger">

                <g:fieldError
                    bean="${car}"
                    field="status"/>

            </div>

        </div>


        <!-- Car Image -->
        <div class="mb-4">

            <label
                for="carImage"
                class="form-label">

                Car Image

            </label>

            <input
                type="file"
                name="carImage"
                id="carImage"
                class="form-control"
                accept="image/*"/>

            <small class="text-muted">
                JPG, PNG or WEBP. Maximum size: 10MB.
            </small>

        </div>


        <!-- Buttons -->
        <button
            type="submit"
            class="btn btn-primary">

            Save Car

        </button>


        <g:link
            action="index"
            class="btn btn-secondary">

            Cancel

        </g:link>


    </g:uploadForm>

</div>

</body>
</html>