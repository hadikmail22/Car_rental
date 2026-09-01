<!doctype html>
<html>

<head>

    <meta
            name="layout"
            content="main"/>

    <title>
        Pricing Rules
    </title>


    <style>

        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --go-green:#1f8a52;
            --taillight:#e5484d;
            --blue-signal:#2560c4;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }


        .pricing-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
        }


        .pricing-page h2,
        .pricing-page h5{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
        }


        .pricing-page .text-muted{
            color:var(--ink-soft) !important;
        }


        /* New Rule Button */
        .btn-headlight{
            background:var(--headlight);
            border:none;
            color:var(--asphalt-900);
            border-radius:8px;
            font-weight:700;
            padding:.65rem 1.1rem;
        }


        .btn-headlight:hover,
        .btn-headlight:focus-visible{
            background:var(--headlight-dim);
            color:var(--asphalt-900);
        }


        /* Cards */
        .filter-card,
        .rules-card{
            border:1px solid var(--hairline);
            border-radius:14px;
            background:#fff;
        }


        /* Filters */
        .form-select{
            border-color:var(--hairline);
            border-radius:8px;
            padding:.6rem .85rem;
        }


        .form-select:focus{
            border-color:var(--headlight);
            box-shadow:0 0 0 .2rem rgba(245,166,35,.18);
        }


        .form-label,
        .table thead th{
            font-family:'JetBrains Mono', monospace;
            font-size:.72rem;
            font-weight:600;
            letter-spacing:.06em;
            text-transform:uppercase;
            color:var(--ink-soft);
        }


        /* Table */
        .table{
            margin-bottom:0;
        }


        .table > :not(caption) > * > *{
            padding:1rem .85rem;
            border-color:var(--hairline);
            vertical-align:middle;
        }


        .rule-name{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
        }


        .mono-value{
            font-family:'JetBrains Mono', monospace;
            font-size:.82rem;
        }


        /* Badges */
        .rule-badge{
            display:inline-flex;
            align-items:center;
            border-radius:999px;
            padding:.38rem .68rem;
            font-family:'JetBrains Mono', monospace;
            font-size:.7rem;
            font-weight:700;
            letter-spacing:.04em;
        }


        .rule-increase{
            background:#fff0ef;
            color:var(--taillight);
        }


        .rule-discount{
            background:#e8f6ee;
            color:var(--go-green);
        }


        .rule-active{
            background:#e8f6ee;
            color:var(--go-green);
        }


        .rule-inactive{
            background:#efefed;
            color:#777871;
        }


        .scope-badge{
            background:#edf2fb;
            color:var(--blue-signal);
        }


        /* Buttons */
        .btn-dark{
            background:var(--asphalt-900);
            border-color:var(--asphalt-900);
            border-radius:8px;
            font-weight:600;
        }


        .btn-dark:hover,
        .btn-dark:focus-visible{
            background:var(--asphalt-800);
            border-color:var(--asphalt-800);
        }


        .btn-outline-secondary,
        .btn-outline-dark{
            border-radius:8px;
            font-weight:600;
        }


        /* Empty State */
        .empty-state{
            padding:3rem 1rem;
            text-align:center;
            color:var(--ink-soft);
        }


        /* Flash Message */
        .alert-info{
            background:#fff6e6;
            border:1px solid #f0d9a6;
            color:#7a5a10;
            border-radius:8px;
        }


        @media (max-width:991px){

            .rules-table-wrap{
                overflow-x:auto;
            }

        }

    </style>

</head>


<body>

