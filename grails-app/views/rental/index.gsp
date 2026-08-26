<!doctype html>
<html>

<head>
    <meta name="layout" content="main"/>
    <title>Rentals</title>
</head>

<body>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2>Rentals</h2>

            <sec:ifAllGranted roles="ROLE_CUSTOMER">
                <p class="text-muted">
                    Your car rentals
                </p>
            </sec:ifAllGranted>

            <sec:ifAllGranted roles="ROLE_ADMIN">
                <p class="text-muted">
                    Manage customer rentals
                </p>
            </sec:ifAllGranted>

        </div>


        <sec:ifAllGranted roles="ROLE_CUSTOMER">

            <g:link
                controller="car"
                action="index"
                class="btn btn-primary">

                Browse Cars

            </g:link>

        </sec:ifAllGranted>

    </div>


    <!-- Flash Message -->
    <g:if test="${flash.message}">

        <div class="alert alert-info">
            ${flash.message}
        </div>

    </g:if>


    <!-- Rental List -->
    <g:if test="${rentalList}">

        <div class="table-responsive">

            <table class="table table-hover align-middle">

                <thead class="table-light">

                <tr>

                    <th>Car</th>

                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <th>Customer</th>
                    </sec:ifAllGranted>

                    <th>Start</th>

                    <th>End</th>

                    <th>Total Price</th>

                    <th>Booking Deposit</th>

                    <th>Status</th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody>

                <g:each
                    in="${rentalList}"
                    var="rental">

                    <tr>


                        <!-- Car -->
                        <td>

                            <strong>
                                ${rental.car.brand}
                                ${rental.car.model}
                            </strong>

                            <br/>

                            <small class="text-muted">
                                ${rental.car.plateNumber}
                            </small>

                        </td>


                        <!-- Customer - Admin Only -->
                        <sec:ifAllGranted roles="ROLE_ADMIN">

                            <td>

                                ${rental.customer.username}

                            </td>

                        </sec:ifAllGranted>


                        <!-- Start Date -->
                        <td>

                            <g:formatDate
                                date="${rental.startDate}"
                                format="yyyy-MM-dd"/>

                        </td>


                        <!-- End Date -->
                        <td>

                            <g:formatDate
                                date="${rental.endDate}"
                                format="yyyy-MM-dd"/>

                        </td>


                        <!-- Total Price -->
                        <td>

                            <strong>
                                ${rental.totalPrice}
                            </strong>

                        </td>


                        <!-- Booking Deposit -->
                        <td>

                            ${rental.bookingDeposit}

                            <br/>


                            <g:if test="${rental.depositPaid}">

                                <span class="badge bg-success mt-1">
                                    PAID
                                </span>

                            </g:if>
                            <g:else>

                                <span class="badge bg-secondary mt-1">
                                    NOT PAID
                                </span>

                            </g:else>

                        </td>


                        <!-- Status -->
                        <td>

                            <g:if test="${rental.status == 'PENDING'}">

                                <span class="badge bg-warning text-dark">
                                    PENDING
                                </span>

                            </g:if>
                            <g:elseif test="${rental.status == 'CONFIRMED'}">

                                <span class="badge bg-success">
                                    CONFIRMED
                                </span>

                            </g:elseif>
                            <g:elseif test="${rental.status == 'PICKED_UP'}">

                                <span class="badge bg-primary">
                                    PICKED UP
                                </span>

                            </g:elseif>
                            <g:elseif test="${rental.status == 'COMPLETED'}">

                                <span class="badge bg-dark">
                                    COMPLETED
                                </span>

                            </g:elseif>
                            <g:elseif test="${rental.status == 'CANCELLED'}">

                                <span class="badge bg-danger">
                                    CANCELLED
                                </span>

                            </g:elseif>
                            <g:else>

                                <span class="badge bg-secondary">
                                    ${rental.status}
                                </span>

                            </g:else>

                        </td>


                        <!-- Actions -->
                        <td>


                            <!-- Customer Actions -->
                            <sec:ifAllGranted roles="ROLE_CUSTOMER">


                                <!-- Pay Deposit -->
                                <g:if test="${rental.status == 'PENDING' && !rental.depositPaid}">

                                    <g:form
                                        action="payDeposit"
                                        id="${rental.id}"
                                        method="POST"
                                        class="d-inline">

                                        <button
                                            type="submit"
                                            class="btn btn-success btn-sm"
                                            onclick="return confirm('Pay booking deposit of ${rental.bookingDeposit}?');">

                                            Pay Deposit

                                        </button>

                                    </g:form>

                                </g:if>


                                <!-- Deposit Already Paid -->
                                <g:if test="${rental.status == 'CONFIRMED' && rental.depositPaid}">

                                    <span class="text-success fw-bold">
                                        Deposit Paid ✓
                                    </span>

                                </g:if>


                                <!-- Picked Up -->
                                <g:if test="${rental.status == 'PICKED_UP'}">

                                    <span class="text-primary fw-bold">
                                        Car Picked Up
                                    </span>

                                </g:if>


                                <!-- Completed -->
                                <g:if test="${rental.status == 'COMPLETED'}">

                                    <span class="text-muted">
                                        Completed
                                    </span>

                                </g:if>


                                <!-- Cancelled -->
                                <g:if test="${rental.status == 'CANCELLED'}">

                                    <span class="text-danger">
                                        Cancelled
                                    </span>

                                </g:if>

                            </sec:ifAllGranted>


                            <!-- Admin -->
                            <sec:ifAllGranted roles="ROLE_ADMIN">

                                <span class="text-muted">
                                    Admin actions coming next
                                </span>

                            </sec:ifAllGranted>


                        </td>

                    </tr>

                </g:each>

                </tbody>

            </table>

        </div>

    </g:if>
    <g:else>

        <div class="alert alert-secondary text-center">

            No rentals found.

        </div>

    </g:else>


    <!-- Pagination -->
    <div class="d-flex justify-content-center mt-4">

        <g:paginate
            total="${rentalCount ?: 0}"
            max="10"/>

    </div>

</div>

</body>
</html>