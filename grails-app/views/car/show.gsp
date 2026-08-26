<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Car Details</title>
</head>

<body>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Car Details</h2>

        <g:link action="index" class="btn btn-outline-secondary">
            Back to Cars
        </g:link>
    </div>


    <!-- Flash Message -->
    <g:if test="${flash.message}">
        <div class="alert alert-info">
            ${flash.message}
        </div>
    </g:if>


    <!-- Car Image -->
    <g:if test="${car?.carImage}">
        <div class="mb-4 text-center">

            <a
    href="${createLink(controller: 'car', action: 'image', id: car.id)}"
    target="_blank">

    <img
        src="${createLink(controller: 'car', action: 'image', id: car.id)}"
        alt="${car.brand} ${car.model}"
        class="img-thumbnail"
        style="
            width:350px;
            height:230px;
            object-fit:cover;
            cursor:pointer;
        "/>

</a>

        </div>
    </g:if>

    <g:else>
        <div class="alert alert-secondary">
            No image uploaded for this car.
        </div>
    </g:else>


    <!-- Car Information -->
    <div class="card shadow-sm">

        <div class="card-body">

            <h4 class="card-title mb-4">
                ${car.brand} ${car.model}
            </h4>

            <p>
                <strong>Brand:</strong>
                ${car.brand}
            </p>

            <p>
                <strong>Model:</strong>
                ${car.model}
            </p>

            <p>
                <strong>Year:</strong>
                ${car.year}
            </p>

            <p>
                <strong>Plate Number:</strong>
                ${car.plateNumber}
            </p>

            <p>
                <strong>Price Per Day:</strong>
                ${car.pricePerDay}
            </p>

            <p>
                <strong>Status:</strong>

                <span class="badge bg-secondary">
                    ${car.status}
                </span>
            </p>

        </div>
    </div>


    <!-- Actions -->
    <div class="mt-4">

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