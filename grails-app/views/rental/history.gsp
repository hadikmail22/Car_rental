<!doctype html>
<html>

<head>
    <meta name="layout" content="main"/>
    <title>Rental History</title>

    <style>
        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --brake-red:#c0392b;
            --go-green:#1f8a52;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }

        .history-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
        }

        .history-page h2,
        .history-page h3{
            font-family:'Space Grotesk', sans-serif;
            color:var(--asphalt-900);
        }

        .history-page .text-muted{
            color:var(--ink-soft) !important;
        }

        .history-card{
            overflow:hidden;
            margin-bottom:1.5rem;
            border:1px solid var(--hairline);
            border-radius:16px;
            background:#fff;
            box-shadow:0 14px 38px rgba(16,17,20,.06);
        }

        .history-card-head{
            display:flex;
            justify-content:space-between;
            align-items:flex-start;
            gap:1rem;
            padding:1.25rem 1.4rem;
            border-bottom:1px solid var(--hairline);
            background:
                linear-gradient(135deg, #fff 0%, #faf9f5 100%);
        }

        .history-car{
            font-family:'Space Grotesk', sans-serif;
            font-size:1.15rem;
            font-weight:700;
        }

        .history-meta{
            margin-top:.35rem;
            font-family:'JetBrains Mono', monospace;
            font-size:.76rem;
            color:var(--ink-soft);
        }

        .history-status{
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:.4rem .7rem;
            border-radius:999px;
            font-family:'JetBrains Mono', monospace;
            font-size:.68rem;
            font-weight:700;
            letter-spacing:.04em;
            white-space:nowrap;
        }

        .history-status.completed{
            background:#e8f6ee;
            color:var(--go-green);
        }

        .history-status.cancelled{
            background:#fdecea;
            color:var(--brake-red);
        }

        .history-body{
            padding:1.4rem;
        }

        .section-label{
            margin-bottom:.8rem;
            font-family:'JetBrains Mono', monospace;
            font-size:.67rem;
            font-weight:700;
            letter-spacing:.09em;
            text-transform:uppercase;
            color:var(--headlight-dim);
        }

        .settlement-box{
            overflow:hidden;
            border:1px solid var(--hairline);
            border-radius:12px;
            background:var(--paper);
        }

        .settlement-row{
            display:flex;
            justify-content:space-between;
            gap:1rem;
            padding:.72rem .9rem;
            border-bottom:1px solid var(--hairline);
            font-size:.88rem;
        }

        .settlement-row:last-child{
            border-bottom:none;
        }

        .settlement-row span:first-child{
            color:var(--ink-soft);
        }

        .settlement-row strong{
            font-family:'JetBrains Mono', monospace;
            color:var(--asphalt-900);
        }

        .settlement-row.positive strong{
            color:var(--go-green);
        }

        .settlement-row.danger strong{
            color:var(--brake-red);
        }

        .settlement-row.total-paid{
            background:#fff;
            font-weight:700;
        }

        .final-cost{
            padding:1rem;
            border-radius:12px;
            background:var(--asphalt-900);
            color:#fff;
        }

        .final-cost small{
            display:block;
            margin-bottom:.3rem;
            font-family:'JetBrains Mono', monospace;
            font-size:.66rem;
            letter-spacing:.08em;
            text-transform:uppercase;
            color:#b7b7ba;
        }

        .final-cost strong{
            display:block;
            font-family:'Space Grotesk', sans-serif;
            font-size:1.55rem;
            color:var(--headlight);
        }

        .formula-note{
            margin-top:.9rem;
            padding:.75rem .85rem;
            border-left:3px solid var(--headlight);
            background:#fff9ed;
            font-size:.78rem;
            color:#6c5a2d;
        }

        .cancel-note{
            padding:1rem;
            border:1px solid #f1caca;
            border-radius:12px;
            background:#fff5f5;
            color:#883939;
        }

        .empty-history{
            padding:3rem 1.5rem;
            text-align:center;
            border:1px dashed var(--hairline);
            border-radius:14px;
            background:#fff;
        }

        .empty-history i{
            display:block;
            margin-bottom:1rem;
            color:var(--headlight);
            font-size:2rem;
        }

        @media (max-width:767.98px){
            .history-card-head{
                flex-direction:column;
            }
        }
    </style>
</head>

<body>

<div class="container mt-4 history-page">

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">

        <div>

            <h2 class="mb-1">
                Rental History
            </h2>

            <p class="text-muted mb-0">
                Completed rentals include the full final financial settlement.
            </p>

        </div>


        <g:link
            controller="rental"
            action="index"
            class="btn btn-secondary">

            <i class="bi bi-arrow-left me-1"></i>
            Back to My Rentals

        </g:link>

    </div>


    <g:if test="${rentalList}">

        <g:each in="${rentalList}" var="rental">

            <!--
                Financial rules:

                Booking deposit is PART OF rental price.
                It is not added on top of rental price.

                Completed rental:
                remainingRental = totalPrice - bookingDeposit
                grossPaid       = totalPrice + securityDeposit
                securityRefund  = max(securityDeposit - damageCost, 0)
                extraDamageDue  = max(damageCost - securityDeposit, 0)
                finalNetCost    = totalPrice + damageCost
            -->

            <g:set
                var="bookingPaid"
                value="${rental.depositPaid ? (rental.bookingDeposit ?: 0) : 0}"/>

            <g:set
                var="remainingRental"
                value="${rental.status == 'COMPLETED' ?
                    ((rental.totalPrice ?: 0) - bookingPaid) : 0}"/>

            <g:set
                var="securityPaid"
                value="${rental.status == 'COMPLETED' ?
                    (rental.securityDeposit ?: 0) : 0}"/>

            <g:set
                var="grossPaid"
                value="${bookingPaid + remainingRental + securityPaid}"/>

            <g:set
                var="damage"
                value="${rental.status == 'COMPLETED' ?
                    (rental.damageCost ?: 0) : 0}"/>

            <g:set
                var="securityRefund"
                value="${rental.status == 'COMPLETED' ?
                    (((rental.securityDeposit ?: 0) - damage) > 0 ?
                        ((rental.securityDeposit ?: 0) - damage) : 0) : 0}"/>

            <g:set
                var="extraDamageDue"
                value="${rental.status == 'COMPLETED' ?
                    (damage > (rental.securityDeposit ?: 0) ?
                        (damage - (rental.securityDeposit ?: 0)) : 0) : 0}"/>

            <g:set
                var="finalNetCost"
                value="${rental.status == 'COMPLETED' ?
                    ((rental.totalPrice ?: 0) + damage) :
                    bookingPaid}"/>


            <article class="history-card">

                <div class="history-card-head">

                    <div>

                        <div class="history-car">
                            ${rental.car.brand}
                            ${rental.car.model}
                        </div>

                        <div class="history-meta">

                            ${rental.car.plateNumber}
                            &nbsp;•&nbsp;

                            <g:formatDate
                                date="${rental.startDate}"
                                format="dd MMM yyyy"/>

                            →

                            <g:formatDate
                                date="${rental.endDate}"
                                format="dd MMM yyyy"/>

                        </div>

                    </div>


                    <g:if test="${rental.status == 'COMPLETED'}">

                        <span class="history-status completed">
                            <i class="bi bi-check-circle"></i>
                            COMPLETED
                        </span>

                    </g:if><g:elseif test="${rental.status == 'CANCELLED'}">

                        <span class="history-status cancelled">
                            <i class="bi bi-x-circle"></i>
                            CANCELLED
                        </span>

                    </g:elseif>

                </div>


                <div class="history-body">

                    <g:if test="${rental.status == 'COMPLETED'}">

                        <div class="row g-4">

                            <div class="col-lg-7">

                                <div class="section-label">
                                    Payment Breakdown
                                </div>


                                <div class="settlement-box">

                                    <div class="settlement-row">
                                        <span>Full rental price</span>
                                        <strong>${rental.totalPrice}</strong>
                                    </div>

                                    <div class="settlement-row">
                                        <span>Booking deposit already paid</span>
                                        <strong>${bookingPaid}</strong>
                                    </div>

                                    <div class="settlement-row">
                                        <span>Remaining rental amount paid at pickup</span>
                                        <strong>${remainingRental}</strong>
                                    </div>

                                    <div class="settlement-row">
                                        <span>Refundable security deposit paid at pickup</span>
                                        <strong>${securityPaid}</strong>
                                    </div>

                                    <div class="settlement-row total-paid">
                                        <span>Total cash paid before vehicle return</span>
                                        <strong>${grossPaid}</strong>
                                    </div>

                                    <div class="settlement-row danger">
                                        <span>Damage deduction</span>
                                        <strong>${damage}</strong>
                                    </div>

                                    <div class="settlement-row positive">
                                        <span>Security deposit returned to you</span>
                                        <strong>${securityRefund}</strong>
                                    </div>


                                    <g:if test="${extraDamageDue > 0}">

                                        <div class="settlement-row danger">
                                            <span>Extra damage amount above security deposit</span>
                                            <strong>${extraDamageDue}</strong>
                                        </div>

                                    </g:if>

                                </div>

                            </div>


                            <div class="col-lg-5">

                                <div class="section-label">
                                    Final Settlement
                                </div>


                                <div class="final-cost">

                                    <small>
                                        Final amount actually spent
                                    </small>

                                    <strong>
                                        ${finalNetCost}
                                    </strong>

                                </div>


                                <div class="formula-note">

                                    <strong>How it was calculated:</strong>
                                    the booking deposit is part of the rental price,
                                    not an extra charge. Your final cost equals the
                                    full rental price plus any recorded damage cost.
                                    The unused part of the security deposit is returned.

                                </div>

                            </div>

                        </div>

                    </g:if><g:elseif test="${rental.status == 'CANCELLED'}">

                        <div class="section-label">
                            Cancellation Settlement
                        </div>


                        <g:if test="${rental.depositPaid}">

                            <div class="cancel-note">

                                <strong>
                                    Confirmed booking cancelled
                                </strong>

                                <div class="mt-2">
                                    Booking deposit paid:
                                    <strong>${rental.bookingDeposit}</strong>
                                </div>

                                <div>
                                    Booking deposit refunded:
                                    <strong>0.00</strong>
                                </div>

                                <div class="mt-2">
                                    Final cancellation cost:
                                    <strong>${finalNetCost}</strong>
                                </div>

                                <div class="mt-2">
                                    The booking deposit is non-refundable after
                                    the reservation has been confirmed.
                                </div>

                            </div>

                        </g:if><g:else>

                            <div class="settlement-box">

                                <div class="settlement-row">
                                    <span>Booking deposit paid</span>
                                    <strong>0.00</strong>
                                </div>

                                <div class="settlement-row positive">
                                    <span>Final cancellation cost</span>
                                    <strong>0.00</strong>
                                </div>

                            </div>

                        </g:else>

                    </g:elseif>

                </div>

            </article>

        </g:each>

    </g:if><g:else>

        <div class="empty-history">

            <i class="bi bi-clock-history"></i>

            <h4>
                No rental history yet
            </h4>

            <p class="text-muted mb-0">
                Completed or cancelled rentals will appear here.
            </p>

        </div>

    </g:else>


    <g:if test="${(rentalCount ?: 0) > 10}">

        <div class="app-pagination">

            <g:paginate
                total="${rentalCount ?: 0}"
                max="10"
                action="history"/>

        </div>

    </g:if>

</div>

</body>
</html>
