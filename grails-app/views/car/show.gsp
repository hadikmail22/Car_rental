<!doctype html>
<html>

<head>

    <meta name="layout" content="main"/>
    <title>Car Details</title>

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


        .car-show-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
            max-width:760px;
        }


        .car-show-page h2{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            letter-spacing:-0.01em;
            color:var(--asphalt-900);
        }


        .btn-outline-secondary{
            border-radius:8px;
            border-color:var(--hairline);
            color:var(--ink-soft);
        }


        .btn-outline-secondary:hover,
        .btn-outline-secondary:focus-visible{
            background:var(--asphalt-900);
            border-color:var(--asphalt-900);
            color:#fff;
        }


        .alert-info{
            background:#fff6e6;
            border:1px solid #f0d9a6;
            color:#7a5a10;
            border-radius:8px;
        }


        .alert-secondary{
            background:var(--paper);
            border:1px dashed var(--hairline);
            border-radius:12px;
            color:var(--ink-soft);
        }


        /* ---------- Main Image ---------- */

        .car-image-frame{
            display:inline-block;
            padding:0.6rem;
            background:#fff;
            border:1px solid var(--hairline);
            border-radius:12px;
            transition:
                box-shadow 0.2s ease,
                transform 0.2s ease;
        }


        .car-image-frame img{
            border-radius:8px;
            border:none !important;
            display:block;
        }


        .car-image-frame:hover{
            box-shadow:0 8px 22px rgba(16,17,20,0.10);
            transform:translateY(-2px);
        }


        /* ---------- Gallery ---------- */

        .gallery-section{
            margin-bottom:2rem;
        }


        .gallery-heading{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:1rem;
        }


        .gallery-title{
            font-family:'Space Grotesk', sans-serif;
            font-size:1rem;
            font-weight:700;
            margin:0;
            color:var(--asphalt-900);
        }


        .gallery-count{
            font-family:'JetBrains Mono', monospace;
            font-size:0.7rem;
            color:var(--ink-soft);
            background:var(--paper);
            border:1px solid var(--hairline);
            border-radius:999px;
            padding:0.3rem 0.65rem;
        }


        .car-gallery{
            display:grid;
            grid-template-columns:repeat(3, 1fr);
            gap:0.85rem;
        }


        .gallery-item{
            display:block;
            position:relative;
            overflow:hidden;
            border-radius:10px;
            border:1px solid var(--hairline);
            background:#fff;
            aspect-ratio:4 / 3;
            text-decoration:none;
        }


        .gallery-item img{
            width:100%;
            height:100%;
            object-fit:cover;
            display:block;
            transition:
                transform 0.25s ease,
                filter 0.25s ease;
        }


        .gallery-item::after{
            content:"View";
            position:absolute;
            left:50%;
            top:50%;
            transform:translate(-50%, -50%);
            background:rgba(16,17,20,0.82);
            color:#fff;
            font-family:'JetBrains Mono', monospace;
            font-size:0.68rem;
            letter-spacing:0.06em;
            text-transform:uppercase;
            padding:0.45rem 0.7rem;
            border-radius:6px;
            opacity:0;
            transition:opacity 0.2s ease;
        }


        .gallery-item:hover img{
            transform:scale(1.06);
            filter:brightness(0.78);
        }


        .gallery-item:hover::after{
            opacity:1;
        }


        /* ---------- Info Card ---------- */

        .car-info-card{
            border:1px solid var(--hairline) !important;
            border-radius:14px;
        }


        .car-info-card .card-title{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
        }


        .spec-row{
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:0.85rem 0;
            border-bottom:1px solid var(--hairline);
        }


        .spec-row:last-child{
            border-bottom:none;
        }


        .spec-label{
            font-family:'JetBrains Mono', monospace;
            font-size:0.72rem;
            font-weight:600;
            letter-spacing:0.08em;
            text-transform:uppercase;
            color:var(--ink-soft);
        }


        .spec-value{
            font-weight:600;
            color:var(--ink);
            text-align:right;
        }


        .spec-value.mono{
            font-family:'JetBrains Mono', monospace;
            font-weight:500;
        }


        .spec-value.price{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            font-size:1.05rem;
        }


        /* ---------- Status ---------- */

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


        .status-available::before{
            background:var(--go-green);
            box-shadow:0 0 6px var(--go-green);
        }


        .status-rented{
            background:#eaf1fb;
            color:#2560c4;
        }


        .status-rented::before{
            background:#2560c4;
            box-shadow:0 0 6px #2560c4;
        }


        .status-maintenance{
            background:#fff3e0;
            color:var(--headlight-dim);
        }


        .status-maintenance::before{
            background:var(--headlight);
            box-shadow:0 0 6px var(--headlight);
        }


        /* ---------- Actions ---------- */

        .btn-warning{
            background:var(--headlight);
            border:none;
            color:var(--asphalt-900);
            font-weight:600;
            border-radius:8px;
        }


        .btn-warning:hover,
        .btn-warning:focus-visible{
            background:var(--headlight-dim);
            color:var(--asphalt-900);
        }


        .btn-danger{
            background:var(--brake-red);
            border:none;
            font-weight:600;
            border-radius:8px;
        }


        .btn-danger:hover,
        .btn-danger:focus-visible{
            background:#a3291d;
        }


        /* ---------- Responsive ---------- */

        @media (max-width:768px){

            .car-gallery{
                grid-template-columns:repeat(2, 1fr);
            }

        }


        @media (max-width:480px){

            .car-gallery{
                grid-template-columns:1fr;
            }

        }

    </style>

