<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Dashboard</title>

    <style>
        :root{
            --asphalt-900:#101114;
            --asphalt-800:#17181c;
            --headlight:#f5a623;
            --headlight-dim:#c9860f;
            --taillight:#e5484d;
            --go-green:#1f8a52;
            --blue-signal:#2560c4;
            --paper:#f6f5f2;
            --ink:#101114;
            --ink-soft:#5b5d63;
            --hairline:#e4e2dc;
        }

        .dashboard-page{
            font-family:'Inter', -apple-system, sans-serif;
            color:var(--ink);
        }

        .dashboard-page h2{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            letter-spacing:-0.01em;
            color:var(--asphalt-900);
        }

        .dashboard-page .text-muted{
            color:var(--ink-soft) !important;
        }

        /* ---------- Stat cards: signature dashboard-gauge look ---------- */
        .stat-card{
            border:1px solid var(--hairline) !important;
            border-radius:14px;
            position:relative;
            overflow:hidden;
            transition:box-shadow .15s ease, transform .15s ease;
        }

        .stat-card:hover{
            box-shadow:0 10px 28px rgba(16,17,20,0.08);
            transform:translateY(-2px);
        }

        /* colored top edge acts like a gauge needle marker */
        .stat-card::before{
            content:"";
            position:absolute;
            top:0; left:0; right:0;
            height:4px;
        }

        .stat-card.total::before{ background:var(--asphalt-900); }
        .stat-card.available::before{ background:var(--go-green); }
        .stat-card.rented::before{ background:var(--blue-signal); }
        .stat-card.maintenance::before{ background:var(--headlight); }

        .stat-card h6{
            font-family:'JetBrains Mono', monospace;
            font-size:0.72rem;
            font-weight:600;
            letter-spacing:0.08em;
            text-transform:uppercase;
            color:var(--ink-soft) !important;
        }

        .stat-card h2{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            margin-top:0.25rem;
        }

        .stat-card.total h2{ color:var(--asphalt-900); }
        .stat-card.available h2{ color:var(--go-green) !important; }
        .stat-card.rented h2{ color:var(--blue-signal) !important; }
        .stat-card.maintenance h2{ color:var(--headlight-dim) !important; }

        /* status badges — same dashboard-light style used across the app */
        .status-badge{
            font-family:'JetBrains Mono', monospace;
            font-weight:600;
            font-size:0.7rem;
            letter-spacing:0.06em;
            padding:0.35rem 0.65rem;
            border-radius:999px;
            display:inline-flex;
            align-items:center;
            gap:0.4rem;
        }

        .status-badge::before{
            content:"";
            width:6px;
            height:6px;
            border-radius:50%;
            display:inline-block;
        }

        .status-badge.available{ background:#e8f6ee; color:var(--go-green); }
        .status-badge.available::before{ background:var(--go-green); box-shadow:0 0 6px var(--go-green); }

        .status-badge.rented{ background:#eaf1fb; color:var(--blue-signal); }
        .status-badge.rented::before{ background:var(--blue-signal); box-shadow:0 0 6px var(--blue-signal); }

        .status-badge.maintenance{ background:#fff3e0; color:var(--headlight-dim); }
        .status-badge.maintenance::before{ background:var(--headlight); box-shadow:0 0 6px var(--headlight); }

        .btn-outline-primary{
            border-radius:8px;
            border-color:var(--asphalt-900);
            color:var(--asphalt-900);
            font-weight:600;
        }
        .btn-outline-primary:hover,
        .btn-outline-primary:focus-visible{
            background:var(--asphalt-900);
            border-color:var(--asphalt-900);
        }

        /* ---------- Quick actions ---------- */
        .quick-actions-card{
            border:1px solid var(--hairline) !important;
            border-radius:14px;
            background:var(--paper);
        }

        .quick-actions-card h4{
            font-family:'Space Grotesk', sans-serif;
            font-weight:700;
            color:var(--asphalt-900);
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

        .btn-outline-secondary{
            border-radius:8px;
            border-color:var(--hairline);
            color:var(--ink-soft);
        }
        .btn-outline-secondary:hover,
        .btn-outline-secondary:focus-visible{
            background:var(--asphalt-900);
            border-color:var(--asphalt-900);
        }
    </style>
</head>

<body>

<div class="container mt-4 dashboard-page">

    <div class="mb-4">
        <h2>Dashboard</h2>
        <p class="text-muted">
            Car Rental Management Overview
        </p>
    </div>


    <div class="row g-4">

        <!-- Total Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm h-100 stat-card total">

                <div class="card-body">

                    <h6 class="text-muted">
                        Total Cars
                    </h6>

                    <h2 class="fw-bold">
                        ${totalCars ?: 0}
                    </h2>

                    <g:link
                        controller="car"
                        action="index"
                        class="btn btn-outline-primary btn-sm mt-2">

                        View Cars

                    </g:link>

                </div>

            </div>

        </div>


        <!-- Available Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm h-100 stat-card available">

                <div class="card-body">

                    <h6 class="text-muted">
                        Available Cars
                    </h6>

                    <h2 class="fw-bold text-success">
                        ${availableCars ?: 0}
                    </h2>

                    <span class="status-badge available">
                        AVAILABLE
                    </span>

                </div>

            </div>

        </div>


        <!-- Rented Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm h-100 stat-card rented">

                <div class="card-body">

                    <h6 class="text-muted">
                        Rented Cars
                    </h6>

                    <h2 class="fw-bold text-primary">
                        ${rentedCars ?: 0}
                    </h2>

                    <span class="status-badge rented">
                        RENTED
                    </span>

                </div>

            </div>

        </div>


        <!-- Maintenance Cars -->
        <div class="col-md-6 col-lg-3">

            <div class="card shadow-sm h-100 stat-card maintenance">

                <div class="card-body">

                    <h6 class="text-muted">
                        Maintenance
                    </h6>

                    <h2 class="fw-bold text-warning">
                        ${maintenanceCars ?: 0}
                    </h2>

                    <span class="status-badge maintenance">
                        MAINTENANCE
                    </span>

                </div>

            </div>

        </div>

    </div>


    <!-- Quick Actions -->
    <div class="card shadow-sm mt-5 quick-actions-card">

        <div class="card-body">

            <h4 class="mb-3">
                Quick Actions
            </h4>

            <g:link
                controller="car"
                action="create"
                class="btn btn-primary me-2">

                Add New Car

            </g:link>

            <g:link
                controller="car"
                action="index"
                class="btn btn-outline-secondary">

                Manage Cars

            </g:link>

        </div>

    </div>

</div>

</body>
</html>
