<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Edit Car</title>

    <style>
        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --taillight:#e5484d;
            --brake-red:#c0392b;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }

        .car-form-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
            max-width:760px;
        }

        .car-form-page h2{
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
        }

        .alert-danger{
            background:#fdecea;
            border:1px solid #f3b8b2;
            color:var(--brake-red);
            border-radius:8px;
        }

        /* ---------- Form card ---------- */
        .car-form-card{
            background:#fff;
            border:1px solid var(--hairline);
            border-radius:14px;
            padding:2rem;
        }

        .field-group{
            margin-bottom:1.5rem;
            position:relative;
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

        .form-control,
        .form-select{
            border:1px solid var(--hairline);
            border-radius:8px;
            padding:0.6rem 0.9rem;
            font-size:0.98rem;
            color:var(--ink);
        }

        .form-control:focus,
        .form-select:focus{
            border-color:var(--headlight);
            box-shadow:0 0 0 0.2rem rgba(245,166,35,0.18);
        }

        .form-control.is-invalid,
        .form-select.is-invalid{
            border-color:var(--taillight);
        }

        .form-control.is-invalid:focus{
            box-shadow:0 0 0 0.2rem rgba(229,72,77,0.18);
        }

        .text-danger{
            font-size:0.82rem;
            margin-top:0.3rem;
        }

        /* ---------- Current image ---------- */
        .current-image-box{
            background:var(--paper);
            border:1px solid var(--hairline);
            border-radius:10px;
            padding:1rem;
            display:inline-block;
        }

        .current-image-box img{
            border-radius:6px;
            border:1px solid var(--hairline) !important;
            background:#fff;
        }

        /* ---------- Image uploader ---------- */
        .image-upload-box{
            border:1.5px dashed var(--hairline);
            border-radius:10px;
            padding:1.25rem;
            background:repeating-linear-gradient(
                135deg,
                #faf9f6,
                #faf9f6 10px,
                #f6f5f2 10px,
                #f6f5f2 20px
            );
        }

        .image-upload-box:focus-within{
            border-color:var(--headlight);
        }

        .image-upload-box input[type="file"]{
            border:none;
            background:transparent;
            padding-left:0;
        }

        .image-upload-box small{
            font-family:'JetBrains Mono', monospace;
            font-size:0.72rem;
            letter-spacing:0.02em;
            color:#a9a7a0;
        }

        /* ---------- Buttons ---------- */
        .form-actions{
            display:flex;
            gap:0.75rem;
            margin-top:0.5rem;
            padding-top:1.5rem;
            border-top:1px solid var(--hairline);
        }

        .btn-primary{
            background:var(--asphalt-900);
            border:none;
            border-radius:8px;
            font-weight:600;
            padding:0.6rem 1.4rem;
        }
        .btn-primary:hover,
        .btn-primary:focus-visible{
            background:var(--asphalt-800);
        }

        .btn-secondary{
            background:transparent;
            border:1px solid var(--hairline);
            color:var(--ink-soft);
            border-radius:8px;
            font-weight:600;
            padding:0.6rem 1.4rem;
        }
        .btn-secondary:hover,
        .btn-secondary:focus-visible{
            background:var(--paper);
            color:var(--ink);
            border-color:var(--hairline);
        }
    </style>
</head>
<script>
function previewImage(input) {

    if (input.files && input.files[0]) {

        const reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById('imagePreview').src = e.target.result;
        };

        reader.readAsDataURL(input.files[0]);
    }
}
</script>
<body>

<div class="container mt-4 car-form-page">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Edit Car</h2>

        <g:link
            action="show"
            id="${car.id}"
            class="btn btn-outline-secondary">
            Back
        </g:link>
    </div>


    <g:if test="${flash.message}">
        <div class="alert alert-danger">
            ${flash.message}
        </div>
    </g:if>


    <g:hasErrors bean="${car}">
        <div class="alert alert-danger">
            Please correct the errors below.
        </div>
    </g:hasErrors>


    <div class="car-form-card">

    <g:uploadForm
        action="update"
        id="${car.id}"
        method="PUT">


        <!-- Current Image -->
        <g:if test="${car?.carImage}">

            <div class="mb-4 field-group">

                <label class="form-label">
                    Current Image
                </label>

                <div class="current-image-box">
                    <img
    id="imagePreview"
    src="${createLink(controller: 'car', action: 'image', id: car.id)}"
    alt="${car.brand} ${car.model}"
    class="img-thumbnail"
    style="
        width:350px;
        height:230px;
        object-fit:contain;
    "/>
                </div>

            </div>

        </g:if>


        <!-- New Image -->
        <div class="mb-4 field-group">

            <label
                for="carImage"
                class="form-label">

                Change Car Image

            </label>

            <div class="image-upload-box">

              <input
    type="file"
    name="newCarImage"
    id="newCarImage"
    class="form-control"
    accept="image/*"
    onchange="previewImage(this)"/>

                <small class="text-muted d-block mt-2">
                    Leave empty to keep the current image.
                    Maximum size: 10MB.
                </small>

            </div>

        </div>


        <!-- Brand -->
        <div class="mb-3 field-group">

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
                <g:fieldError bean="${car}" field="brand"/>
            </div>

        </div>


        <!-- Model -->
        <div class="mb-3 field-group">

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
                <g:fieldError bean="${car}" field="model"/>
            </div>

        </div>


        <!-- Year -->
        <div class="mb-3 field-group">

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
                <g:fieldError bean="${car}" field="year"/>
            </div>

        </div>


        <!-- Plate Number -->
        <div class="mb-3 field-group">

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
                <g:fieldError bean="${car}" field="plateNumber"/>
            </div>

        </div>


        <!-- Price -->
        <div class="mb-3 field-group">

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
                <g:fieldError bean="${car}" field="pricePerDay"/>
            </div>

        </div>


        <!-- Status -->
        <div class="mb-3 field-group">

            <label
                for="status"
                class="form-label">
                Status
            </label>

            <g:select
                name="status"
                from="${['AVAILABLE', 'RENTED', 'MAINTENANCE']}"
                value="${car?.status}"
                class="form-select"/>

        </div>


        <!-- Buttons -->
        <div class="form-actions">

            <button
                type="submit"
                class="btn btn-primary">

                Update Car

            </button>


            <g:link
                action="show"
                id="${car.id}"
                class="btn btn-secondary">

                Cancel

            </g:link>

        </div>

    </g:uploadForm>

    </div>

</div>

</body>
</html>
