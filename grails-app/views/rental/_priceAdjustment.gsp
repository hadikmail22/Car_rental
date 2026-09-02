<g:set
    var="bookingPaid"
    value="${rental.depositPaid ? (rental.bookingDeposit ?: 0) : 0}"/>

<g:set
    var="remainingRentalAmount"
    value="${rental.totalPrice > bookingPaid ?
        (rental.totalPrice - bookingPaid) : 0}"/>

<g:set
    var="bookingCredit"
    value="${bookingPaid > rental.totalPrice ?
        (bookingPaid - rental.totalPrice) : 0}"/>

<div class="price-adjustment-box">

    <div class="price-adjustment-summary">
        System price:
        <strong>${rental.systemCalculatedPrice ?: rental.totalPrice}</strong>
        <br/>
        Current final price:
        <strong>${rental.totalPrice}</strong>
        <br/>
        Includes the booking deposit.
        <br/>
        Remaining rental amount:
        <strong>${remainingRentalAmount}</strong>
        <g:if test="${bookingCredit > 0}">
            <br/>
            Booking credit to return:
            <strong>${bookingCredit}</strong>
        </g:if>
    </div>

    <g:form
        action="adjustPrice"
        id="${rental.id}"
        method="POST">

        <div class="mb-2">
            <label
                for="finalPrice-${rental.id}"
                class="return-label">
                Final Rental Price
            </label>

            <input
                type="number"
                id="finalPrice-${rental.id}"
                name="finalPrice"
                value="${rental.totalPrice}"
                min="0"
                step="0.01"
                required
                class="form-control form-control-sm"/>
        </div>

        <div class="mb-2">
            <label
                for="priceReason-${rental.id}"
                class="return-label">
                Adjustment Reason
            </label>

            <textarea
                id="priceReason-${rental.id}"
                name="reason"
                maxlength="500"
                required
                class="form-control form-control-sm"
                placeholder="Family discount, manager approval..."></textarea>
        </div>

        <button
            type="submit"
            class="btn btn-primary btn-sm"
            onclick="return confirm('Change the full final rental price? This amount includes the booking deposit.');">
            <i class="bi bi-cash-coin me-1"></i>
            Update Final Price
        </button>

    </g:form>

    <g:if test="${adjustments}">
        <details class="price-adjustment-history">
            <summary>
                Price history (${adjustments.size()})
            </summary>

            <g:each in="${adjustments}" var="adjustment">
                <div class="price-adjustment-record">
                    <strong>
                        ${adjustment.previousPrice}
                        →
                        ${adjustment.newPrice}
                    </strong>
                    <br/>
                    ${adjustment.reason}
                    <br/>
                    ${adjustment.adjustedBy.username}
                    ·
                    <g:formatDate
                        date="${adjustment.dateCreated}"
                        format="dd MMM yyyy HH:mm"/>
                </div>
            </g:each>
        </details>
    </g:if>

</div>
