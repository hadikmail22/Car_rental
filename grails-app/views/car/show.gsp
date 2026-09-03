<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>${car.brand} ${car.model} | Car Rental</title>
    <style>
        .car-detail-page{--ink:#171717;--copy:#606060;--line:#ddd;--paper:#f7f7f7;--card:#fff;--yellow:#f7dc6f;--yellow-dark:#e3c54f;--blue:#3178c6;--blue-dark:#245d9d;--green:#278659;color:var(--ink);padding:18px 0 56px}
        .car-detail-page *{box-sizing:border-box}.car-detail-page a{text-decoration:none}
        .detail-back{display:inline-flex;align-items:center;gap:8px;margin-bottom:18px;color:var(--blue-dark);font-size:.74rem;font-weight:800}.detail-back:hover{color:var(--ink)}
        .detail-alert{margin-bottom:20px;padding:13px 15px;background:#fff8d8;border:1px solid var(--yellow-dark);border-radius:10px;font-size:.8rem}
        .detail-hero{display:grid;grid-template-columns:minmax(0,1.2fr) minmax(300px,.8fr);gap:28px;align-items:start}
        .detail-main-image{position:relative;min-height:430px;overflow:hidden;background:linear-gradient(135deg,#edf4fb,#d8e7f3);border:1px solid var(--line);border-radius:18px;box-shadow:8px 8px 0 rgba(49,120,198,.12)}
        .detail-main-image img{width:100%;height:430px;display:block;object-fit:cover;transition:transform .35s ease}.detail-main-image:hover img{transform:scale(1.025)}
        .detail-fallback{height:430px;display:grid;place-items:center;color:var(--blue);background:radial-gradient(circle at 50% 40%,rgba(247,220,111,.8),transparent 28%),#e7f0fa;font-size:6rem}
        .detail-photo-count{position:absolute;right:15px;bottom:15px;display:inline-flex;align-items:center;gap:7px;padding:8px 11px;color:#fff;background:rgba(23,23,23,.76);border-radius:999px;font-size:.65rem;font-weight:800}
        .detail-thumbnails{display:flex;gap:10px;margin-top:12px;overflow-x:auto;padding:2px 1px 5px}.detail-thumb{width:92px;height:68px;flex:0 0 auto;padding:0;overflow:hidden;background:#fff;border:2px solid transparent;border-radius:10px;box-shadow:0 5px 12px rgba(23,23,23,.08);cursor:pointer}
        .detail-thumb img{width:100%;height:100%;display:block;object-fit:cover}.detail-thumb:hover,.detail-thumb.is-active{border-color:var(--blue);transform:translateY(-2px)}
        .detail-info{position:sticky;top:105px;padding:28px;background:var(--card);border:1px solid var(--line);border-radius:18px;box-shadow:8px 8px 0 rgba(23,23,23,.07)}
        .detail-topline{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-bottom:17px}.detail-category,.detail-status{display:inline-flex;align-items:center;gap:6px;padding:6px 9px;border-radius:999px;font-size:.59rem;font-weight:800;letter-spacing:.07em;text-transform:uppercase}
        .detail-category{color:var(--blue-dark);background:#e7f0fa}.detail-status:before{content:"";width:6px;height:6px;border-radius:50%;background:currentColor}.detail-status.available{color:var(--green);background:#e6f4ec}.detail-status.rented{color:var(--blue);background:#e7f0fa}.detail-status.maintenance{color:#7c6500;background:#fff8d8}
        .detail-info h1{margin:0;font-size:clamp(2rem,4vw,3.25rem);font-weight:800;line-height:.98;letter-spacing:-.075em}.detail-subtitle{margin:12px 0 0;color:var(--copy);font-size:.82rem;line-height:1.65}
        .detail-rate-card{margin:24px 0 18px;padding:18px;background:var(--paper);border:1px solid var(--line);border-radius:14px}.detail-rate-label{display:block;margin-bottom:7px;color:var(--copy);font-size:.6rem;font-weight:800;letter-spacing:.1em}.detail-rate-row{display:flex;align-items:flex-end;gap:9px}.detail-rate{color:var(--blue-dark);font-size:2rem;font-weight:800;letter-spacing:-.07em;line-height:1}.detail-rate small{color:var(--copy);font-size:.65rem;letter-spacing:0}.detail-base-rate{margin-bottom:2px;color:#8e8e8e;font-size:.72rem;text-decoration:line-through}
        .detail-offer,.detail-increase{display:flex;gap:11px;align-items:flex-start;margin-bottom:18px;padding:13px;border-radius:12px;font-size:.68rem}.detail-offer{color:#5a4800;background:#fff8d8;border:1px solid var(--yellow-dark)}.detail-increase{color:var(--blue-dark);background:#e7f0fa;border:1px solid #b8d2ed}.detail-offer strong{display:block;font-size:.72rem}.detail-offer span{display:block;margin-top:3px;line-height:1.45}
        .detail-cta{width:100%;min-height:52px;display:inline-flex;align-items:center;justify-content:center;gap:9px;color:var(--ink);background:var(--yellow);border:1px solid var(--yellow-dark);border-radius:10px;box-shadow:0 9px 20px rgba(227,197,79,.30);font-size:.8rem;font-weight:800}.detail-cta:hover{color:var(--ink);transform:translateY(-2px)}.detail-disabled{color:#777;background:#eee;border-color:#d9d9d9;box-shadow:none;cursor:not-allowed}.detail-note{margin:10px 0 0;color:var(--copy);font-size:.64rem;line-height:1.5;text-align:center}
        .detail-admin-actions{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:14px}.detail-admin-btn{min-height:42px;display:inline-flex;align-items:center;justify-content:center;gap:7px;color:var(--blue-dark);background:#fff;border:1px solid #b8d2ed;border-radius:9px;font-size:.7rem;font-weight:800}.detail-admin-btn:hover{color:#fff;background:var(--blue);border-color:var(--blue)}.detail-delete{color:#d92828;border-color:#ffaaaa}.detail-delete:hover{background:#d92828;border-color:#d92828}
        .detail-lower{display:grid;grid-template-columns:minmax(0,1fr) minmax(280px,.5fr);gap:22px;margin-top:28px}.detail-panel{padding:24px;background:var(--card);border:1px solid var(--line);border-radius:16px;box-shadow:5px 5px 0 rgba(23,23,23,.06)}.detail-panel-head{display:flex;align-items:center;justify-content:space-between;gap:10px;margin-bottom:19px}.detail-panel h2{margin:0;font-size:1.02rem;font-weight:800;letter-spacing:-.035em}.detail-panel-head span{color:var(--copy);font-size:.62rem}
        .detail-specs{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px}.detail-spec{min-height:96px;padding:15px;background:var(--paper);border:1px solid var(--line);border-radius:12px}.detail-spec i{display:block;margin-bottom:12px;color:var(--blue);font-size:1rem}.detail-spec span,.detail-spec strong{display:block}.detail-spec span{color:var(--copy);font-size:.57rem;font-weight:800;letter-spacing:.09em}.detail-spec strong{margin-top:4px;font-size:.82rem;font-weight:800}
        .detail-pricing-copy{margin:0;color:var(--copy);font-size:.73rem;line-height:1.65}.detail-duration-list{display:grid;gap:9px;margin-top:17px}.detail-duration{display:flex;justify-content:space-between;gap:12px;padding:11px 12px;background:var(--paper);border:1px solid var(--line);border-radius:10px;font-size:.68rem}.detail-duration span{color:var(--copy)}.detail-duration strong{color:var(--green);font-size:.72rem}.detail-duration.standard strong{color:var(--copy)}
        @media(max-width:991px){.detail-hero,.detail-lower{grid-template-columns:1fr}.detail-info{position:static}}@media(max-width:600px){.car-detail-page{padding-top:5px}.detail-main-image,.detail-main-image img,.detail-fallback{min-height:280px;height:280px}.detail-info,.detail-panel{padding:19px;border-radius:14px}.detail-specs,.detail-admin-actions{grid-template-columns:1fr}}
    </style>
</head>
<body>
<g:set var="galleryImages" value="${car.galleryImages ? car.galleryImages.toList().sort { it.id } : []}"/>
<g:set var="galleryPhotoCount" value="${galleryImages.size() + (car.carImage ? 1 : 0)}"/>
<div class="container car-detail-page">
    <g:link action="index" class="detail-back"><i class="bi bi-arrow-left"></i>Back to Fleet</g:link>
    <g:if test="${flash.message}"><div class="detail-alert">${flash.message}</div></g:if>
    <section class="detail-hero">
        <div>
            <div class="detail-main-image">
                <g:if test="${car.carImage}">
                    <img data-detail-main-image src="${createLink(controller:'car', action:'image', id:car.id)}" alt="${car.brand} ${car.model}"/>
                </g:if>
                <g:elseif test="${galleryImages}">
                    <img data-detail-main-image src="${createLink(controller:'car', action:'galleryImage', id:galleryImages.first().id)}" alt="${car.brand} ${car.model}"/>
                </g:elseif>
                <g:else><div class="detail-fallback"><i class="bi bi-car-front-fill"></i></div></g:else>
                <g:if test="${galleryPhotoCount > 0}"><span class="detail-photo-count"><i class="bi bi-images"></i>${galleryPhotoCount} ${galleryPhotoCount == 1 ? 'photo' : 'photos'}</span></g:if>
            </div>
            <g:if test="${galleryPhotoCount > 1}">
                <div class="detail-thumbnails" aria-label="Car photos">
                    <g:if test="${car.carImage}">
                        <button type="button" class="detail-thumb is-active" data-detail-thumbnail data-image-src="${createLink(controller:'car', action:'image', id:car.id)}" data-image-alt="${car.brand} ${car.model}"><img src="${createLink(controller:'car', action:'image', id:car.id)}" alt="${car.brand} ${car.model} main photo"/></button>
                    </g:if>
                    <g:each in="${galleryImages}" var="galleryImage" status="galleryIndex">
                        <button type="button" class="detail-thumb ${!car.carImage && galleryIndex == 0 ? 'is-active' : ''}" data-detail-thumbnail data-image-src="${createLink(controller:'car', action:'galleryImage', id:galleryImage.id)}" data-image-alt="${car.brand} ${car.model} photo ${galleryIndex + 1}"><img src="${createLink(controller:'car', action:'galleryImage', id:galleryImage.id)}" alt="${car.brand} ${car.model} photo ${galleryIndex + 1}"/></button>
                    </g:each>
                </div>
            </g:if>
        </div>
        <aside class="detail-info">
            <div class="detail-topline"><span class="detail-category"><i class="bi bi-grid-3x3-gap"></i>${car.category?.name ?: 'Vehicle'}</span><g:if test="${car.status == 'AVAILABLE'}"><span class="detail-status available">Available</span></g:if><g:elseif test="${car.status == 'RENTED'}"><span class="detail-status rented">Rented</span></g:elseif><g:else><span class="detail-status maintenance">Maintenance</span></g:else></div>
            <h1>${car.brand} ${car.model}</h1><p class="detail-subtitle">${car.year} model · ${car.category?.name ?: 'Reliable rental vehicle'}</p>
            <div class="detail-rate-card"><span class="detail-rate-label">${currentPricing?.activeDiscount || currentPricing?.activeIncrease ? 'CURRENT DAILY RATE' : 'BASE DAILY RATE'}</span><div class="detail-rate-row"><div class="detail-rate"><g:formatNumber number="${currentPricing?.effectivePrice ?: car.pricePerDay}" minFractionDigits="2" maxFractionDigits="2"/><small>/ DAY</small></div><g:if test="${currentPricing?.activeDiscount}"><span class="detail-base-rate"><g:formatNumber number="${car.pricePerDay}" minFractionDigits="2" maxFractionDigits="2"/></span></g:if></div></div>
            <g:if test="${currentPricing?.activeDiscount}"><div class="detail-offer"><i class="bi bi-tag-fill"></i><div><strong>${currentPricing.currentHighlight.name} · SAVE ${currentPricing.currentHighlight.percentage}%</strong><span>This active offer is already included in today's daily rate.</span></div></div></g:if>
            <g:if test="${currentPricing?.activeIncrease}"><div class="detail-increase"><i class="bi bi-calendar-range"></i>${currentPricing.currentHighlight.name} is active in today's rate.</div></g:if>
            <sec:ifAllGranted roles="ROLE_CUSTOMER">
                <g:if test="${car.status == 'AVAILABLE'}"><g:link controller="rental" action="create" params="[carId: car.id]" class="detail-cta"><i class="bi bi-calendar-plus"></i>Reserve This Car</g:link><p class="detail-note">Select your dates next to see the final price and duration discount.</p></g:if>
                <g:else><span class="detail-cta detail-disabled"><i class="bi bi-clock-history"></i>Currently Unavailable</span></g:else>
            </sec:ifAllGranted>
            <sec:ifAllGranted roles="ROLE_ADMIN"><div class="detail-admin-actions"><g:link action="edit" id="${car.id}" class="detail-admin-btn"><i class="bi bi-pencil-square"></i>Edit Car</g:link><g:form action="delete" id="${car.id}" method="DELETE" class="m-0"><button type="submit" class="detail-admin-btn detail-delete w-100" onclick="return confirm('Are you sure you want to delete this car?');"><i class="bi bi-trash3"></i>Delete</button></g:form></div></sec:ifAllGranted>
        </aside>
    </section>
    <section class="detail-lower">
        <div class="detail-panel"><div class="detail-panel-head"><h2>Vehicle Details</h2><span>READY FOR YOUR TRIP</span></div><div class="detail-specs"><div class="detail-spec"><i class="bi bi-car-front"></i><span>BRAND</span><strong>${car.brand}</strong></div><div class="detail-spec"><i class="bi bi-box-seam"></i><span>MODEL</span><strong>${car.model}</strong></div><div class="detail-spec"><i class="bi bi-calendar3"></i><span>YEAR</span><strong>${car.year}</strong></div><div class="detail-spec"><i class="bi bi-credit-card-2-front"></i><span>PLATE NUMBER</span><strong>${car.plateNumber}</strong></div></div></div>
        <sec:ifAllGranted roles="ROLE_CUSTOMER"><div class="detail-panel"><div class="detail-panel-head"><h2>Longer Rental, Better Rate</h2><span>APPLIES AT CHECKOUT</span></div><p class="detail-pricing-copy">Your final total is calculated for the exact dates you choose. Active car offers and rental-duration discounts can apply together.</p><div class="detail-duration-list"><div class="detail-duration standard"><span>1–2 days</span><strong>Standard rate</strong></div><div class="detail-duration"><span>3–6 days</span><strong>Save 5%</strong></div><div class="detail-duration"><span>7–13 days</span><strong>Save 12%</strong></div><div class="detail-duration"><span>14+ days</span><strong>Save 20%</strong></div></div></div></sec:ifAllGranted>
        <sec:ifAllGranted roles="ROLE_ADMIN"><div class="detail-panel"><div class="detail-panel-head"><h2>Pricing Status</h2><span>ADMIN VIEW</span></div><p class="detail-pricing-copy">The shown daily rate uses only rules active today. Future pricing rules remain hidden until their start date.</p></div></sec:ifAllGranted>
    </section>
</div>
<script>
document.querySelectorAll('[data-detail-thumbnail]').forEach((thumbnail)=>{thumbnail.addEventListener('click',()=>{const mainImage=document.querySelector('[data-detail-main-image]');if(!mainImage||!thumbnail.dataset.imageSrc)return;mainImage.src=thumbnail.dataset.imageSrc;mainImage.alt=thumbnail.dataset.imageAlt||mainImage.alt;document.querySelectorAll('[data-detail-thumbnail]').forEach((item)=>item.classList.toggle('is-active',item===thumbnail));});});
</script>
</body>
</html>
