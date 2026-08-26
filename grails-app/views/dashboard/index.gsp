<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>
</head>

<body>

<div class="container mt-4">

    <div class="mb-4">
        <h2>Dashboard</h2>
        <p class="text-muted">
            Car Rental Management Overview
        </p>
    </div>


    <div class="row g-4">

        <!-- Total Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body">

                    <h6 class="text-muted">
                        Total Cars
                    </h6>

                    <h2 class="fw-bold">
                        ${totalCars ?: 0}
                    </h2>

                    <g:link
                        controller="car"
                        action="index"
                        class="btn btn-outline-primary btn-sm mt-2">

                        View Cars

                    </g:link>

                </div>

            </div>

        </div>


        <!-- Available Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body">

                    <h6 class="text-muted">
                        Available Cars
                    </h6>

                    <h2 class="fw-bold text-success">
                        ${availableCars ?: 0}
                    </h2>

                    <span class="badge bg-success">
                        AVAILABLE
                    </span>

                </div>

            </div>

        </div>


        <!-- Rented Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body">

                    <h6 class="text-muted">
                        Rented Cars
                    </h6>

                    <h2 class="fw-bold text-primary">
                        ${rentedCars ?: 0}
                    </h2>

                    <span class="badge bg-primary">
                        RENTED
                    </span>

                </div>

            </div>

        </div>


        <!-- Maintenance Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body">

                    <h6 class="text-muted">
                        Maintenance
                    </h6>

                    <h2 class="fw-bold text-warning">
                        ${maintenanceCars ?: 0}
                    </h2>

                    <span class="badge bg-warning text-dark">
                        MAINTENANCE
                    </span>

                </div>

            </div>

        </div>

    </div>


    <!-- Quick Actions -->
    <div class="card shadow-sm border-0 mt-5">

        <div class="card-body">

            <h4 class="mb-3">
                Quick Actions
            </h4>

            <g:link
                controller="car"
                action="create"
                class="btn btn-primary me-2">

                Add New Car

            </g:link>

            <g:link
                controller="car"
                action="index"
                class="btn btn-outline-secondary">

                Manage Cars

            </g:link>

        </div>

    </div>

</div>

</body>
</html>
