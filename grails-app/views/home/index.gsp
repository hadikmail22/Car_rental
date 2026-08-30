<!doctype html>
<html lang="en">

<head>

    <meta charset="UTF-8"/>

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"/>

    <title>
        Car Rental | Premium Experience
    </title>

    <asset:link
        rel="icon"
        href="favicon.ico"
        type="image/x-ico"/>

    <link
        rel="preconnect"
        href="https://fonts.googleapis.com">

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&family=Space+Grotesk:wght@500;600;700&display=swap"
        rel="stylesheet">

    <asset:stylesheet src="application.css"/>


    <style>

        :root {

            --luxury-black: #0b0c0f;
            --luxury-black-soft: #121419;

            --luxury-panel: #17191f;

            --luxury-gold: #f5a623;
            --luxury-gold-light: #ffd37a;

            --luxury-white: #f7f7f5;
            --luxury-muted: #a1a1aa;

            --luxury-border:
                rgba(255, 255, 255, 0.10);
        }


        * {
            box-sizing: border-box;
        }


        html {
            scroll-behavior: smooth;
        }


        body {

            margin: 0;

            min-height: 100vh;

            color:
                var(--luxury-white);

            background:
                var(--luxury-black);

            font-family:
                'Inter',
                sans-serif;
        }


        /* ========================================
           NAVBAR
           ======================================== */

        .landing-navbar {

            position: absolute;

            top: 0;
            left: 0;
            right: 0;

            z-index: 100;

            padding:
                22px 0;

            background:
                linear-gradient(
                    to bottom,
                    rgba(11, 12, 15, 0.95),
                    rgba(11, 12, 15, 0.35),
                    transparent
                );
        }


        .landing-navbar-content {

            display: flex;

            align-items: center;

            justify-content:
                space-between;
        }


        .landing-brand {

            display: flex;

            align-items: center;

            gap: 12px;

            color:
                var(--luxury-white);

            text-decoration: none;
        }


        .brand-mark {

            width: 48px;
            height: 48px;

            display: flex;

            align-items: center;

            justify-content: center;

            border:
                1px solid
                rgba(245, 166, 35, 0.55);

            border-radius: 13px;

            color:
                var(--luxury-gold);

            background:
                rgba(245, 166, 35, 0.08);

            font-size: 23px;

            box-shadow:
                0 0 30px
                rgba(245, 166, 35, 0.08);
        }


        .brand-name {

            font-family:
                'Space Grotesk',
                sans-serif;

            font-weight: 700;

            font-size: 1.15rem;

            letter-spacing:
                -0.02em;
        }


        .brand-caption {

            display: block;

            margin-top: 2px;

            color:
                var(--luxury-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: 0.56rem;

            letter-spacing:
                0.20em;

            text-transform:
                uppercase;
        }


        .nav-login {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-height: 43px;

            padding:
                0 20px;

            border:
                1px solid
                rgba(245, 166, 35, 0.65);

            border-radius: 9px;

            color:
                var(--luxury-gold-light);

            background:
                rgba(245, 166, 35, 0.04);

            font-weight: 600;

            text-decoration: none;

            transition:
                all 0.2s ease;
        }


        .nav-login:hover {

            color:
                var(--luxury-black);

            background:
                var(--luxury-gold);

            border-color:
                var(--luxury-gold);
        }


        /* ========================================
           HERO
           ======================================== */

        .hero {

            position: relative;

            min-height: 760px;

            display: flex;

            align-items: center;

            overflow: hidden;

            padding-top: 100px;

            background:

                radial-gradient(
                    circle at 72% 48%,
                    rgba(245, 166, 35, 0.14),
                    transparent 25%
                ),

                radial-gradient(
                    circle at 75% 70%,
                    rgba(255, 255, 255, 0.05),
                    transparent 28%
                ),

                linear-gradient(
                    115deg,
                    #0b0c0f 0%,
                    #111318 55%,
                    #090a0c 100%
                );
        }


        .hero::before {

            content: "";

            position: absolute;

            inset: 0;

            opacity: 0.18;

            background-image:

                linear-gradient(
                    rgba(255,255,255,.025) 1px,
                    transparent 1px
                ),

                linear-gradient(
                    90deg,
                    rgba(255,255,255,.025) 1px,
                    transparent 1px
                );

            background-size:
                55px 55px;

            mask-image:
                linear-gradient(
                    to bottom,
                    transparent,
                    black,
                    transparent
                );
        }


        .hero-content {

            position: relative;

            z-index: 5;
        }


        .hero-row {

            display: grid;

            grid-template-columns:
                minmax(0, 1.05fr)
                minmax(380px, .95fr);

            gap: 70px;

            align-items: center;
        }


        .hero-eyebrow {

            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 20px;

            color:
                var(--luxury-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: 0.74rem;

            font-weight: 600;

            letter-spacing:
                0.18em;

            text-transform:
                uppercase;
        }


        .hero-eyebrow::after {

            content: "";

            width: 55px;

            height: 1px;

            background:
                var(--luxury-gold);
        }


        .hero h1 {

            max-width: 720px;

            margin:
                0 0 24px;

            color:
                var(--luxury-white);

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size:
                clamp(3.4rem, 6vw, 6rem);

            line-height:
                0.97;

            font-weight: 700;

            letter-spacing:
                -0.055em;
        }


        .hero h1 span {

            color:
                var(--luxury-gold);
        }


        .hero-description {

            max-width: 610px;

            margin-bottom: 34px;

            color:
                #b9bbc2;

            font-size: 1.08rem;

            line-height: 1.8;
        }


        /* ========================================
           BUTTONS
           ======================================== */

        .hero-actions {

            display: flex;

            gap: 13px;

            flex-wrap: wrap;
        }


        .luxury-button {

            min-height: 52px;

            display: inline-flex;

            align-items: center;

            justify-content: center;

            gap: 9px;

            padding:
                0 24px;

            border-radius: 9px;

            font-weight: 700;

            text-decoration: none;

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease,
                background 0.2s ease;
        }


        .luxury-button:hover {

            transform:
                translateY(-2px);
        }


        .luxury-button-primary {

            color:
                #17120a;

            background:
                linear-gradient(
                    135deg,
                    #f8bd57,
                    #f5a623
                );

            box-shadow:
                0 10px 30px
                rgba(245, 166, 35, 0.18);
        }


        .luxury-button-primary:hover {

            color:
                #17120a;

            box-shadow:
                0 15px 40px
                rgba(245, 166, 35, 0.28);
        }


        .luxury-button-outline {

            color:
                #e7e7e7;

            border:
                1px solid
                rgba(255,255,255,0.17);

            background:
                rgba(255,255,255,0.025);
        }


        .luxury-button-outline:hover {

            color:
                var(--luxury-gold);

            border-color:
                rgba(245,166,35,0.6);
        }


        /* ========================================
           VISUAL
           ======================================== */

        .hero-visual {

            position: relative;

            min-height: 450px;

            display: flex;

            align-items: center;

            justify-content: center;
        }


        .visual-glow {

            position: absolute;

            width: 420px;
            height: 420px;

            border-radius: 50%;

            background:
                radial-gradient(
                    circle,
                    rgba(245,166,35,.17),
                    rgba(245,166,35,.03) 45%,
                    transparent 70%
                );
        }


        .car-outline {

            position: relative;

            width: 460px;

            padding:
                45px 35px;

            border:
                1px solid
                var(--luxury-border);

            border-radius: 28px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.065),
                    rgba(255,255,255,.015)
                );

            box-shadow:
                0 35px 100px
                rgba(0,0,0,.45);

            backdrop-filter:
                blur(15px);
        }


        .car-icon {

            text-align: center;

            color:
                var(--luxury-gold);

            font-size: 140px;

            line-height: 1;

            text-shadow:
                0 0 60px
                rgba(245,166,35,.18);
        }


        .car-line {

            width: 80%;

            height: 1px;

            margin:
                28px auto;

            background:
                linear-gradient(
                    to right,
                    transparent,
                    var(--luxury-gold),
                    transparent
                );
        }


        .visual-label {

            text-align: center;

            font-family:
                'JetBrains Mono',
                monospace;

            color:
                #9d9fa5;

            font-size: .72rem;

            letter-spacing:
                .18em;

            text-transform:
                uppercase;
        }


        /* ========================================
           STATS
           ======================================== */

        .landing-stats {

            position: relative;

            z-index: 10;

            margin-top:
                -55px;
        }


        .stats-panel {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            background:
                rgba(19, 21, 26, .96);

            border:
                1px solid
                var(--luxury-border);

            border-radius:
                17px;

            box-shadow:
                0 25px 70px
                rgba(0,0,0,.35);

            overflow: hidden;
        }


        .stat-item {

            padding:
                28px 32px;

            position: relative;
        }


        .stat-item:not(:last-child)::after {

            content: "";

            position: absolute;

            top: 25%;
            bottom: 25%;
            right: 0;

            width: 1px;

            background:
                var(--luxury-border);
        }


        .stat-value {

            display: block;

            color:
                var(--luxury-white);

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 2rem;

            font-weight: 700;
        }


        .stat-value.gold {

            color:
                var(--luxury-gold);
        }


        .stat-label {

            display: block;

            margin-top: 4px;

            color:
                var(--luxury-muted);

            font-size: .82rem;
        }


        /* ========================================
           FEATURES
           ======================================== */

        .features {

            padding:
                120px 0 100px;

            background:
                #0e0f12;
        }


        .section-eyebrow {

            color:
                var(--luxury-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: .7rem;

            letter-spacing:
                .18em;

            text-transform:
                uppercase;
        }


        .section-title {

            margin:
                10px 0 42px;

            color:
                var(--luxury-white);

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 2.4rem;

            font-weight: 700;
        }


        .features-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }


        .feature-card {

            padding:
                30px;

            border:
                1px solid
                var(--luxury-border);

            border-radius: 14px;

            background:
                linear-gradient(
                    145deg,
                    #17191e,
                    #121419
                );

            transition:
                border-color .2s ease,
                transform .2s ease;
        }


        .feature-card:hover {

            transform:
                translateY(-3px);

            border-color:
                rgba(245,166,35,.38);
        }


        .feature-number {

            color:
                var(--luxury-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: .72rem;

            letter-spacing: .1em;
        }


        .feature-card h3 {

            margin:
                25px 0 12px;

            color:
                #fff;

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 1.15rem;
        }


        .feature-card p {

            margin: 0;

            color:
                #93959c;

            line-height: 1.7;

            font-size: .9rem;
        }


        /* ========================================
           FOOTER
           ======================================== */

        .landing-footer {

            padding:
                30px 0;

            background:
                #090a0c;

            border-top:
                1px solid
                var(--luxury-border);

            color:
                #777981;

            font-size: .78rem;
        }


        .footer-row {

            display: flex;

            justify-content:
                space-between;

            align-items: center;
        }


        /* ========================================
           MOBILE
           ======================================== */

        @media (max-width: 991px) {

            .hero {

                min-height:
                    auto;

                padding:
                    150px 0 120px;
            }


            .hero-row {

                grid-template-columns:
                    1fr;

                gap: 60px;
            }


            .hero-visual {

                min-height:
                    350px;
            }


            .car-outline {

                width:
                    min(460px, 100%);
            }


            .stats-panel,
            .features-grid {

                grid-template-columns:
                    1fr;
            }


            .stat-item:not(:last-child)::after {

                top: auto;
                left: 10%;
                right: 10%;
                bottom: 0;

                width: auto;
                height: 1px;
            }
        }


        @media (max-width: 600px) {

            .hero h1 {

                font-size:
                    3.2rem;
            }


            .landing-navbar {

                padding:
                    16px 0;
            }


            .brand-caption {

                display: none;
            }


            .car-icon {

                font-size:
                    95px;
            }


            .hero-actions {

                flex-direction:
                    column;
            }


            .luxury-button {

                width: 100%;
            }


            .footer-row {

                flex-direction:
                    column;

                gap: 8px;

                text-align: center;
            }
        }

    </style>

</head>


<body>


<!-- ==========================================
     NAVBAR
     ========================================== -->

<nav class="landing-navbar">

    <div class="container">

        <div class="landing-navbar-content">


            <a
                href="${createLink(uri: '/')}"
                class="landing-brand">

                <div class="brand-mark">

                    <i class="bi bi-car-front-fill"></i>

                </div>


                <div>

                    <div class="brand-name">
                        Car Rental
                    </div>

                    <span class="brand-caption">
                        Premium Mobility
                    </span>

                </div>

            </a>


            <a
                href="${createLink(uri: '/login/auth')}"
                class="nav-login">

                Sign In

            </a>


        </div>

    </div>

</nav>



<!-- ==========================================
     HERO
     ========================================== -->

<section class="hero">

    <div class="container hero-content">

        <div class="hero-row">


            <!-- LEFT -->
            <div>

                <div class="hero-eyebrow">
                    Premium Car Rental
                </div>


                <h1>

                    Drive better.
                    <br/>

                    Rent with
                    <span>confidence.</span>

                </h1>


                <p class="hero-description">

                    Find the right car for every journey.
                    Simple booking, transparent pricing,
                    and a fleet ready when you are.

                </p>


                <div class="hero-actions">


                    <g:link
                        controller="car"
                        action="index"
                        class="luxury-button luxury-button-primary">

                        <i class="bi bi-car-front"></i>

                        Explore Cars

                    </g:link>


                    <a
                        href="${createLink(uri: '/login/auth')}"
                        class="luxury-button luxury-button-outline">

                        <i class="bi bi-person"></i>

                        Sign In

                    </a>


                </div>

            </div>



            <!-- RIGHT -->
            <div class="hero-visual">

                <div class="visual-glow"></div>


                <div class="car-outline">

                    <div class="car-icon">

                        <i class="bi bi-car-front-fill"></i>

                    </div>


                    <div class="car-line"></div>


                    <div class="visual-label">

                        Your journey starts here

                    </div>

                </div>

            </div>


        </div>

    </div>

</section>



<!-- ==========================================
     LIVE STATS
     ========================================== -->

<section class="landing-stats">

    <div class="container">

        <div class="stats-panel">


            <div class="stat-item">

                <span class="stat-value">
                    ${totalCars ?: 0}
                </span>

                <span class="stat-label">
                    Vehicles in our fleet
                </span>

            </div>


            <div class="stat-item">

                <span class="stat-value gold">
                    ${availableCars ?: 0}
                </span>

                <span class="stat-label">
                    Available right now
                </span>

            </div>


            <div class="stat-item">

                <span class="stat-value">
                    24/7
                </span>

                <span class="stat-label">
                    Simple online access
                </span>

            </div>


        </div>

    </div>

</section>



<!-- ==========================================
     FEATURES
     ========================================== -->

<section class="features">

    <div class="container">


        <div class="section-eyebrow">
            Why Car Rental
        </div>


        <h2 class="section-title">
            Built for a smoother rental experience.
        </h2>


        <div class="features-grid">


            <div class="feature-card">

                <span class="feature-number">
                    01
                </span>

                <h3>
                    Browse the fleet
                </h3>

                <p>

                    Explore available vehicles,
                    pricing, specifications,
                    and availability in one place.

                </p>

            </div>


            <div class="feature-card">

                <span class="feature-number">
                    02
                </span>

                <h3>
                    Select your dates
                </h3>

                <p>

                    Existing booking dates are
                    clearly displayed before you
                    submit your rental.

                </p>

            </div>


            <div class="feature-card">

                <span class="feature-number">
                    03
                </span>

                <h3>
                    Manage your rentals
                </h3>

                <p>

                    Track booking status and
                    deposits from your own
                    customer account.

                </p>

            </div>


        </div>

    </div>

</section>



<!-- ==========================================
     FOOTER
     ========================================== -->

<footer class="landing-footer">

    <div class="container">

        <div class="footer-row">

            <span>
                Car Rental Management System
            </span>

            <span>
                © 2026 Car Rental
            </span>

        </div>

    </div>

</footer>


<asset:javascript src="application.js"/>

</body>

</html>