</head>


<body>


<div class="container mt-4 car-show-page">


    <!-- Header -->

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2>
            Car Details
        </h2>

        <g:link
            action="index"
            class="btn btn-outline-secondary">

            Back to Cars

        </g:link>

    </div>



    <!-- Flash Message -->

    <g:if test="${flash.message}">

        <div class="alert alert-info">

            ${flash.message}

        </div>

    </g:if>



    <!-- Main Car Image -->

    <g:if test="${car?.carImage}">

        <div class="mb-4 text-center">

            <a
                href="${createLink(
                        controller: 'car',
                        action: 'image',
                        id: car.id
                )}"
                target="_blank">

                <span class="car-image-frame">

                    <img
                        src="${createLink(
                                controller: 'car',
                                action: 'image',
                                id: car.id
                        )}"
                        alt="${car.brand} ${car.model}"
                        style="
                            width:350px;
                            height:230px;
                            object-fit:cover;
                            cursor:pointer;
                        "/>

                </span>

            </a>

        </div>

    </g:if>
    <g:else>

        <div class="alert alert-secondary">

            No main image uploaded for this car.

        </div>

    </g:else>



    <!-- Additional Images Gallery -->

    <g:if test="${car?.galleryImages && car.galleryImages.size() > 0}">

        <div class="gallery-section">

            <div class="gallery-heading">

                <h5 class="gallery-title">
                    Car Gallery
                </h5>

                <span class="gallery-count">

                    ${car.galleryImages.size()}
                    photos

                </span>

            </div>


            <div class="car-gallery">

                <g:each
                    in="${car.galleryImages.sort { it.id }}"
                    var="galleryImage">

                    <a
                        href="${createLink(
                                controller: 'car',
                                action: 'galleryImage',
                                id: galleryImage.id
                        )}"
                        target="_blank"
                        class="gallery-item">

                        <img
                            src="${createLink(
                                    controller: 'car',
                                    action: 'galleryImage',
                                    id: galleryImage.id
                            )}"
                            alt="${car.brand} ${car.model} gallery image"/>

                    </a>

                </g:each>

            </div>

        </div>

    </g:if>



    <!-- Car Information -->

    <div class="card shadow-sm car-info-card">

        <div class="card-body">


            <h4 class="card-title mb-4">

                ${car.brand} ${car.model}

            </h4>


            <div class="spec-row">

                <span class="spec-label">
                    Brand
                </span>

                <span class="spec-value">
                    ${car.brand}
                </span>

            </div>


            <div class="spec-row">

                <span class="spec-label">
                    Category
                </span>

                <span class="spec-value">
                    ${car.category?.name ?: 'Not assigned'}
                </span>

            </div>


            <div class="spec-row">

                <span class="spec-label">
                    Model
                </span>

                <span class="spec-value">
                    ${car.model}
                </span>

            </div>


            <div class="spec-row">

                <span class="spec-label">
                    Year
                </span>

                <span class="spec-value mono">
                    ${car.year}
                </span>

            </div>


            <div class="spec-row">

                <span class="spec-label">
                    Plate Number
                </span>

                <span class="spec-value mono">
                    ${car.plateNumber}
                </span>

            </div>


            <div class="spec-row">

                <span class="spec-label">
                    Price Per Day
                </span>

                <span class="spec-value price">

                    ${car.pricePerDay}

                </span>

            </div>


            <div class="spec-row">

                <span class="spec-label">
                    Status
                </span>


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


        </div>

    </div>



    <!-- Actions -->

    <div class="mt-4 d-flex gap-2">


        <sec:ifAllGranted roles="ROLE_ADMIN">


            <g:link
                action="edit"
                id="${car.id}"
                class="btn btn-warning">

                Edit

            </g:link>


            <g:form
                action="delete"
                id="${car.id}"
                method="DELETE"
                class="d-inline">

                <button
                    type="submit"
                    class="btn btn-danger"
                    onclick="return confirm('Are you sure you want to delete this car?');">

                    Delete

                </button>

            </g:form>


        </sec:ifAllGranted>


    </div>


</div>


</body>

</html>