<div class="container mt-4 pricing-page">


    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-start mb-4 flex-wrap gap-3">


        <div>

            <h2 class="mb-1">
                Pricing Rules
            </h2>

            <p class="text-muted mb-0">
                Manage seasonal pricing, promotions and vehicle-specific offers
            </p>

        </div>


        <g:link
                action="create"
                class="btn btn-headlight">

            <i class="bi bi-plus-lg me-1"></i>

            New Pricing Rule

        </g:link>


    </div>


    <!-- Flash Message -->
    <g:if test="${flash.message}">

        <div class="alert alert-info mb-4">
            ${flash.message}
        </div>

    </g:if>


    <!-- Filters -->
    <div class="filter-card p-3 mb-4">

        <g:form
                action="index"
                method="GET"
                class="row g-3 align-items-end">


            <!-- Scope Filter -->
            <div class="col-md-4">

                <label
                        for="scope"
                        class="form-label">

                    Scope

                </label>

                <g:select
                        name="scope"
                        from="${[
                                'ALL',
                                'CATEGORY',
                                'CAR'
                        ]}"
                        value="${selectedScope}"
                        noSelection="${[
                                '': 'All scopes'
                        ]}"
                        class="form-select"/>

            </div>


            <!-- Status Filter -->
            <div class="col-md-4">

                <label
                        for="state"
                        class="form-label">

                    Status

                </label>

                <g:select
                        name="state"
                        from="${[
                                'ACTIVE',
                                'INACTIVE'
                        ]}"
                        value="${selectedState}"
                        noSelection="${[
                                '': 'All statuses'
                        ]}"
                        class="form-select"/>

            </div>


            <!-- Filter Actions -->
            <div class="col-md-4 d-flex gap-2">

                <button
                        type="submit"
                        class="btn btn-dark flex-grow-1">

                    Filter

                </button>


                <g:link
                        action="index"
                        class="btn btn-outline-secondary">

                    Clear

                </g:link>

            </div>


        </g:form>

    </div>


    <!-- Rules Table -->
    <div class="rules-card">

        <div class="rules-table-wrap">

            <table class="table align-middle">


                <thead>

                <tr>

                    <th>
                        Rule
                    </th>

                    <th>
                        Period
                    </th>

                    <th>
                        Target
                    </th>

                    <th>
                        Adjustment
                    </th>

                    <th>
                        Priority
                    </th>

                    <th>
                        Status
                    </th>

                    <th class="text-end">
                        Actions
                    </th>

                </tr>

                </thead>


                <tbody>


                <g:each
                        in="${pricingRuleList}"
                        var="rule">


                    <tr>


                        <!-- Rule Name -->
                        <td>

                            <div class="rule-name">
                                ${rule.name}
                            </div>

                            <div class="text-muted small">
                                ID #${rule.id}
                            </div>

                        </td>


                        <!-- Dates -->
                        <td class="mono-value">

                            <g:formatDate
                                    date="${rule.startDate}"
                                    format="dd MMM yyyy"/>

                            <div class="text-muted">
                                to
                            </div>

                            <g:formatDate
                                    date="${rule.endDate}"
                                    format="dd MMM yyyy"/>

                        </td>


                        <!-- Target -->
                        <td>

                            <span class="rule-badge scope-badge">
                                ${rule.scope}
                            </span>


                            <div class="small mt-2">


                                <g:if test="${rule.scope == 'CATEGORY'}">

                                    ${rule.category?.name ?: 'Missing category'}

                                </g:if>


                                <g:elseif test="${rule.scope == 'CAR'}">

                                    ${rule.car?.brand}
                                    ${rule.car?.model}

                                    <div class="text-muted mono-value">
                                        ${rule.car?.plateNumber}
                                    </div>

                                </g:elseif>


                                <g:else>

                                    Entire fleet

                                </g:else>


                            </div>

                        </td>


                        <!-- Increase / Discount -->
                        <td>

                            <span class="rule-badge
                                    ${rule.adjustmentType == 'DISCOUNT' ?
                                            'rule-discount' :
                                            'rule-increase'}">

                                ${rule.adjustmentType == 'DISCOUNT' ?
                                        '-' :
                                        '+'}${rule.percentage}%

                            </span>

                        </td>


                        <!-- Priority -->
                        <td class="mono-value">
                            ${rule.priority}
                        </td>


                        <!-- Active Status -->
                        <td>

                            <span class="rule-badge
                                    ${rule.active ?
                                            'rule-active' :
                                            'rule-inactive'}">

                                ${rule.active ?
                                        'ACTIVE' :
                                        'INACTIVE'}

                            </span>

                        </td>


                        <!-- Actions -->
                        <td class="text-end text-nowrap">


                            <g:link
                                    action="edit"
                                    id="${rule.id}"
                                    class="btn btn-sm btn-outline-dark me-1">

                                Edit

                            </g:link>


                            <g:form
                                    action="toggleActive"
                                    id="${rule.id}"
                                    method="POST"
                                    class="d-inline">

                                <button
                                        type="submit"
                                        class="btn btn-sm
                                                ${rule.active ?
                                                        'btn-outline-secondary' :
                                                        'btn-dark'}">

                                    ${rule.active ?
                                            'Deactivate' :
                                            'Activate'}

                                </button>

                            </g:form>


                        </td>


                    </tr>


                </g:each>


                <!-- Empty State -->
                <g:if test="${!pricingRuleList}">

                    <tr>

                        <td colspan="7">

                            <div class="empty-state">

                                <i class="bi bi-tags fs-2 d-block mb-2"></i>

                                No pricing rules match the selected filters.

                            </div>

                        </td>

                    </tr>

                </g:if>


                </tbody>

            </table>

        </div>


        <!-- Pagination -->
        <g:if test="${pricingRuleCount > 10}">

            <div class="p-3 border-top">

                <g:paginate
                        total="${pricingRuleCount}"
                        max="${10}"
                        params="${[
                                scope: selectedScope,
                                state: selectedState
                        ]}"/>

            </div>

        </g:if>


    </div>


</div>

</body>

</html>