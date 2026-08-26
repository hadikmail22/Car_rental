<!doctype html>
<html>

<head>
    <meta name="layout" content="main"/>
    <title>Rent Car</title>
</head>

<body>

<div class="container mt-4">

    <div class="mb-4">

        <h2>
            Rent ${car.brand} ${car.model}
        </h2>

        <p class="text-muted">
            Select your rental dates
        </p>

    </div>


    <!-- Error Message -->
    <g:if test="${flash.message}">
        <div class="alert alert-danger">
            ${flash.message}
        </div>
    </g:if>


    <!-- Car Information -->
    <div class="card shadow-sm border-0 mb-4">

        <div class="row g-0">

            <!-- Image -->
            <div class="col-md-5">

                <g:if test="${car?.carImage}">

                    <img
                        src="${createLink(
                            controller: 'car',
                            action: 'image',
                            id: car.id
                        )}"
                        alt="${car.brand} ${car.model}"
                        style="
                            width:100%;
                            height:280px;
                            object-fit:contain;
                            background:#f8f9fa;
                        "/>

                </g:if>
                <g:else>

                    <div
                        class="bg-light d-flex align-items-center justify-content-center"
                        style="height:280px;">

                        <span class="text-muted">
                            No Image Available
                        </span>

                    </div>

                </g:else>

            </div>


            <!-- Car Details -->
            <div class="col-md-7">

                <div class="card-body p-4">

                    <h3 class="mb-4">
                        ${car.brand} ${car.model}
                    </h3>

                    <p>
                        <strong>Year:</strong>
                        ${car.year}
                    </p>

                    <p>
                        <strong>Plate:</strong>
                        ${car.plateNumber}
                    </p>

                    <p>
                        <strong>Price Per Day:</strong>
                        ${car.pricePerDay}
                    </p>

                    <p>
                        <strong>Status:</strong>

                        <g:if test="${car.status == 'AVAILABLE'}">
                            <span class="badge bg-success">
                                AVAILABLE
                            </span>
                        </g:if>
                        <g:elseif test="${car.status == 'RENTED'}">
                            <span class="badge bg-primary">
                                RENTED
                            </span>
                        </g:elseif>
                        <g:else>
                            <span class="badge bg-warning text-dark">
                                ${car.status}
                            </span>
                        </g:else>

                    </p>

                </div>

            </div>

        </div>

    </div>


    <!-- Rental Form -->
    <div class="card shadow-sm border-0">

        <div class="card-body p-4">

            <h4 class="mb-4">
                Rental Details
            </h4>


            <!-- Booked Dates -->
            <div class="mb-4">

                <h5 class="mb-3">
                    Booked Dates
                </h5>

                <g:if test="${bookings && !bookings.isEmpty()}">

                    <div class="alert alert-warning">

                        <strong>
                            This car is unavailable during:
                        </strong>

                        <ul class="mt-3 mb-0">

                            <g:each in="${bookings}" var="booking">

                                <li class="mb-2">

                                    <strong>
                                        <g:formatDate
                                            date="${booking.startDate}"
                                            format="dd MMM yyyy"/>
                                    </strong>

                                    →

                                    <strong>
                                        <g:formatDate
                                            date="${booking.endDate}"
                                            format="dd MMM yyyy"/>
                                    </strong>

                                    <span class="badge bg-secondary ms-2">
                                        ${booking.status}
                                    </span>

                                </li>

                            </g:each>

                        </ul>

                    </div>

                </g:if>
                <g:else>

                    <div class="alert alert-success">
                        No active bookings for this car.
                        You can select any available dates.
                    </div>

                </g:else>

            </div>


            <g:form action="save" method="POST">

                <g:hiddenField
                    name="carId"
                    value="${car.id}"/>


                <!-- Start Date -->
                <div class="mb-3">

                    <label
                        for="startDate"
                        class="form-label">

                        Start Date

                    </label>

                    <input
                        type="date"
                        id="startDate"
                        name="startDate"
                        class="form-control"
                        onchange="calculateRentalPrice()"
                        oninput="calculateRentalPrice()"
                        required/>

                </div>


                <!-- End Date -->
                <div class="mb-4">

                    <label
                        for="endDate"
                        class="form-label">

                        End Date

                    </label>

                    <input
                        type="date"
                        id="endDate"
                        name="endDate"
                        class="form-control"
                        onchange="calculateRentalPrice()"
                        oninput="calculateRentalPrice()"
                        required/>

                </div>


                <!-- Price Summary -->
                <div
                    id="priceBox"
                    class="card bg-light border-0 mb-4"
                    data-price="${car.pricePerDay}">

                    <div class="card-body">

                        <h5 class="mb-3">
                            Price Summary
                        </h5>

                        <div class="row">


                            <!-- Price Per Day -->
                            <div class="col-md-4 mb-3">

                                <small class="text-muted d-block">
                                    Price Per Day
                                </small>

                                <strong class="fs-5">
                                    ${car.pricePerDay}
                                </strong>

                            </div>


                            <!-- Rental Days -->
                            <div class="col-md-4 mb-3">

                                <small class="text-muted d-block">
                                    Rental Days
                                </small>

                                <strong
                                    id="rentalDays"
                                    class="fs-5">

                                    Select dates

                                </strong>

                            </div>


                            <!-- Total Price -->
                            <div class="col-md-4 mb-3">

                                <small class="text-muted d-block">
                                    Total Price
                                </small>

                                <strong
                                    id="totalPrice"
                                    class="text-success fs-3">

                                    Select dates

                                </strong>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- Date Error -->
                <div
                    id="dateError"
                    class="alert alert-danger"
                    style="display:none;">

                    End date cannot be before start date.

                </div>


                <!-- Buttons -->
                <button
                    type="submit"
                    id="createRentalButton"
                    class="btn btn-primary">

                    Create Rental

                </button>


                <g:link
                    controller="car"
                    action="index"
                    class="btn btn-secondary">

                    Cancel

                </g:link>

            </g:form>

        </div>

    </div>

