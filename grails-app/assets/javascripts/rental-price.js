function calculateRentalPrice() {

    const startInput = document.getElementById('startDate');
    const endInput = document.getElementById('endDate');
    const priceElement = document.getElementById('pricePerDayValue');

    const rentalDaysElement = document.getElementById('rentalDays');
    const totalPriceElement = document.getElementById('totalPrice');
    const dateError = document.getElementById('dateError');
    const createButton = document.getElementById('createRentalButton');

    if (!startInput || !endInput || !priceElement) {
        return;
    }

    const startValue = startInput.value;
    const endValue = endInput.value;

    const pricePerDay = parseFloat(priceElement.dataset.price);

    if (!startValue || !endValue) {
        rentalDaysElement.textContent = 'Select dates';
        totalPriceElement.textContent = 'Select dates';
        dateError.style.display = 'none';
        return;
    }

    const startDate = new Date(startValue + 'T00:00:00');
    const endDate = new Date(endValue + 'T00:00:00');

    if (endDate < startDate) {
        rentalDaysElement.textContent = '-';
        totalPriceElement.textContent = '-';

        dateError.style.display = 'block';
        createButton.disabled = true;
        return;
    }

    dateError.style.display = 'none';
    createButton.disabled = false;

    const oneDay = 1000 * 60 * 60 * 24;

    const rentalDays =
        Math.round(
            (endDate.getTime() - startDate.getTime()) / oneDay
        ) + 1;

    const totalPrice =
        rentalDays * pricePerDay;

    rentalDaysElement.textContent =
        rentalDays + (rentalDays === 1 ? ' day' : ' days');

    totalPriceElement.textContent =
        totalPrice.toFixed(2);
}


document.addEventListener('DOMContentLoaded', function () {

    const startInput =
        document.getElementById('startDate');

    const endInput =
        document.getElementById('endDate');

    if (startInput) {
        startInput.addEventListener(
            'change',
            calculateRentalPrice
        );
    }

    if (endInput) {
        endInput.addEventListener(
            'change',
            calculateRentalPrice
        );
    }

});