<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Cars</title>

    <style>
        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --taillight:#e5484d;
            --brake-red:#c0392b;
            --go-green:#1f8a52;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }

        .cars-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
        }

        /* ---------- Header ---------- */
        .cars-header h2{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            letter-spacing:-0.01em;
            color:var(--asphalt-900);
        }

        .cars-header .text-muted{
            color:var(--ink-soft) !important;
            font-size:0.95rem;
        }

        .btn-headlight{
            background:var(--headlight);
            border:none;
            color:var(--asphalt-900);
            font-weight:600;
            letter-spacing:0.01em;
            padding:0.55rem 1.2rem;
            border-radius:8px;
            transition:background-color .15s ease, transform .1s ease;
        }

        .btn-headlight:hover,
        .btn-headlight:focus-visible{
            background:var(--headlight-dim);
            color:var(--asphalt-900);
            transform:translateY(-1px);
        }

        /* ---------- Flash ---------- */
        .alert-info{
            background:#fff6e6;
            border:1px solid #f0d9a6;
            color:#7a5a10;
            border-radius:8px;
        }

        /* ---------- Search card ---------- */
        .search-card{
            border:1px solid var(--hairline) !important;
            border-radius:12px;
        }

        .search-card .form-control{
            border-radius:8px;
            border-color:var(--hairline);
            padding:0.6rem 0.9rem;
        }

        .search-card .form-control:focus{
            border-color:var(--headlight);
            box-shadow:0 0 0 0.2rem rgba(245,166,35,0.18);
        }

        .btn-dark{
            background:var(--asphalt-900);
            border:none;
            border-radius:8px;
            font-weight:600;
        }

        .btn-dark:hover,
        .btn-dark:focus-visible{
            background:var(--asphalt-800);
        }

        .btn-outline-secondary{
            border-radius:8px;
            border-color:var(--hairline);
            color:var(--ink-soft);
        }

        .btn-outline-secondary:hover{
            background:var(--asphalt-900);
            border-color:var(--asphalt-900);
        }

        /* ---------- Car cards ---------- */
        .car-card{
            border:1px solid var(--hairline) !important;
            border-radius:14px;
            transition:box-shadow .15s ease;
        }

        .car-card:hover{
            box-shadow:0 10px 28px rgba(16,17,20,0.10);
        }

        .car-image-wrap{
            position:relative;
        }

        .no-image-box{
            height:300px;
            background:repeating-linear-gradient(
                135deg,
                #f0efeb,
                #f0efeb 10px,
                #f6f5f2 10px,
                #f6f5f2 20px
            );
        }

        .no-image-box span{
            font-family:'JetBrains Mono', monospace;
            font-size:0.8rem;
            letter-spacing:0.04em;
            text-transform:uppercase;
            color:#a9a7a0;
        }

        .car-title{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
        }

        .car-year{
            font-family:'JetBrains Mono', monospace;
            font-size:0.82rem;
            letter-spacing:0.02em;
        }

        /* Status badges — signature detail: dashboard-light styling */
        .status-badge{
            font-family:'JetBrains Mono', monospace;
            font-weight:600;
            font-size:0.72rem;
            letter-spacing:0.06em;
            padding:0.4rem 0.7rem;
            border-radius:999px;
            display:inline-flex;
            align-items:center;
            gap:0.4rem;
        }

        .status-badge::before{
            content:"";
            width:7px;
            height:7px;
            border-radius:50%;
            display:inline-block;
        }

        .status-available{
            background:#e8f6ee;
            color:var(--go-green);
        }
        .status-available::before{ background:var(--go-green); box-shadow:0 0 6px var(--go-green); }

        .status-rented{
            background:#eaf1fb;
            color:#2560c4;
        }
        .status-rented::before{ background:#2560c4; box-shadow:0 0 6px #2560c4; }

        .status-maintenance{
            background:#fff3e0;
            color:var(--headlight-dim);
        }
        .status-maintenance::before{ background:var(--headlight); box-shadow:0 0 6px var(--headlight); }

        hr{
            border-color:var(--hairline);
            opacity:1;
        }

        .detail-label{
            font-size:0.72rem;
            letter-spacing:0.05em;
            text-transform:uppercase;
            color:var(--ink-soft) !important;
        }

        .detail-value{
            font-family:'JetBrains Mono', monospace;
            color:var(--asphalt-900);
        }

        .price-value{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
        }

        /* ---------- Action buttons ---------- */
        .btn-primary{
            background:var(--asphalt-900);
            border:none;
            border-radius:8px;
            font-weight:600;
        }
        .btn-primary:hover,
        .btn-primary:focus-visible{
            background:var(--asphalt-800);
        }

        .btn-outline-warning{
            border-radius:8px;
            border-color:var(--headlight);
            color:var(--headlight-dim);
            font-weight:600;
        }
        .btn-outline-warning:hover,
        .btn-outline-warning:focus-visible{
            background:var(--headlight);
            border-color:var(--headlight);
            color:var(--asphalt-900);
        }

        .btn-success{
            background:var(--go-green);
            border:none;
            border-radius:8px;
            font-weight:600;
        }
        .btn-success:hover,
        .btn-success:focus-visible{
            background:#186f42;
        }

        .btn-secondary[disabled]{
            border-radius:8px;
            background:#e4e2dc;
            border:none;
            color:#a9a7a0;
        }

        /* ---------- Empty state ---------- */
        .alert-secondary{
            background:var(--paper);
            border:1px dashed var(--hairline);
            border-radius:12px;
            color:var(--ink-soft);
            padding:2rem;
        }

        /* ---------- Pagination ---------- */
        .cars-page .pagination a,
        .cars-page nav a{
            color:var(--asphalt-900);
        }
    </style>
</head>

<body>

<div class="container mt-4 cars-page">

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 cars-header flex-wrap gap-3">

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
                class="btn btn-headlight">

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
    <div class="card shadow-sm mb-4 search-card">

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

                    <div class="card shadow-sm border-0 overflow-hidden car-card">

                        <div class="row g-0 align-items-stretch">


                            <!-- Car Image -->
                            <div class="col-md-5">

                                <g:if test="${car?.carImage}">

                                    <div class="car-image-wrap">

                                        <img
                                            src="${createLink(
                                                controller: 'car',
                                                action: 'image',
                                                id: car.id
                                            )}"
                                            alt="${car.brand} ${car.model}"
                                            class="img-fluid car-thumbnail"
                                            data-bs-toggle="modal"
                                            data-bs-target="#carImageModal${car.id}"
                                            style="
                                                width:100%;
                                                height:300px;
                                                object-fit:contain;
                                                background:#f8f9fa;
                                                cursor:pointer;
                                            "/>

                                    </div>


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
                                                        class="img-fluid rounded modal-car-image"
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
                                        class="no-image-box d-flex align-items-center justify-content-center">

                                        <span>
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

                                            <h3 class="card-title mb-1 car-title">
                                                ${car.brand} ${car.model}
                                            </h3>

                                            <p class="text-muted mb-0 car-year">
                                                Model Year: ${car.year}
                                            </p>

                                        </div>


                                        <!-- Status -->
                                        <g:if test="${car.status == 'AVAILABLE'}">

                                            <span class="status-badge status-available">
                                                AVAILABLE
                                            </span>

                                        </g:if>
                                        <g:elseif test="${car.status == 'RENTED'}">

                                            <span class="status-badge status-rented">
                                                RENTED
                                            </span>

                                        </g:elseif>
                                        <g:else>

                                            <span class="status-badge status-maintenance">
                                                MAINTENANCE
                                            </span>

                                        </g:else>

                                    </div>


                                    <hr/>


                                    <!-- Details -->
                                    <div class="row mb-3">

                                        <div class="col-sm-6 mb-3">

                                            <small class="text-muted d-block detail-label">
                                                Plate Number
                                            </small>

                                            <strong class="detail-value">
                                                ${car.plateNumber}
                                            </strong>

                                        </div>


                                        <div class="col-sm-6 mb-3">

                                            <small class="text-muted d-block detail-label">
                                                Price Per Day
                                            </small>

                                            <strong class="fs-5 price-value">
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