</div>


<script>

function calculateRentalPrice() {

    const startInput =
        document.getElementById('startDate');

    const endInput =
        document.getElementById('endDate');

    const priceBox =
        document.getElementById('priceBox');

    const rentalDaysElement =
        document.getElementById('rentalDays');

    const totalPriceElement =
        document.getElementById('totalPrice');

    const dateError =
        document.getElementById('dateError');

    const createButton =
        document.getElementById('createRentalButton');


    const startValue =
        startInput.value;

    const endValue =
        endInput.value;


    if (!startValue || !endValue) {

        rentalDaysElement.textContent =
            'Select dates';

        totalPriceElement.textContent =
            'Select dates';

        dateError.style.display =
            'none';

        createButton.disabled =
            false;

        return;
    }


    const pricePerDay =
        parseFloat(priceBox.dataset.price);


    const startParts =
        startValue.split('-');

    const endParts =
        endValue.split('-');


    const startDate =
        Date.UTC(
            Number(startParts[0]),
            Number(startParts[1]) - 1,
            Number(startParts[2])
        );


    const endDate =
        Date.UTC(
            Number(endParts[0]),
            Number(endParts[1]) - 1,
            Number(endParts[2])
        );


    if (endDate < startDate) {

        rentalDaysElement.textContent =
            '-';

        totalPriceElement.textContent =
            '-';

        dateError.style.display =
            'block';

        createButton.disabled =
            true;

        return;
    }


    dateError.style.display =
        'none';

    createButton.disabled =
        false;


    const oneDay =
        1000 * 60 * 60 * 24;


    const difference =
        endDate - startDate;


    const rentalDays =
        Math.floor(
            difference / oneDay
        ) + 1;


    const totalPrice =
        rentalDays * pricePerDay;


    rentalDaysElement.textContent =
        rentalDays +
        (rentalDays === 1
            ? ' day'
            : ' days');


    totalPriceElement.textContent =
        totalPrice.toFixed(2);

}

</script>

</body>
</html>