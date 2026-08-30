<!doctype html>
<html>

<head>
    <meta name="layout" content="main"/>
    <title>Rentals</title>

    <style>
        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --taillight:#e5484d;
            --brake-red:#c0392b;
            --go-green:#1f8a52;
            --blue-signal:#2560c4;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }

        .rentals-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
        }

        .rentals-page h2{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            letter-spacing:-0.01em;
            color:var(--asphalt-900);
        }

        .rentals-page .text-muted{
            color:var(--ink-soft) !important;
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
            padding:2rem;
        }

        .btn-primary{
            background:var(--headlight);
            border:none;
            color:var(--asphalt-900);
            font-weight:600;
            border-radius:8px;
        }
        .btn-primary:hover,
        .btn-primary:focus-visible{
            background:var(--headlight-dim);
            color:var(--asphalt-900);
        }

        /* ---------- Table: signature logbook/manifest look ---------- */
        .rentals-table-wrap{
            width:100%;
            border:1px solid var(--hairline);
            border-radius:14px;
            overflow:hidden;
            background:#fff;
        }

        .table{
            width:100%;
            margin-bottom:0;
        }

        .table thead.table-light th{
            background:var(--asphalt-900) !important;
            color:#fff;
            font-family:'JetBrains Mono', monospace;
            font-size:0.7rem;
            font-weight:600;
            letter-spacing:0.08em;
            text-transform:uppercase;
            border:none;
            padding:0.8rem 0.65rem;
        }

        .table tbody tr{
            border-bottom:1px solid var(--hairline);
        }

        .table tbody tr:last-child{
            border-bottom:none;
        }

        .table-hover tbody tr:hover{
            background:var(--paper);
        }

        .table td{
            padding:0.8rem 0.65rem;
            vertical-align:middle;
            font-size:0.9rem;
        }

        .table td strong{
            font-family:'Space Grotesk', sans-serif;
            font-weight:600;
            color:var(--asphalt-900);
        }

        .table td small{
            font-family:'JetBrains Mono', monospace;
            font-size:0.76rem;
        }

        .table td .mono-date{
            font-family:'JetBrains Mono', monospace;
            font-size:0.86rem;
        }

        /* ---------- Status / deposit badges: dashboard-light style ---------- */
        .status-badge{
            font-family:'JetBrains Mono', monospace;
            font-weight:600;
            font-size:0.68rem;
            letter-spacing:0.05em;
            padding:0.35rem 0.6rem;
            border-radius:999px;
            display:inline-flex;
            align-items:center;
            gap:0.35rem;
            white-space:nowrap;
        }

        .status-badge::before{
            content:"";
            width:6px;
            height:6px;
            border-radius:50%;
            display:inline-block;
        }

        .status-pending{ background:#fff3e0; color:var(--headlight-dim); }
        .status-pending::before{ background:var(--headlight); box-shadow:0 0 6px var(--headlight); }

        .status-confirmed{ background:#e8f6ee; color:var(--go-green); }
        .status-confirmed::before{ background:var(--go-green); box-shadow:0 0 6px var(--go-green); }

        .status-pickedup{ background:#eaf1fb; color:var(--blue-signal); }
        .status-pickedup::before{ background:var(--blue-signal); box-shadow:0 0 6px var(--blue-signal); }

        .status-completed{ background:#e9e9eb; color:var(--asphalt-900); }
        .status-completed::before{ background:var(--asphalt-900); }

        .status-cancelled{ background:#fdecea; color:var(--brake-red); }
        .status-cancelled::before{ background:var(--brake-red); box-shadow:0 0 6px var(--brake-red); }

        .status-other{ background:#f0efeb; color:var(--ink-soft); }
        .status-other::before{ background:var(--ink-soft); }

        .deposit-badge{
            font-family:'JetBrains Mono', monospace;
            font-size:0.66rem;
            font-weight:600;
            letter-spacing:0.05em;
            padding:0.25rem 0.55rem;
            border-radius:6px;
            display:inline-block;
            margin-top:0.3rem;
        }

        .deposit-paid{
            background:#e8f6ee;
            color:var(--go-green);
        }

        .deposit-unpaid{
            background:#f0efeb;
            color:var(--ink-soft);
        }

        /* ---------- Action buttons ---------- */
        .btn-success{
            background:var(--go-green);
            border:none;
            border-radius:6px;
            font-weight:600;
        }
        .btn-success:hover,
        .btn-success:focus-visible{
            background:#186f42;
        }

        .action-text{
            font-family:'JetBrains Mono', monospace;
            font-size:0.78rem;
            font-weight:600;
        }

        .action-text.paid{ color:var(--go-green); }
        .action-text.pickedup{ color:var(--blue-signal); }
        .action-text.completed{ color:var(--ink-soft); }
        .action-text.cancelled{ color:var(--brake-red); }


        


        /* ---------- Admin alert: vehicle pickup due today ---------- */

        .pickup-due-today > td{
            background:#f3fbf6 !important;
            border-top-color:#dcefe3 !important;
            border-bottom-color:#dcefe3 !important;
        }

        .pickup-due-today > td:first-child{
            box-shadow:inset 4px 0 0 #8fd3aa;
        }

        .pickup-due-today:hover > td{
            background:#edf8f1 !important;
        }

        .pickup-due-today-badge{
            display:inline-flex;
            align-items:center;
            gap:6px;
            margin-top:.45rem;
            padding:.3rem .55rem;
            border-radius:999px;
            background:#eaf7ef;
            color:#2f7650;
            font-family:'JetBrains Mono', monospace;
            font-size:.62rem;
            font-weight:700;
            letter-spacing:.04em;
            white-space:nowrap;
        }

        .pickup-due-today-badge::before{
            content:"";
            width:7px;
            height:7px;
            border-radius:50%;
            background:#69b98a;
            box-shadow:0 0 0 4px rgba(105,185,138,.10);
        }

        /* ---------- Admin alert: vehicle return due today ---------- */

        .return-due-today > td{
            background:#f2f7fd !important;
            border-top-color:#d7e6f7 !important;
            border-bottom-color:#d7e6f7 !important;
        }

        .return-due-today > td:first-child{
            box-shadow:inset 4px 0 0 #8fb7df;
        }

        .return-due-today:hover > td{
            background:#eaf2fb !important;
        }

        .return-due-today-badge{
            display:inline-flex;
            align-items:center;
            gap:6px;
            margin-top:.45rem;
            padding:.3rem .55rem;
            border-radius:999px;
            background:#e7f0fb;
            color:#3f6f9f;
            font-family:'JetBrains Mono', monospace;
            font-size:.62rem;
            font-weight:700;
            letter-spacing:.04em;
            white-space:nowrap;
        }

        .return-due-today-badge::before{
            content:"";
            width:7px;
            height:7px;
            border-radius:50%;
            background:#6fa2d6;
            box-shadow:0 0 0 4px rgba(111,162,214,.10);
        }

        /* ---------- Rental progress timeline ---------- */

        .rental-progress{
            min-width:205px;
            max-width:220px;
        }

        .progress-track{
            display:flex;
            align-items:flex-start;
            gap:0;
        }

        .progress-step{
            position:relative;
            flex:1;
            min-width:38px;
            text-align:center;
        }

        .progress-step:not(:last-child)::after{
            content:"";
            position:absolute;
            top:9px;
            left:50%;
            width:100%;
            height:2px;
            background:#e4e2dc;
            z-index:0;
        }

        .progress-step.done:not(:last-child)::after{
            background:var(--headlight);
        }

        .progress-dot{
            position:relative;
            z-index:1;
            width:18px;
            height:18px;
            margin:0 auto 6px;
            border-radius:50%;
            border:2px solid #d6d4ce;
            background:#fff;
        }

        .progress-step.done .progress-dot{
            border-color:var(--headlight);
            background:var(--headlight);
            box-shadow:0 0 0 4px rgba(245,166,35,.10);
        }

        .progress-step.current .progress-dot{
            box-shadow:
                0 0 0 4px rgba(245,166,35,.16),
                0 0 12px rgba(245,166,35,.30);
        }

        .progress-label{
            display:block;
            font-family:'JetBrains Mono', monospace;
            font-size:.50rem;
            line-height:1.15;
            color:#9a9892;
            white-space:normal;
        }

        .progress-step.done .progress-label{
            color:var(--asphalt-900);
            font-weight:600;
        }

        .progress-cancelled{
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:.35rem .65rem;
            border-radius:999px;
            background:#fdecea;
            color:var(--brake-red);
            font-family:'JetBrains Mono', monospace;
            font-size:.68rem;
            font-weight:600;
        }

        .btn-cancel-rental{
            border:1px solid #efc5c5;
            background:#fff;
            color:var(--brake-red);
            border-radius:7px;
            font-weight:600;
        }

        .btn-cancel-rental:hover,
        .btn-cancel-rental:focus-visible{
            background:#fdecea;
            color:var(--brake-red);
            border-color:#e8aaaa;
        }

        /* ---------- Admin rental workflow ---------- */

        .admin-return-form{
            width:155px;
            min-width:155px;
        }

        .return-label{
            display:block;
            margin-bottom:0.3rem;
            font-family:'JetBrains Mono', monospace;
            font-size:0.65rem;
            font-weight:600;
            letter-spacing:0.05em;
            text-transform:uppercase;
            color:var(--ink-soft);
        }

        .damage-input{
            width:155px;
            max-width:155px;
            border:1px solid var(--hairline);
            border-radius:7px;
        }

        .damage-input:focus{
            border-color:var(--headlight);
            box-shadow:0 0 0 0.15rem rgba(245,166,35,0.15);
        }

        .action-text.pending{
            color:var(--headlight-dim);
        }


        .admin-action-box{
            width:155px;
            min-width:155px;
        }

        .admin-action-box small{
            display:block;
            line-height:1.35;
            white-space:normal;
            overflow-wrap:break-word;
        }

        .admin-action-box .btn,
        .admin-return-form .btn{
            width:100%;
            white-space:nowrap;
        }

        .table th:last-child,
        .table td:last-child{
            width:175px;
            min-width:175px;
        }

        /* ---------- Mobile ---------- */
        @media (max-width: 767.98px){
            .table td, .table th{
                font-size:0.82rem;
            }
        }
    </style>
</head>

<body>

<div class="container-fluid mt-4 px-4 px-xl-5 rentals-page">

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">

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

            <div class="d-flex gap-2 flex-wrap">

                <g:link
                    controller="rental"
                    action="history"
                    class="btn btn-secondary">

                    <i class="bi bi-clock-history me-1"></i>
                    Rental History

                </g:link>


                <g:link
                    controller="car"
                    action="index"
                    class="btn btn-primary">

                    <i class="bi bi-car-front me-1"></i>
                    Browse Cars

                </g:link>

            </div>

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

        <div class="table-responsive rentals-table-wrap">

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

                    <th>Progress</th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody>

                <g:each
                    in="${rentalList}"
                    var="rental">

                    <g:set
                        var="pickupDueToday"
                        value="${pickupDueTodayIds?.contains(rental.id) ?: false}"/>

                    <g:set
                        var="returnDueToday"
                        value="${returnDueTodayIds?.contains(rental.id) ?: false}"/>

                    <tr class="${pickupDueToday ? 'pickup-due-today' : (returnDueToday ? 'return-due-today' : '')}">


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

                            <g:if test="${pickupDueToday}">
                                <br/>
                                <span class="pickup-due-today-badge">
                                    PICKUP DUE TODAY
                                </span>
                            </g:if>

                            <g:if test="${returnDueToday}">
                                <br/>
                                <span class="return-due-today-badge">
                                    RETURN DUE TODAY
                                </span>
                            </g:if>

                        </td>


                        <!-- Customer - Admin Only -->
                        <sec:ifAllGranted roles="ROLE_ADMIN">

                            <td>

                                ${rental.customer.username}

                            </td>

                        </sec:ifAllGranted>


                        <!-- Start Date -->
                        <td>

                            <span class="mono-date">
                                <g:formatDate
                                    date="${rental.startDate}"
                                    format="yyyy-MM-dd"/>
                            </span>

                        </td>


                        <!-- End Date -->
                        <td>

                            <span class="mono-date">
                                <g:formatDate
                                    date="${rental.endDate}"
                                    format="yyyy-MM-dd"/>
                            </span>

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

                                <span class="deposit-badge deposit-paid">
                                    PAID
                                </span>

                            </g:if>
                            <g:else>

                                <span class="deposit-badge deposit-unpaid">
                                    NOT PAID
                                </span>

                            </g:else>

                        </td>


                        <!-- Status -->
                        <td>

                            <g:if test="${rental.status == 'PENDING'}">

                                <span class="status-badge status-pending">
                                    PENDING
                                </span>

                            </g:if>
                            <g:elseif test="${rental.status == 'CONFIRMED'}">

                                <span class="status-badge status-confirmed">
                                    CONFIRMED
                                </span>

                            </g:elseif>
                            <g:elseif test="${rental.status == 'PICKED_UP'}">

                                <span class="status-badge status-pickedup">
                                    PICKED UP
                                </span>

                            </g:elseif>
                            <g:elseif test="${rental.status == 'COMPLETED'}">

                                <span class="status-badge status-completed">
                                    COMPLETED
                                </span>

                            </g:elseif>
                            <g:elseif test="${rental.status == 'CANCELLED'}">

                                <span class="status-badge status-cancelled">
                                    CANCELLED
                                </span>

                            </g:elseif>
                            <g:else>

                                <span class="status-badge status-other">
                                    ${rental.status}
                                </span>

                            </g:else>

                        </td>


                        <!-- Progress Timeline -->
                        <td>

                            <g:if test="${rental.status == 'CANCELLED'}">

                                <span class="progress-cancelled">
                                    <i class="bi bi-x-circle"></i>
                                    Cancelled
                                </span>

                            </g:if><g:else>

                                <g:set
                                    var="progressLevel"
                                    value="${rental.status == 'PENDING' ? 1 :
                                             rental.status == 'CONFIRMED' ? 3 :
                                             rental.status == 'PICKED_UP' ? 4 :
                                             rental.status == 'COMPLETED' ? 5 : 0}"/>

                                <div class="rental-progress">

                                    <div class="progress-track">

                                        <div class="progress-step ${progressLevel >= 1 ? 'done' : ''} ${progressLevel == 1 ? 'current' : ''}">
                                            <div class="progress-dot"></div>
                                            <span class="progress-label">Created</span>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 2 ? 'done' : ''} ${progressLevel == 2 ? 'current' : ''}">
                                            <div class="progress-dot"></div>
                                            <span class="progress-label">Deposit</span>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 3 ? 'done' : ''} ${progressLevel == 3 ? 'current' : ''}">
                                            <div class="progress-dot"></div>
                                            <span class="progress-label">Confirmed</span>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 4 ? 'done' : ''} ${progressLevel == 4 ? 'current' : ''}">
                                            <div class="progress-dot"></div>
                                            <span class="progress-label">Picked Up</span>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 5 ? 'done' : ''} ${progressLevel == 5 ? 'current' : ''}">
                                            <div class="progress-dot"></div>
                                            <span class="progress-label">Returned</span>
                                        </div>

                                    </div>

                                </div>

                            </g:else>

                        </td>


                        <!-- Actions -->
                        <td>


                            <!-- Customer Actions -->
                            <sec:ifAllGranted roles="ROLE_CUSTOMER">


                                <!-- PENDING: Pay Deposit + Free Cancellation -->
                                <g:if test="${rental.status == 'PENDING' && !rental.depositPaid}">

                                    <div class="d-flex gap-2 flex-wrap">

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


                                        <g:form
                                            action="cancel"
                                            id="${rental.id}"
                                            method="POST"
                                            class="d-inline">

                                            <button
                                                type="submit"
                                                class="btn btn-sm btn-cancel-rental"
                                                onclick="return confirm('Cancel this pending rental? No booking deposit has been paid, so there is no cancellation charge.');">

                                                Cancel

                                            </button>

                                        </g:form>

                                    </div>

                                </g:if>


                                <!-- CONFIRMED: Deposit is non-refundable if cancelled -->
                                <g:if test="${rental.status == 'CONFIRMED' && rental.depositPaid}">

                                    <div>

                                        <div class="action-text paid mb-2">
                                            Deposit Paid ✓
                                        </div>

                                        <g:form
                                            action="cancel"
                                            id="${rental.id}"
                                            method="POST"
                                            class="d-inline">

                                            <button
                                                type="submit"
                                                class="btn btn-sm btn-cancel-rental"
                                                onclick="return confirm('Warning: this reservation is confirmed. If you cancel now, the booking deposit of ${rental.bookingDeposit} is NON-REFUNDABLE. Do you still want to cancel?');">

                                                Cancel Booking

                                            </button>

                                        </g:form>

                                    </div>

                                </g:if>


                                <!-- Picked Up -->
                                <g:if test="${rental.status == 'PICKED_UP'}">

                                    <span class="action-text pickedup">
                                        Car Picked Up
                                    </span>

                                </g:if>


                                <!-- Completed -->
                                <g:if test="${rental.status == 'COMPLETED'}">

                                    <span class="action-text completed">
                                        Completed
                                    </span>

                                </g:if>


                                <!-- Cancelled -->
                                <g:if test="${rental.status == 'CANCELLED'}">

                                    <span class="action-text cancelled">
                                        Cancelled
                                    </span>

                                </g:if>

                            </sec:ifAllGranted>


                           <!-- Admin Actions -->
                            <sec:ifAllGranted roles="ROLE_ADMIN">

                                <g:if test="${rental.status == 'PENDING'}">

                                    <span class="action-text pending">
                                        Waiting for deposit
                                    </span>

                                </g:if><g:elseif test="${rental.status == 'CONFIRMED'}">

                                    <div class="mb-2 admin-action-box">

                                        <small class="text-muted mb-2">
                                            Security Deposit
                                            <strong class="d-block mt-1">
                                                ${rental.securityDeposit}
                                                refundable
                                            </strong>
                                        </small>

                                        <g:form
                                            action="pickup"
                                            id="${rental.id}"
                                            method="POST"
                                            class="d-inline">

                                            <button
                                                type="submit"
                                                class="btn btn-primary btn-sm"
                                                onclick="return confirm('Confirm vehicle pickup? Make sure licence, insurance and security deposit procedures are completed.');">

                                                <i class="bi bi-key me-1"></i>
                                                Pick Up

                                            </button>

                                        </g:form>

                                    </div>

                                </g:elseif><g:elseif test="${rental.status == 'PICKED_UP'}">

                                    <g:form
                                        action="complete"
                                        id="${rental.id}"
                                        method="POST"
                                        class="admin-return-form">

                                        <div class="mb-2">

                                            <label
                                                for="damageCost-${rental.id}"
                                                class="return-label">
                                                Damage Cost
                                            </label>

                                            <input
                                                type="number"
                                                id="damageCost-${rental.id}"
                                                name="damageCost"
                                                value="0.00"
                                                min="0"
                                                step="0.01"
                                                class="form-control form-control-sm damage-input"/>

                                        </div>

                                        <button
                                            type="submit"
                                            class="btn btn-success btn-sm"
                                            onclick="return confirm('Confirm vehicle return and complete this rental?');">

                                            <i class="bi bi-check-circle me-1"></i>
                                            Return Car

                                        </button>

                                    </g:form>

                                </g:elseif><g:elseif test="${rental.status == 'COMPLETED'}">

                                    <span class="action-text completed">
                                        <i class="bi bi-check-circle me-1"></i>
                                        Completed
                                    </span>

                                </g:elseif><g:elseif test="${rental.status == 'CANCELLED'}">

                                    <span class="action-text cancelled">
                                        Cancelled
                                    </span>

                                </g:elseif>

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
