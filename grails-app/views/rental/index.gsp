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
            position:sticky;
            top:0;
            z-index:2;
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
            padding:0.55rem 0.65rem;
            vertical-align:middle;
            font-size:0.88rem;
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
            font-size:0.6rem;
            font-weight:600;
            letter-spacing:0.04em;
            padding:0.18rem 0.45rem;
            border-radius:5px;
            display:block;
            width:fit-content;
            margin-top:0.35rem;
            cursor:default;
        }

        .deposit-paid{
            background:#e8f6ee;
            color:var(--go-green);
        }

        .deposit-unpaid{
            background:#f0efeb;
            color:var(--ink-soft);
        }

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

        .rental-progress{
            min-width:104px;
            max-width:118px;
        }

        .progress-track{
            display:flex;
            align-items:flex-start;
            gap:0;
        }

        .progress-step{
            position:relative;
            flex:1;
            min-width:20px;
            text-align:center;
            cursor:default;
        }

        .progress-step:not(:last-child)::after{
            content:"";
            position:absolute;
            top:7px;
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
            width:14px;
            height:14px;
            margin:0 auto;
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

        .date-range{
            display:flex;
            flex-direction:column;
            gap:1px;
            line-height:1.35;
        }

        .date-arrow{
            font-size:.7rem;
            color:#b6b4ae;
            line-height:1;
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

        .price-adjustment-box{
            width:220px;
            min-width:220px;
            margin-bottom:.75rem;
            padding:.7rem;
            border:1px solid #f0d9a6;
            border-radius:9px;
            background:#fffaf0;
        }

        .price-adjustment-summary{
            margin-bottom:.55rem;
            font-family:'JetBrains Mono', monospace;
            font-size:.66rem;
            line-height:1.45;
            color:var(--ink-soft);
        }

        .price-adjustment-summary strong{
            color:var(--asphalt-900);
        }

        .price-adjustment-box .form-control{
            border:1px solid var(--hairline);
            border-radius:7px;
            font-size:.78rem;
        }

        .price-adjustment-box .form-control:focus{
            border-color:var(--headlight);
            box-shadow:0 0 0 .15rem rgba(245,166,35,.15);
        }

        .price-adjustment-box textarea{
            resize:vertical;
            min-height:58px;
        }

        .price-adjustment-box .btn{
            width:100%;
            white-space:nowrap;
        }

        .price-adjustment-history{
            margin-top:.55rem;
            padding-top:.5rem;
            border-top:1px dashed #e4c98e;
            font-size:.68rem;
            color:var(--ink-soft);
        }

        .price-adjustment-history summary{
            cursor:pointer;
            font-weight:700;
            color:var(--asphalt-900);
        }

        .price-adjustment-record{
            margin-top:.5rem;
            padding:.45rem;
            border-radius:6px;
            background:#fff;
            line-height:1.45;
            overflow-wrap:anywhere;
        }

        .price-final-label{
            display:block;
            font-family:'JetBrains Mono', monospace;
            font-size:.6rem;
            font-weight:700;
            letter-spacing:.04em;
            color:var(--go-green);
        }

        .price-original{
            display:block;
            margin-top:.2rem;
            font-family:'JetBrains Mono', monospace;
            font-size:.68rem;
            color:var(--ink-soft);
            text-decoration:line-through;
        }

        .table th:last-child,
        .table td:last-child{
            width:240px;
            min-width:240px;
        }

        .rentals-empty{
            padding:3.2rem 1.5rem;
            text-align:center;
            background:#fff;
            border:1px dashed var(--hairline);
            border-radius:14px;
        }

        .rentals-empty-icon{
            font-size:1.9rem;
            color:#c8c6bf;
            margin-bottom:.85rem;
        }

        .rentals-empty-title{
            font-family:'Space Grotesk', sans-serif;
            font-size:1.05rem;
            font-weight:700;
            color:var(--asphalt-900);
            margin-bottom:.35rem;
        }

        .rentals-empty-text{
            color:var(--ink-soft);
            font-size:.88rem;
            margin-bottom:1.2rem;
        }

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


    <g:if test="${flash.message}">

        <div class="alert alert-info">
            ${flash.message}
        </div>

    </g:if>


    <g:if test="${rentalList}">

        <div class="table-responsive rentals-table-wrap">

            <table class="table table-hover align-middle">

                <thead class="table-light">

                <tr>

                    <th>Car</th>

                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <th>Customer</th>
                    </sec:ifAllGranted>

                    <th>Dates</th>

                    <th>Total</th>

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


                        <sec:ifAllGranted roles="ROLE_ADMIN">

                            <td>

                                ${rental.customer.username}

                            </td>

                        </sec:ifAllGranted>


                        <td>

                            <div class="date-range">

                                <span class="mono-date">
                                    <g:formatDate
                                        date="${rental.startDate}"
                                        format="dd MMM yyyy"/>
                                </span>

                                <span class="date-arrow">&rarr;</span>

                                <span class="mono-date">
                                    <g:formatDate
                                        date="${rental.endDate}"
                                        format="dd MMM yyyy"/>
                                </span>

                            </div>

                        </td>


                        <td>

                            <strong>
                                ${rental.totalPrice}
                            </strong>

                            <g:if test="${rental.systemCalculatedPrice != null && rental.systemCalculatedPrice.compareTo(rental.totalPrice) != 0}">
                                <span class="price-final-label">
                                    FINAL PRICE
                                </span>
                                <span class="price-original">
                                    ${rental.systemCalculatedPrice}
                                </span>
                            </g:if>

                        </td>


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


                            <g:if test="${rental.status != 'CANCELLED'}">

                                <g:if test="${rental.depositPaid}">

                                    <span
                                        class="deposit-badge deposit-paid"
                                        title="Booking deposit ${rental.bookingDeposit} — paid">
                                        DEPOSIT PAID
                                    </span>

                                </g:if>
                                <g:else>

                                    <span
                                        class="deposit-badge deposit-unpaid"
                                        title="Booking deposit ${rental.bookingDeposit} — not paid yet">
                                        DEPOSIT DUE
                                    </span>

                                </g:else>

                            </g:if>

                        </td>


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

                                        <div class="progress-step ${progressLevel >= 1 ? 'done' : ''} ${progressLevel == 1 ? 'current' : ''}"
                                             title="Rental created">
                                            <div class="progress-dot"></div>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 2 ? 'done' : ''} ${progressLevel == 2 ? 'current' : ''}"
                                             title="Deposit paid">
                                            <div class="progress-dot"></div>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 3 ? 'done' : ''} ${progressLevel == 3 ? 'current' : ''}"
                                             title="Booking confirmed">
                                            <div class="progress-dot"></div>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 4 ? 'done' : ''} ${progressLevel == 4 ? 'current' : ''}"
                                             title="Vehicle picked up">
                                            <div class="progress-dot"></div>
                                        </div>

                                        <div class="progress-step ${progressLevel >= 5 ? 'done' : ''} ${progressLevel == 5 ? 'current' : ''}"
                                             title="Vehicle returned">
                                            <div class="progress-dot"></div>
                                        </div>

                                    </div>

                                </div>

                            </g:else>

                        </td>


                        <td>


                            <sec:ifAllGranted roles="ROLE_CUSTOMER">


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


                                <g:if test="${rental.status == 'PICKED_UP'}">

                                    <span class="action-text pickedup">
                                        Car Picked Up
                                    </span>

                                </g:if>


                                <g:if test="${rental.status == 'COMPLETED'}">

                                    <span class="action-text completed">
                                        Completed
                                    </span>

                                </g:if>


                                <g:if test="${rental.status == 'CANCELLED'}">

                                    <span class="action-text cancelled">
                                        Cancelled
                                    </span>

                                </g:if>

                            </sec:ifAllGranted>


                           <sec:ifAllGranted roles="ROLE_ADMIN">

                                <g:if test="${rental.status == 'PENDING'}">

                                    <span class="action-text pending">
                                        Waiting for deposit
                                    </span>

                                </g:if><g:elseif test="${rental.status == 'CONFIRMED'}">

                                    <g:render
                                        template="priceAdjustment"
                                        model="${[
                                            rental: rental,
                                            adjustments: priceAdjustmentsByRental?.get(rental.id)
                                        ]}"/>

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

                                    <g:render
                                        template="priceAdjustment"
                                        model="${[
                                            rental: rental,
                                            adjustments: priceAdjustmentsByRental?.get(rental.id)
                                        ]}"/>

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

                                    <g:render
                                        template="priceAdjustment"
                                        model="${[
                                            rental: rental,
                                            adjustments: priceAdjustmentsByRental?.get(rental.id)
                                        ]}"/>

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

        <div class="rentals-empty">

            <div class="rentals-empty-icon">
                <i class="bi bi-calendar-x"></i>
            </div>

            <sec:ifAllGranted roles="ROLE_ADMIN">

                <div class="rentals-empty-title">
                    No active rentals
                </div>

                <p class="rentals-empty-text">
                    Confirmed and picked-up bookings will show up here.
                </p>

            </sec:ifAllGranted>


            <sec:ifAllGranted roles="ROLE_CUSTOMER">

                <div class="rentals-empty-title">
                    You have no rentals yet
                </div>

                <p class="rentals-empty-text">
                    Pick a car from the fleet to make your first booking.
                </p>

                <g:link
                    controller="car"
                    action="index"
                    class="btn btn-primary">

                    <i class="bi bi-car-front me-1"></i>
                    Browse Cars

                </g:link>

            </sec:ifAllGranted>

        </div>

    </g:else>


    <div class="d-flex justify-content-center mt-4">

        <g:paginate
            total="${rentalCount ?: 0}"
            max="10"/>

    </div>

</div>

</body>
</html>
