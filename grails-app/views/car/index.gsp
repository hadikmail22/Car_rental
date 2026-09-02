<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Fleet</title>

    <link
        href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500;600&family=IBM+Plex+Sans+Condensed:wght@600;700&display=swap"
        rel="stylesheet"/>

    <style>

        .fleet{
            --paper:#f2f1ec;
            --paper-2:#e8e6df;
            --card:#faf9f6;
            --rule:#d4d2ca;
            --rule-soft:#e2e0d8;

            --ink:#141412;
            --ink-2:#3d3b36;
            --ink-3:#6e6c64;
            --ink-4:#94918a;

            --accent:#16324f;
            --accent-2:#2b5480;
            --accent-soft:#e4e9ef;

            --ok:#2c6e49;
            --ok-soft:#e5efe8;
            --busy:#8a5a1c;
            --busy-soft:#f2ead9;
            --stop:#9c3028;
            --stop-soft:#f4e5e3;

            font-family:'IBM Plex Sans', sans-serif;
            color:var(--ink-2);
            padding-bottom:3rem;
        }

        body:has(.fleet){
            background:var(--paper) !important;
        }

        .fleet ::selection{
            background:var(--accent);
            color:#fff;
        }

        .fleet-head{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:1.5rem;
            flex-wrap:wrap;
            padding-bottom:.9rem;
            border-bottom:2px solid var(--ink);
            margin-bottom:1.4rem;
        }

        .fleet-eyebrow{
            font-family:'IBM Plex Mono', monospace;
            font-size:.63rem;
            font-weight:500;
            letter-spacing:.16em;
            color:var(--ink-4);
            margin-bottom:.3rem;
        }

        .fleet-title{
            font-family:'IBM Plex Sans Condensed', sans-serif;
            font-size:2.5rem;
            font-weight:700;
            line-height:.95;
            letter-spacing:-.02em;
            color:var(--ink);
            margin:0;
        }

        .fleet-sub{
            font-size:.85rem;
            color:var(--ink-3);
            margin:.4rem 0 0;
        }

        .pbtn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:.45rem;
            min-height:38px;
            padding:0 1rem;
            border-radius:2px;
            border:1px solid transparent;
            font-family:'IBM Plex Sans', sans-serif;
            font-size:.83rem;
            font-weight:500;
            text-decoration:none;
            cursor:pointer;
            transition:background .13s ease, color .13s ease, border-color .13s ease;
        }

        .pbtn-solid{
            background:var(--ink);
            color:var(--card);
            border-color:var(--ink);
        }
        .pbtn-solid:hover,
        .pbtn-solid:focus-visible{
            background:var(--accent);
            border-color:var(--accent);
            color:#fff;
        }

        .pbtn-line{
            background:transparent;
            color:var(--ink-2);
            border-color:var(--rule);
        }
        .pbtn-line:hover,
        .pbtn-line:focus-visible{
            background:var(--ink);
            border-color:var(--ink);
            color:var(--card);
        }

        .pbtn-accent{
            background:var(--accent);
            color:#fff;
            border-color:var(--accent);
        }
        .pbtn-accent:hover,
        .pbtn-accent:focus-visible{
            background:var(--accent-2);
            border-color:var(--accent-2);
        }

        .pbtn[disabled]{
            background:var(--paper-2);
            color:var(--ink-4);
            border-color:var(--rule);
            cursor:not-allowed;
        }

        .fleet-search{
            display:grid;
            grid-template-columns:
                minmax(240px,1fr)
                minmax(170px,210px)
                125px
                125px
                auto
                auto
                auto;
            align-items:end;
            gap:.5rem;
            padding:.8rem;
            margin-bottom:1.6rem;
            background:var(--card);
            border:1px solid var(--rule);
            border-top:3px solid var(--ink);
            border-radius:2px;
        }

        .fleet-search-field{
            min-width:0;
            display:grid;
            gap:.3rem;
        }

        .fleet-search-label{
            font-family:'IBM Plex Mono', monospace;
            font-size:.55rem;
            font-weight:600;
            letter-spacing:.1em;
            color:var(--ink-4);
        }

        .fleet-search input[type="text"],
        .fleet-search input[type="number"]{
            width:100%;
            min-width:0;
            height:38px;
            padding:0 .8rem;
            background:var(--card);
            border:1px solid var(--rule);
            border-radius:2px;
            font-family:'IBM Plex Sans', sans-serif;
            font-size:.86rem;
            color:var(--ink);
            outline:none;
        }

        .fleet-search input[type="text"]::placeholder,
        .fleet-search input[type="number"]::placeholder{
            color:var(--ink-4);
        }

        .fleet-search input[type="text"]:focus,
        .fleet-search input[type="number"]:focus{
            border-color:var(--accent);
            box-shadow:inset 0 0 0 1px var(--accent);
        }

        .fleet-search select{
            width:100%;
            min-width:0;
            height:38px;
            padding:0 2rem 0 .8rem;
            background:var(--card);
            border:1px solid var(--rule);
            border-radius:2px;
            font-family:'IBM Plex Mono', monospace;
            font-size:.75rem;
            letter-spacing:.03em;
            color:var(--ink);
            outline:none;
            appearance:none;
            background-image:
                linear-gradient(45deg, transparent 50%, var(--ink-3) 50%),
                linear-gradient(135deg, var(--ink-3) 50%, transparent 50%);
            background-position:
                calc(100% - 15px) 17px,
                calc(100% - 10px) 17px;
            background-size:5px 5px, 5px 5px;
            background-repeat:no-repeat;
            cursor:pointer;
        }

        .fleet-search select:focus{
            border-color:var(--accent);
            box-shadow:inset 0 0 0 1px var(--accent);
        }

        .fleet-offer-toggle{
            min-height:38px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:.5rem;
            padding:0 .8rem;
            color:var(--ok);
            background:var(--ok-soft);
            border:1px solid #bfd5c7;
            border-radius:2px;
            font-family:'IBM Plex Mono', monospace;
            font-size:.62rem;
            font-weight:600;
            letter-spacing:.06em;
            cursor:pointer;
            white-space:nowrap;
        }

        .fleet-offer-toggle input{
            width:15px;
            height:15px;
            margin:0;
            accent-color:var(--ok);
            cursor:pointer;
        }

        .fleet-filter-error{
            grid-column:1/-1;
            padding:.55rem .7rem;
            color:var(--stop);
            background:var(--stop-soft);
            border-left:4px solid var(--stop);
            font-size:.78rem;
        }

        .rate-base{
            display:block;
            margin-top:.15rem;
            color:var(--ink-4);
            font-family:'IBM Plex Mono', monospace;
            font-size:.6rem;
            text-decoration:line-through;
        }

        .fleet-grid{
            display:grid;
            grid-template-columns:repeat(2, minmax(0,1fr));
            gap:1.1rem;
        }

        .unit{
            background:var(--card);
            border:1px solid var(--rule);
            border-top:5px solid var(--ink);
            border-radius:2px;
            display:flex;
            flex-direction:column;
            transition:
                border-color .15s ease,
                transform .15s ease,
                box-shadow .15s ease;
        }

        .unit:hover{
            border-color:var(--ink);
            border-top-color:var(--accent);
            transform:translate(-3px,-3px);
            box-shadow:6px 6px 0 rgba(20,20,18,.13);
        }

        .unit:hover .unit-shot img{
            transform:scale(1.045);
        }

        .unit:hover .plate{
            border-color:var(--accent);
        }

        .unit-head{
            padding:.7rem .9rem .6rem;
            border-bottom:1px dashed var(--rule);
        }

        .unit-meta{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:.6rem;
            font-family:'IBM Plex Mono', monospace;
            font-size:.6rem;
            font-weight:500;
            letter-spacing:.1em;
            color:var(--ink-4);
        }

        .unit-name{
            font-family:'IBM Plex Sans Condensed', sans-serif;
            font-size:1.35rem;
            font-weight:700;
            letter-spacing:-.015em;
            color:var(--ink);
            margin-top:.25rem;
            line-height:1.15;
        }

        .ustat{
            display:inline-flex;
            align-items:center;
            gap:.35rem;
            padding:.16rem .45rem;
            border-radius:2px;
            font-family:'IBM Plex Mono', monospace;
            font-size:.58rem;
            font-weight:600;
            letter-spacing:.08em;
            white-space:nowrap;
        }

        .ustat::before{
            content:"";
            width:5px;
            height:5px;
            border-radius:50%;
            background:currentColor;
        }

        .ustat-ok{ background:var(--ok-soft); color:var(--ok); }
        .ustat-busy{ background:var(--accent-soft); color:var(--accent); }
        .ustat-stop{ background:var(--busy-soft); color:var(--busy); }

        .unit-shot{
            position:relative;
            height:190px;
            background:var(--paper-2);
            border-bottom:1px dashed var(--rule);
            overflow:hidden;
        }

        .unit-shot img{
            width:100%;
            height:100%;
            object-fit:cover;
            display:block;
            cursor:pointer;
            transition:transform .3s ease;
        }

        .unit-shot-empty{
            width:100%;
            height:100%;
            display:flex;
            flex-direction:column;
            align-items:center;
            justify-content:center;
            gap:.4rem;
            color:var(--ink-4);
            background:
                repeating-linear-gradient(
                    45deg,
                    var(--paper-2),
                    var(--paper-2) 9px,
                    #e2e0d8 9px,
                    #e2e0d8 18px
                );
        }

        .unit-shot-empty span{
            font-family:'IBM Plex Mono', monospace;
            font-size:.6rem;
            letter-spacing:.1em;
        }

        .price-flag{
            position:absolute;
            top:.7rem;
            left:.7rem;
            z-index:3;
            display:inline-flex;
            align-items:center;
            gap:.45rem;
            min-height:44px;
            padding:.55rem .75rem;
            border:2px solid rgba(255,255,255,.8);
            border-radius:2px;
            box-shadow:5px 5px 0 rgba(20,20,18,.28);
            font-family:'IBM Plex Mono', monospace;
            font-size:.72rem;
            font-weight:600;
            letter-spacing:.08em;
            cursor:pointer;
            appearance:none;
            transition:
                transform .14s ease,
                box-shadow .14s ease,
                filter .14s ease;
        }

        .price-flag:hover,
        .price-flag:focus-visible{
            transform:translate(-2px,-2px);
            box-shadow:7px 7px 0 rgba(20,20,18,.3);
            filter:brightness(1.08);
            outline:none;
        }

        .price-flag-action{
            padding-left:.45rem;
            border-left:1px solid rgba(255,255,255,.55);
            font-size:.58rem;
            letter-spacing:.1em;
        }

        .price-flag-chevron{
            font-size:.66rem;
            transition:transform .18s ease;
        }

        .price-flag[aria-expanded="true"] .price-flag-chevron{
            transform:rotate(180deg);
        }

        .price-flag-discount{
            background:var(--ok);
            color:#fff;
        }

        .price-flag-increase{
            background:var(--busy);
            color:#fff;
        }

        .unit-pricing{
            display:grid;
            gap:.5rem;
            padding:.7rem .9rem;
            border-bottom:1px dashed var(--rule);
            background:#f7f6f1;
        }

        .unit-pricing.collapse:not(.show){
            display:none;
        }

        .unit-pricing.collapse.show,
        .unit-pricing.collapsing{
            display:grid;
        }

        .price-record{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:.8rem;
            padding:.55rem .65rem;
            background:var(--card);
            border:1px solid var(--rule);
            border-left-width:4px;
        }

        .price-record-discount{
            border-left-color:var(--ok);
        }

        .price-record-increase{
            border-left-color:var(--busy);
        }

        .price-record-head{
            display:flex;
            align-items:center;
            gap:.45rem;
            flex-wrap:wrap;
        }

        .price-record-state{
            font-family:'IBM Plex Mono', monospace;
            font-size:.53rem;
            font-weight:600;
            letter-spacing:.09em;
            color:var(--ink-4);
        }

        .price-record-name{
            font-size:.78rem;
            font-weight:600;
            color:var(--ink);
        }

        .price-record-dates{
            display:block;
            margin-top:.16rem;
            font-family:'IBM Plex Mono', monospace;
            font-size:.58rem;
            letter-spacing:.02em;
            color:var(--ink-3);
        }

        .price-record-rate{
            flex:0 0 auto;
            text-align:right;
            font-family:'IBM Plex Mono', monospace;
        }

        .price-record-adjustment{
            display:block;
            font-size:.6rem;
            font-weight:600;
        }

        .price-record-discount .price-record-adjustment{
            color:var(--ok);
        }

        .price-record-increase .price-record-adjustment{
            color:var(--busy);
        }

        .price-record-value{
            display:block;
            font-size:.78rem;
            font-weight:600;
            color:var(--ink);
        }

        .pricing-help{
            font-family:'IBM Plex Mono', monospace;
            font-size:.55rem;
            color:var(--ink-4);
        }

        .unit-strip{
            display:flex;
            align-items:center;
            gap:.7rem;
            padding:.7rem .9rem;
            border-bottom:1px dashed var(--rule);
        }

        .plate{
            display:inline-flex;
            align-items:center;
            padding:.32rem .55rem;
            background:var(--ink);
            color:#f4f3ef;
            border:2px solid #46443e;
            border-radius:3px;
            font-family:'IBM Plex Mono', monospace;
            font-size:.78rem;
            font-weight:500;
            letter-spacing:.11em;
            white-space:nowrap;
            transition:border-color .15s ease;
        }

        .unit-specs{
            font-family:'IBM Plex Mono', monospace;
            font-size:.62rem;
            line-height:1.6;
            color:var(--ink-3);
        }

        .unit-specs b{
            color:var(--ink-2);
            font-weight:500;
        }

        .unit-foot{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:.7rem;
            padding:.75rem .9rem .85rem;
            margin-top:auto;
        }

        .rate-label{
            font-family:'IBM Plex Mono', monospace;
            font-size:.55rem;
            font-weight:500;
            letter-spacing:.12em;
            color:var(--ink-4);
        }

        .rate-value{
            font-family:'IBM Plex Sans Condensed', sans-serif;
            font-size:1.6rem;
            font-weight:700;
            letter-spacing:-.02em;
            color:var(--ink);
            line-height:1.1;
        }

        .unit-actions{
            display:flex;
            gap:.4rem;
            flex-wrap:wrap;
        }

        .unit-actions .pbtn{
            min-height:33px;
            padding:0 .7rem;
            font-size:.78rem;
        }

        .fleet-empty{
            padding:3.5rem 1.5rem;
            text-align:center;
            background:var(--card);
            border:1px dashed var(--rule);
            border-radius:2px;
        }

        .fleet-empty-title{
            font-family:'IBM Plex Sans Condensed', sans-serif;
            font-size:1.3rem;
            font-weight:700;
            color:var(--ink);
            margin-bottom:.3rem;
        }

        .fleet-empty p{
            color:var(--ink-3);
            font-size:.86rem;
            margin-bottom:1.1rem;
        }

        .fleet-flash{
            padding:.7rem .9rem;
            margin-bottom:1.2rem;
            background:var(--accent-soft);
            border:1px solid var(--accent);
            border-left-width:4px;
            border-radius:0;
            color:var(--accent);
            font-size:.85rem;
        }

        .fleet .modal-content{
            background:var(--card);
            border:1px solid var(--rule);
            border-radius:2px;
        }

        .fleet-pager{
            display:flex;
            justify-content:center;
            gap:.3rem;
            margin-top:2rem;
        }

        .fleet-pager .step,
        .fleet-pager .currentStep,
        .fleet-pager .prevLink,
        .fleet-pager .nextLink{
            min-width:34px;
            height:34px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            padding:0 .6rem;
            background:var(--card);
            border:1px solid var(--rule);
            border-radius:2px;
            box-shadow:none;
            font-family:'IBM Plex Mono', monospace;
            font-size:.75rem;
            color:var(--ink-2);
            text-decoration:none;
            transform:none;
        }

        .fleet-pager .step:hover,
        .fleet-pager .prevLink:hover,
        .fleet-pager .nextLink:hover{
            background:var(--ink);
            border-color:var(--ink);
            color:var(--card);
            transform:none;
            box-shadow:none;
        }

        .fleet-pager .currentStep{
            background:var(--accent);
            border-color:var(--accent);
            color:#fff;
            box-shadow:none;
        }

        @media (max-width: 900px){
            .fleet-search{
                grid-template-columns:repeat(2,minmax(0,1fr));
            }

            .fleet-grid{
                grid-template-columns:1fr;
            }
        }

        @media (max-width: 560px){
            .fleet-search{
                grid-template-columns:1fr;
            }

            .fleet-filter-error{
                grid-column:auto;
            }

            .fleet-search .pbtn{
                width:100%;
            }

            .fleet-title{
                font-size:2rem;
            }

            .fleet-head{
                align-items:flex-start;
            }

            .price-record{
                align-items:flex-start;
                flex-direction:column;
            }

            .price-record-rate{
                text-align:left;
            }
        }

    </style>
