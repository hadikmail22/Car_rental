<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Cars</title>
</head>

<body>

<div class="container mt-4">

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>
            <h2 class="mb-1">Cars</h2>

            <sec:ifAllGranted roles="ROLE_ADMIN">
                <p class="text-muted mb-0">
                    Browse and manage rental vehicles
                </p>
            </sec:ifAllGranted>

            <sec:ifAllGranted roles="ROLE_CUSTOMER">
                <p class="text-muted mb-0">
                    Browse available rental vehicles
                </p>
            </sec:ifAllGranted>
        </div>


        <!-- Admin Only -->
        <sec:ifAllGranted roles="ROLE_ADMIN">

            <g:link
                action="create"
                class="btn btn-primary">

                Add New Car

            </g:link>

        </sec:ifAllGranted>

    </div>


    <!-- Flash Message -->
    <g:if test="${flash.message}">

        <div class="alert alert-info">
            ${flash.message}
        </div>

    </g:if>


    <!-- Search -->
    <div class="card shadow-sm mb-4">

        <div class="card-body">

            <g:form
                action="index"
                method="GET"
                class="row g-2">

                <div class="col-md-8">

                    <input
                        type="text"
                        name="q"
                        value="${q}"
                        class="form-control"
                        placeholder="Search by brand, model, or plate number"/>

                </div>


                <div class="col-md-2">

                    <button
                        type="submit"
                        class="btn btn-dark w-100">

                        Search

                    </button>

                </div>


                <div class="col-md-2">

                    <g:link
                        action="index"
                        class="btn btn-outline-secondary w-100">

                        Clear

                    </g:link>

                </div>

            </g:form>

        </div>

    </div>


    <!-- Cars -->
    <g:if test="${carList}">

        <div class="row g-4">

            <g:each in="${carList}" var="car">

                <div class="col-12">

                    <div class="card shadow-sm border-0 overflow-hidden">

                        <div class="row g-0 align-items-stretch">


                            <!-- Car Image -->
                            <div class="col-md-5">

                                <g:if test="${car?.carImage}">

                                    <img
                                        src="${createLink(
                                            controller: 'car',
                                            action: 'image',
                                            id: car.id
                                        )}"
                                        alt="${car.brand} ${car.model}"
                                        class="img-fluid"
                                        data-bs-toggle="modal"
                                        data-bs-target="#carImageModal${car.id}"
                                        style="
                                            width:100%;
                                            height:300px;
                                            object-fit:contain;
                                            background:#f8f9fa;
                                            cursor:pointer;
                                        "/>


                                    <!-- Image Modal -->
                                    <div
                                        class="modal fade"
                                        id="carImageModal${car.id}"
                                        tabindex="-1"
                                        aria-hidden="true">

                                        <div class="modal-dialog modal-xl modal-dialog-centered">

                                            <div class="modal-content">

                                                <div class="modal-header">

                                                    <h5 class="modal-title">
                                                        ${car.brand} ${car.model}
                                                    </h5>

                                                    <button
                                                        type="button"
                                                        class="btn-close"
                                                        data-bs-dismiss="modal">
                                                    </button>

                                                </div>


                                                <div class="modal-body text-center">

                                                    <img
                                                        src="${createLink(
                                                            controller: 'car',
                                                            action: 'image',
                                                            id: car.id
                                                        )}"
                                                        alt="${car.brand} ${car.model}"
                                                        class="img-fluid rounded"
                                                        style="
                                                            max-height:75vh;
                                                            object-fit:contain;
                                                        "/>

                                                </div>


                                                <div class="modal-footer">

                                                    <button
                                                        type="button"
                                                        class="btn btn-secondary"
                                                        data-bs-dismiss="modal">

                                                        Close

                                                    </button>

                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                </g:if>
                                <g:else>

                                    <div
                                        class="bg-light d-flex align-items-center justify-content-center"
                                        style="height:300px;">

                                        <span class="text-muted">
                                            No Image Available
                                        </span>

                                    </div>

                                </g:else>

                            </div>


                            <!-- Car Information -->
                            <div class="col-md-7">

                                <div class="card-body h-100 d-flex flex-column p-4">


                                    <!-- Title + Status -->
                                    <div class="d-flex justify-content-between align-items-start mb-3">

                                        <div>

                                            <h3 class="card-title mb-1">
                                                ${car.brand} ${car.model}
                                            </h3>

                                            <p class="text-muted mb-0">
                                                Model Year: ${car.year}
                                            </p>

                                        </div>


                                        <!-- Status -->
                                        <g:if test="${car.status == 'AVAILABLE'}">

                                            <span class="badge bg-success fs-6">
                                                AVAILABLE
                                            </span>

                                        </g:if>
                                        <g:elseif test="${car.status == 'RENTED'}">

                                            <span class="badge bg-primary fs-6">
                                                RENTED
                                            </span>

                                        </g:elseif>
                                        <g:else>

                                            <span class="badge bg-warning text-dark fs-6">
                                                MAINTENANCE
                                            </span>

                                        </g:else>

                                    </div>


                                    <hr/>


                                    <!-- Details -->
                                    <div class="row mb-3">

                                        <div class="col-sm-6 mb-3">

                                            <small class="text-muted d-block">
                                                Plate Number
                                            </small>

                                            <strong>
                                                ${car.plateNumber}
                                            </strong>

                                        </div>


                                        <div class="col-sm-6 mb-3">

                                            <small class="text-muted d-block">
                                                Price Per Day
                                            </small>

                                            <strong class="fs-5">
                                                ${car.pricePerDay}
                                            </strong>

                                        </div>

                                    </div>


                                    <!-- Actions -->
                                    <div class="mt-auto d-flex gap-2 flex-wrap">


                                        <!-- Everyone -->
                                        <g:link
                                            action="show"
                                            id="${car.id}"
                                            class="btn btn-primary">

                                            View Details

                                        </g:link>


                                        <!-- Admin Only -->
                                        <sec:ifAllGranted roles="ROLE_ADMIN">

                                            <g:link
                                                action="edit"
                                                id="${car.id}"
                                                class="btn btn-outline-warning">

                                                Edit

                                            </g:link>

                                        </sec:ifAllGranted>


                                        <!-- Customer Only -->
                                        <sec:ifAllGranted roles="ROLE_CUSTOMER">

                                            <g:if test="${car.status != 'MAINTENANCE'}">

                                                <g:link
                                                    controller="rental"
                                                    action="create"
                                                    params="[carId: car.id]"
                                                    class="btn btn-success">

                                                    Rent Now

                                                </g:link>

                                            </g:if>
                                            <g:else>

                                                <button
                                                    type="button"
                                                    class="btn btn-secondary"
                                                    disabled>

                                                    Unavailable

                                                </button>

                                            </g:else>

                                        </sec:ifAllGranted>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </g:each>

        </div>

    </g:if>
    <g:else>

        <div class="alert alert-secondary text-center">
            No cars found.
        </div>

    </g:else>


    <!-- Pagination -->
    <div class="d-flex justify-content-center mt-5">

        <g:paginate
            total="${carCount ?: 0}"
            max="5"
            params="[q: q]"/>

    </div>

</div>

</body>
</html>