</head>

<body>

<div class="container mt-4 fleet">

    <div class="fleet-head">

        <div>

            <div class="fleet-eyebrow">
                VEHICLE REGISTER
            </div>

            <h2 class="fleet-title">
                Fleet
            </h2>

            <sec:ifAllGranted roles="ROLE_ADMIN">
                <p class="fleet-sub">
                    Browse and manage rental vehicles
                </p>
            </sec:ifAllGranted>

            <sec:ifAllGranted roles="ROLE_CUSTOMER">
                <p class="fleet-sub">
                    Browse available rental vehicles
                </p>
            </sec:ifAllGranted>

        </div>

        <sec:ifAllGranted roles="ROLE_ADMIN">

            <g:link
                action="create"
                class="pbtn pbtn-solid">

                <i class="bi bi-plus-lg"></i>
                Add New Car

            </g:link>

        </sec:ifAllGranted>

    </div>

    <g:if test="${flash.message}">

        <div class="fleet-flash">
            ${flash.message}
        </div>

    </g:if>

    <g:form
        action="index"
        method="GET"
        class="fleet-search">

        <label class="fleet-search-field">

            <span class="fleet-search-label">
                SEARCH
            </span>

            <input
                type="text"
                name="q"
                value="${q}"
                placeholder="Brand, model, plate, or category"/>

        </label>


        <label class="fleet-search-field">

            <span class="fleet-search-label">
                CATEGORY
            </span>

            <g:select
                name="categoryId"
                from="${categoryList}"
                optionKey="id"
                optionValue="name"
                value="${categoryId}"
                noSelection="${['': 'ALL CATEGORIES']}"
                aria-label="Filter cars by category"/>

        </label>


        <label class="fleet-search-field">

            <span class="fleet-search-label">
                PRICE FROM
            </span>

            <input
                type="number"
                name="minPrice"
                value="${minPrice}"
                min="0"
                step="0.01"
                placeholder="0.00"/>

        </label>


        <label class="fleet-search-field">

            <span class="fleet-search-label">
                PRICE TO
            </span>

            <input
                type="number"
                name="maxPrice"
                value="${maxPrice}"
                min="0"
                step="0.01"
                placeholder="Any"/>

        </label>


        <label class="fleet-offer-toggle">

            <g:if test="${offersOnly}">

                <input
                    type="checkbox"
                    name="offersOnly"
                    value="true"
                    checked="checked"/>

            </g:if><g:else>

                <input
                    type="checkbox"
                    name="offersOnly"
                    value="true"/>

            </g:else>

            <i class="bi bi-tags-fill"></i>
            Offers Only

        </label>

        <button
            type="submit"
            class="pbtn pbtn-solid">

            Search

        </button>

        <g:link
            action="index"
            class="pbtn pbtn-line">

            Clear

        </g:link>

        <g:if test="${priceRangeError}">

            <div class="fleet-filter-error">
                ${priceRangeError}
            </div>

        </g:if>

    </g:form>

    <g:if test="${carList}">

        <div class="fleet-grid">

            <g:each in="${carList}" var="car" status="i">

                <g:set
                    var="carPricingHighlights"
                    value="${pricingHighlightsByCar?.get(car.id) ?: []}"/>

                <g:set
                    var="primaryPricingHighlight"
                    value="${carPricingHighlights.find { it.current == true }}"/>

                <g:set
                    var="currentPricing"
                    value="${currentPricingByCar?.get(car.id)}"/>

                <article class="unit">

                    <div class="unit-head">

                        <div class="unit-meta">

                            <span>
                                UNIT
                                <g:formatNumber
                                    number="${car.id}"
                                    format="000"/>

                                <g:if test="${car.category?.name}">
                                    &middot;
                                    ${car.category.name.toUpperCase()}
                                </g:if>
                                <g:else>
                                    &middot; UNCLASSIFIED
                                </g:else>
                            </span>

                            <g:if test="${car.status == 'AVAILABLE'}">
                                <span class="ustat ustat-ok">
                                    IN SERVICE
                                </span>
                            </g:if>
                            <g:elseif test="${car.status == 'RENTED'}">
                                <span class="ustat ustat-busy">
                                    ON RENT
                                </span>
                            </g:elseif>
                            <g:else>
                                <span class="ustat ustat-stop">
                                    IN SHOP
                                </span>
                            </g:else>

                        </div>

                        <div class="unit-name">
                            ${car.brand} ${car.model}
                        </div>

                    </div>

                    <div class="unit-shot">

                        <g:if test="${primaryPricingHighlight}">

                            <g:set
                                var="primaryPricingClass"
                                value="${primaryPricingHighlight.adjustmentType == 'DISCOUNT' ? 'price-flag-discount' : 'price-flag-increase'}"/>

                            <button
                                type="button"
                                class="price-flag ${primaryPricingClass}"
                                data-bs-toggle="collapse"
                                data-bs-target="#pricingDetails${car.id}"
                                aria-expanded="false"
                                aria-controls="pricingDetails${car.id}">

                                <i class="bi ${primaryPricingHighlight.adjustmentType == 'DISCOUNT' ? 'bi-tags-fill' : 'bi-graph-up-arrow'}"></i>

                                <g:if test="${primaryPricingHighlight.adjustmentType == 'DISCOUNT'}">
                                    <g:formatNumber
                                        number="${primaryPricingHighlight.percentage}"
                                        maxFractionDigits="2"/>% OFF
                                </g:if>
                                <g:else>
                                    +<g:formatNumber
                                        number="${primaryPricingHighlight.percentage}"
                                        maxFractionDigits="2"/>% PRICE NOTICE
                                </g:else>

                                <span class="price-flag-action">
                                    ${primaryPricingHighlight.adjustmentType == 'DISCOUNT' ? 'VIEW OFFER' : 'VIEW DETAILS'}
                                </span>

                                <i class="bi bi-chevron-down price-flag-chevron"></i>

                            </button>

                        </g:if>

                        <g:if test="${car?.carImage}">

                            <img
                                src="${createLink(
                                    controller: 'car',
                                    action: 'image',
                                    id: car.id
                                )}"
                                alt="${car.brand} ${car.model}"
                                data-bs-toggle="modal"
                                data-bs-target="#shot${car.id}"/>

                        </g:if>
                        <g:else>

                            <div class="unit-shot-empty">
                                <i class="bi bi-camera"></i>
                                <span>NO PHOTO ON FILE</span>
                            </div>

                        </g:else>

                    </div>

                    <div class="unit-strip">

                        <span class="plate">
                            ${car.plateNumber}
                        </span>

                        <div class="unit-specs">
                            MODEL YEAR <b>${car.year}</b>
                        </div>

                    </div>

                    <g:if test="${primaryPricingHighlight}">

                        <div
                            id="pricingDetails${car.id}"
                            class="collapse unit-pricing">

                            <g:each
                                in="${[primaryPricingHighlight]}"
                                var="pricingHighlight">

                                <g:set
                                    var="pricingRecordClass"
                                    value="${pricingHighlight.adjustmentType == 'DISCOUNT' ? 'price-record-discount' : 'price-record-increase'}"/>

                                <div class="price-record ${pricingRecordClass}">

                                    <div>

                                        <div class="price-record-head">

                                            <span class="price-record-state">
                                                ACTIVE NOW
                                            </span>

                                            <span class="price-record-name">
                                                ${pricingHighlight.name}
                                            </span>

                                        </div>

                                        <span class="price-record-dates">
                                            ${pricingHighlight.startDate}
                                            TO
                                            ${pricingHighlight.endDate}
                                            &middot;
                                            ${pricingHighlight.scope}
                                        </span>

                                    </div>

                                    <div class="price-record-rate">

                                        <span class="price-record-adjustment">

                                            <g:if test="${pricingHighlight.adjustmentType == 'DISCOUNT'}">
                                                -<g:formatNumber
                                                    number="${pricingHighlight.percentage}"
                                                    maxFractionDigits="2"/>%
                                            </g:if>
                                            <g:else>
                                                +<g:formatNumber
                                                    number="${pricingHighlight.percentage}"
                                                    maxFractionDigits="2"/>%
                                            </g:else>

                                        </span>

                                        <span class="price-record-value">
                                            <g:formatNumber
                                                number="${pricingHighlight.dailyPrice}"
                                                minFractionDigits="2"
                                                maxFractionDigits="2"/>
                                            / DAY
                                        </span>

                                    </div>

                                </div>

                            </g:each>

                            <span class="pricing-help">
                                FINAL TOTAL DEPENDS ON THE SELECTED RENTAL DATES
                            </span>

                        </div>

                    </g:if>

                    <div class="unit-foot">

                        <div>

                            <div class="rate-label">
                                ${currentPricing?.currentHighlight ? 'CURRENT DAILY RATE' : 'BASE DAILY RATE'}
                            </div>

                            <div class="rate-value">
                                ${currentPricing?.effectivePrice ?: car.pricePerDay}
                            </div>

                            <g:if test="${currentPricing?.activeDiscount}">

                                <span class="rate-base">
                                    ${car.pricePerDay}
                                </span>

                            </g:if>

                        </div>

                        <div class="unit-actions">

                            <g:link
                                action="show"
                                id="${car.id}"
                                class="pbtn pbtn-line">

                                Details

                            </g:link>

                            <sec:ifAllGranted roles="ROLE_ADMIN">

                                <g:link
                                    action="edit"
                                    id="${car.id}"
                                    class="pbtn pbtn-line">

                                    Edit

                                </g:link>

                            </sec:ifAllGranted>

                            <sec:ifAllGranted roles="ROLE_CUSTOMER">

                                <g:if test="${car.status != 'MAINTENANCE'}">

                                    <g:link
                                        controller="rental"
                                        action="create"
                                        params="[carId: car.id]"
                                        class="pbtn pbtn-accent">

                                        Reserve

                                    </g:link>

                                </g:if>
                                <g:else>

                                    <button
                                        type="button"
                                        class="pbtn"
                                        disabled>

                                        Unavailable

                                    </button>

                                </g:else>

                            </sec:ifAllGranted>

                        </div>

                    </div>

                </article>

                <g:if test="${car?.carImage}">

                    <div
                        class="modal fade"
                        id="shot${car.id}"
                        tabindex="-1"
                        aria-hidden="true">

                        <div class="modal-dialog modal-xl modal-dialog-centered">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">
                                        ${car.brand} ${car.model}
                                        &mdash;
                                        ${car.plateNumber}
                                    </h5>

                                    <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal">
                                    </button>

                                </div>

                                <div class="modal-body text-center">

                                    <img
                                        src="${createLink(
                                            controller: 'car',
                                            action: 'image',
                                            id: car.id
                                        )}"
                                        alt="${car.brand} ${car.model}"
                                        class="img-fluid modal-car-image"
                                        style="max-height:75vh; object-fit:contain;"/>

                                </div>

                            </div>

                        </div>

                    </div>

                </g:if>

            </g:each>

        </div>

    </g:if>
    <g:else>

        <div class="fleet-empty">

            <div class="fleet-empty-title">
                No vehicles on file
            </div>

            <p>
                <g:if test="${hasFilters}">
                    No vehicle matched the selected search and price filters.
                </g:if>
                <g:else>
                    The register is empty.
                </g:else>
            </p>

            <g:if test="${hasFilters}">

                <g:link
                    action="index"
                    class="pbtn pbtn-line">

                    Clear filters

                </g:link>

            </g:if>

            <sec:ifAllGranted roles="ROLE_ADMIN">

                <g:if test="${!hasFilters}">

                    <g:link
                        action="create"
                        class="pbtn pbtn-solid">

                        Add the first car

                    </g:link>

                </g:if>

            </sec:ifAllGranted>

        </div>

    </g:else>

    <div class="fleet-pager">

        <g:paginate
            total="${carCount ?: 0}"
            max="6"
            params="[
                q: q,
                categoryId: categoryId,
                minPrice: minPrice,
                maxPrice: maxPrice,
                offersOnly: offersOnly
            ]"/>

    </div>

</div>

</body>
</html>
