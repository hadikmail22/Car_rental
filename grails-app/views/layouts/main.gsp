<!doctype html>
<html lang="en" class="no-js">

<head>

    <meta charset="UTF-8"/>

    <meta
        http-equiv="X-UA-Compatible"
        content="IE=edge"/>

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"/>

    <title>
        <g:layoutTitle default="Car Rental"/>
    </title>


    <asset:link
        rel="icon"
        href="favicon.ico"
        type="image/x-ico"/>


    <link
        rel="preconnect"
        href="https://fonts.googleapis.com"/>

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin/>

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&family=Space+Grotesk:wght@500;600;700&display=swap"
        rel="stylesheet"/>


    <asset:stylesheet src="application.css"/>


    <style>

        :root {

            --shell-black: #0b0c0f;
            --shell-black-soft: #111318;
            --shell-black-light: #191b20;

            --shell-gold: #f5a623;
            --shell-gold-light: #ffc861;
            --shell-gold-dark: #c9860f;

            --shell-white: #f8f8f6;

            --shell-muted: #96989f;

            --shell-border:
                rgba(255,255,255,0.08);
        }


        html {
            min-height: 100%;
            scrollbar-gutter: stable;
        }


        body.application-shell {

            min-height: 100vh;

            display: flex;
            flex-direction: column;

            margin: 0;

            font-family:
                'Inter',
                sans-serif;
        }



        .top-shell {

            position: sticky;

            top: 0;

            z-index: 1040;

            padding:
                14px 18px 0;

            pointer-events: none;
        }



        .premium-navbar {

            position: relative;

            pointer-events: auto;

            padding:
                0 !important;

            overflow: visible;

            background:
                linear-gradient(
                    135deg,
                    #0a0b0e 0%,
                    #111318 55%,
                    #17191e 100%
                ) !important;

            border:
                1px solid
                rgba(245,166,35,.14) !important;

            border-radius:
                21px;

            box-shadow:
                0 20px 50px
                rgba(0,0,0,.25),
                inset 0 1px 0
                rgba(255,255,255,.025);

            backdrop-filter:
                blur(20px);

            -webkit-backdrop-filter:
                blur(20px);
        }


        .premium-navbar::before {

            content: "";

            position: absolute;

            inset: 0;

            border-radius: inherit;

            pointer-events: none;

            background:
                radial-gradient(
                    circle at 12% -80%,
                    rgba(245,166,35,.16),
                    transparent 42%
                );
        }


        .premium-navbar::after {

            content: "";

            position: absolute;

            left: 28px;
            right: 28px;
            bottom: 0;

            height: 2px;

            border-radius:
                999px;

            pointer-events: none;

            background:
                linear-gradient(
                    90deg,
                    transparent,
                    var(--shell-gold) 12%,
                    var(--shell-gold-light) 50%,
                    var(--shell-gold) 88%,
                    transparent
                );

            opacity: .9;
        }


        .premium-navbar-inner {

            position: relative;

            z-index: 2;

            min-height: 88px;

            display: flex;

            align-items: center;

            width: 100%;
        }



        .premium-brand {

            display: inline-flex;

            align-items: center;

            gap: 14px;

            flex-shrink: 0;

            margin-right: 30px;

            color:
                #ffffff !important;

            text-decoration:
                none !important;
        }


        .premium-brand-mark {

            width: 58px;
            height: 58px;

            display: flex;

            align-items: center;
            justify-content: center;

            flex: 0 0 auto;

            color:
                var(--shell-gold);

            background:
                linear-gradient(
                    145deg,
                    rgba(245,166,35,.17),
                    rgba(245,166,35,.045)
                );

            border:
                1px solid
                rgba(245,166,35,.32);

            border-radius:
                17px;

            font-size:
                1.35rem;

            box-shadow:
                0 10px 28px
                rgba(0,0,0,.26),
                inset 0 1px 0
                rgba(255,255,255,.04);

            transition:
                transform .18s ease,
                border-color .18s ease;
        }


        .premium-brand:hover
        .premium-brand-mark {

            transform:
                translateY(-2px);

            border-color:
                rgba(245,166,35,.65);
        }


        .premium-brand-copy {

            display: flex;

            flex-direction: column;
        }


        .premium-brand-title {

            color:
                #f8f8f6;

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size:
                1.24rem;

            font-weight:
                700;

            line-height:
                1;

            letter-spacing:
                -.03em;
        }


        .premium-brand-subtitle {

            margin-top:
                7px;

            color:
                var(--shell-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size:
                .58rem;

            font-weight:
                600;

            letter-spacing:
                .19em;

            text-transform:
                uppercase;
        }



        .premium-nav-list {

            display: flex;

            align-items: center;

            gap: 5px;
        }


        .premium-navbar .premium-nav-link {

            position: relative;

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                11px 15px !important;

            color:
                #a7a9b0 !important;

            border:
                1px solid transparent;

            border-radius:
                11px;

            font-size:
                .91rem;

            font-weight:
                600;

            text-decoration:
                none;

            transition:
                color .17s ease,
                background .17s ease,
                border-color .17s ease;
        }


        .premium-nav-link i {

            color:
                #767981;

            font-size:
                .98rem;

            transition:
                color .17s ease;
        }


        .premium-message-count {

            position:
                absolute;

            top:
                -7px;

            right:
                -7px;

            z-index:
                3;

            min-width:
                21px;

            height:
                21px;

            display:
                inline-flex;

            align-items:
                center;

            justify-content:
                center;

            padding:
                0 5px;

            color:
                #ffffff;

            background:
                #c0392b;

            border:
                2px solid
                #111318;

            border-radius:
                999px;

            box-shadow:
                0 4px 12px
                rgba(192,57,43,.45);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size:
                .55rem;

            font-weight:
                800;

            line-height:
                1;
        }


        .premium-navbar
        .premium-nav-link:hover {

            color:
                #ffffff !important;

            background:
                rgba(255,255,255,.045);

            border-color:
                rgba(255,255,255,.04);
        }


        .premium-nav-link:hover i {

            color:
                var(--shell-gold);
        }



        .premium-navbar
        .premium-nav-link.active {

            color:
                #ffffff !important;

            background:
                linear-gradient(
                    135deg,
                    rgba(245,166,35,.14),
                    rgba(245,166,35,.055)
                );

            border-color:
                rgba(245,166,35,.20);

            box-shadow:
                inset 0 1px 0
                rgba(255,255,255,.025);
        }


        .premium-nav-link.active i {

            color:
                var(--shell-gold);
        }


        .premium-nav-link.active::after {

            content: "";

            position: absolute;

            left: 16px;
            right: 16px;
            bottom: 4px;

            height: 2px;

            border-radius:
                999px;

            background:
                var(--shell-gold);

            box-shadow:
                0 0 10px
                rgba(245,166,35,.45);
        }



        .premium-user-area {

            display: flex;

            align-items: center;

            gap: 12px;

            padding-left:
                19px;

            margin-left:
                18px;

            border-left:
                1px solid
                rgba(255,255,255,.09);
        }


        .premium-user-card {

            min-width:
                225px;

            display: flex;

            align-items: center;

            gap: 12px;

            padding:
                8px 12px;

            border:
                1px solid
                rgba(255,255,255,.07);

            border-radius:
                14px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.018)
                );
        }


        .premium-user-avatar {

            width: 45px;
            height: 45px;

            display: flex;

            align-items: center;
            justify-content: center;

            flex: 0 0 auto;

            color:
                var(--shell-gold);

            background:
                linear-gradient(
                    145deg,
                    rgba(245,166,35,.16),
                    rgba(245,166,35,.07)
                );

            border:
                1px solid
                rgba(245,166,35,.26);

            border-radius:
                50%;

            font-size:
                1.05rem;
        }


        .premium-user-meta {

            min-width: 0;

            display: flex;

            flex-direction: column;
        }


        .premium-user-name {

            max-width:
                165px;

            overflow:
                hidden;

            color:
                #f1f1ef;

            font-size:
                .83rem;

            font-weight:
                650;

            white-space:
                nowrap;

            text-overflow:
                ellipsis;
        }



        .premium-role {

            width:
                fit-content;

            display:
                inline-flex;

            align-items:
                center;

            gap: 5px;

            margin-top:
                5px;

            padding:
                3px 8px;

            border-radius:
                999px;

            font-family:
                'JetBrains Mono',
                monospace;

            font-size:
                .54rem;

            font-weight:
                600;

            letter-spacing:
                .08em;

            text-transform:
                uppercase;
        }


        .premium-role.admin {

            color:
                var(--shell-gold);

            background:
                rgba(245,166,35,.10);
        }


        .premium-role.customer {

            color:
                #65d797;

            background:
                rgba(31,138,82,.13);
        }


        .premium-role::before {

            content: "";

            width: 5px;
            height: 5px;

            border-radius:
                50%;

            background:
                currentColor;

            box-shadow:
                0 0 6px
                currentColor;
        }



        .premium-logout {

            min-height:
                44px;

            display:
                inline-flex;

            align-items:
                center;

            justify-content:
                center;

            gap: 7px;

            padding:
                0 14px;

            color:
                #ef7074;

            background:
                rgba(229,72,77,.035);

            border:
                1px solid
                rgba(229,72,77,.28);

            border-radius:
                10px;

            font-size:
                .76rem;

            font-weight:
                650;

            cursor:
                pointer;

            transition:
                all .17s ease;
        }


        .premium-logout:hover {

            color:
                #ffffff;

            background:
                #b9362b;

            border-color:
                #b9362b;

            box-shadow:
                0 9px 22px
                rgba(185,54,43,.18);
        }



        .premium-signin {

            min-height:
                43px;

            display:
                inline-flex;

            align-items:
                center;

            justify-content:
                center;

            gap: 7px;

            padding:
                0 17px;

            color:
                var(--shell-gold);

            background:
                rgba(245,166,35,.04);

            border:
                1px solid
                rgba(245,166,35,.36);

            border-radius:
                10px;

            font-size:
                .8rem;

            font-weight:
                650;

            text-decoration:
                none;

            transition:
                all .17s ease;
        }


        .premium-signin:hover {

            color:
                #151009;

            background:
                var(--shell-gold);

            border-color:
                var(--shell-gold);
        }



        .premium-toggler {

            padding:
                8px 10px !important;

            background:
                rgba(255,255,255,.035) !important;

            border:
                1px solid
                rgba(255,255,255,.13) !important;

            border-radius:
                11px !important;

            box-shadow:
                none !important;
        }


        .premium-toggler
        .navbar-toggler-icon {

            width:
                1.25em;

            height:
                1.25em;

            filter:
                invert(1);
        }



        .application-content {

            flex:
                1 0 auto;

            width:
                100%;

            min-height:
                calc(100vh - 290px);

            padding-top:
                8px;

            padding-bottom:
                55px;
        }



        .premium-footer {

            position:
                relative;

            flex-shrink:
                0;

            overflow:
                hidden;

            margin:
                20px 18px 18px;

            color:
                #888b92;

            background:
                linear-gradient(
                    135deg,
                    #0c0d10,
                    #14161a
                );

            border:
                1px solid
                rgba(245,166,35,.10);

            border-radius:
                20px;

            box-shadow:
                0 18px 45px
                rgba(0,0,0,.13);
        }


        .premium-footer::before {

            content: "";

            position:
                absolute;

            width:
                350px;

            height:
                250px;

            right:
                -100px;

            bottom:
                -170px;

            border-radius:
                50%;

            background:
                radial-gradient(
                    circle,
                    rgba(245,166,35,.10),
                    transparent 68%
                );
        }


        .premium-footer::after {

            content: "";

            position:
                absolute;

            top:
                0;

            left:
                28px;

            right:
                28px;

            height:
                2px;

            background:
                linear-gradient(
                    90deg,
                    transparent,
                    var(--shell-gold),
                    var(--shell-gold-light),
                    var(--shell-gold),
                    transparent
                );
        }


        .premium-footer-content {

            position:
                relative;

            z-index:
                2;

            padding:
                30px 0 20px;
        }



        .premium-footer-top {

            display:
                flex;

            align-items:
                center;

            justify-content:
                space-between;

            gap:
                30px;
        }


        .premium-footer-brand {

            display:
                flex;

            align-items:
                center;

            gap:
                12px;
        }


        .premium-footer-logo {

            width:
                43px;

            height:
                43px;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            color:
                var(--shell-gold);

            background:
                rgba(245,166,35,.055);

            border:
                1px solid
                rgba(245,166,35,.27);

            border-radius:
                12px;
        }


        .premium-footer-name {

            color:
                #efefed;

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size:
                .95rem;

            font-weight:
                700;
        }


        .premium-footer-caption {

            margin-top:
                3px;

            color:
                #6d7077;

            font-family:
                'JetBrains Mono',
                monospace;

            font-size:
                .56rem;

            letter-spacing:
                .1em;

            text-transform:
                uppercase;
        }



        .premium-footer-links {

            display:
                flex;

            align-items:
                center;

            gap:
                5px;

            flex-wrap:
                wrap;
        }


        .premium-footer-links a {

            padding:
                7px 10px;

            color:
                #8e9198;

            border-radius:
                7px;

            font-size:
                .76rem;

            font-weight:
                500;

            text-decoration:
                none;

            transition:
                color .15s ease,
                background .15s ease;
        }


        .premium-footer-links a:hover {

            color:
                var(--shell-gold);

            background:
                rgba(245,166,35,.055);
        }



        .premium-footer-divider {

            height:
                1px;

            margin:
                24px 0 16px;

            background:
                rgba(255,255,255,.055);
        }


        .premium-footer-bottom {

            display:
                flex;

            align-items:
                center;

            justify-content:
                space-between;

            gap:
                20px;

            color:
                #60636a;

            font-size:
                .68rem;
        }


        .system-online {

            display:
                inline-flex;

            align-items:
                center;

            gap:
                7px;
        }


        .online-dot {

            width:
                6px;

            height:
                6px;

            border-radius:
                50%;

            background:
                #32b66f;

            box-shadow:
                0 0 8px
                rgba(50,182,111,.8);
        }



        #spinner {

            position:
                fixed;

            right:
                25px;

            bottom:
                25px;

            z-index:
                1090;

            width:
                45px;

            height:
                45px;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            color:
                var(--shell-gold);

            background:
                #111318;

            border:
                1px solid
                rgba(245,166,35,.25);

            border-radius:
                12px;

            box-shadow:
                0 15px 40px
                rgba(0,0,0,.23);
        }



        @media (max-width: 1199px) {

            .premium-user-card {

                min-width:
                    auto;
            }


            .premium-user-name {

                max-width:
                    115px;
            }


            .premium-nav-link {

                padding:
                    10px 11px !important;
            }
        }



        @media (max-width: 991.98px) {

            .top-shell {

                padding:
                    10px 10px 0;
            }


            .premium-navbar {

                border-radius:
                    17px;
            }


            .premium-navbar-inner {

                min-height:
                    72px;
            }


            .premium-brand-mark {

                width:
                    49px;

                height:
                    49px;

                border-radius:
                    14px;
            }


            .premium-brand-title {

                font-size:
                    1.08rem;
            }


            .premium-navbar-collapse {

                margin:
                    10px 0 14px;

                padding:
                    14px;

                background:
                    rgba(255,255,255,.025);

                border:
                    1px solid
                    rgba(255,255,255,.055);

                border-radius:
                    13px;
            }


            .premium-nav-list {

                display:
                    block;

                width:
                    100%;

                margin-bottom:
                    14px;
            }


            .premium-nav-list
            .nav-item {

                width:
                    100%;
            }


            .premium-nav-link {

                width:
                    100%;

                margin-bottom:
                    3px;
            }


            .premium-message-count {

                top:
                    50%;

                right:
                    12px;

                transform:
                    translateY(-50%);
            }


            .premium-user-area {

                width:
                    100%;

                display:
                    grid;

                grid-template-columns:
                    minmax(0, 1fr) auto auto;

                padding:
                    14px 0 0;

                margin:
                    8px 0 0;

                border-top:
                    1px solid
                    rgba(255,255,255,.07);

                border-left:
                    0;
            }


            .premium-user-card {

                width:
                    100%;
            }
        }



        @media (max-width: 576px) {

            .premium-brand-subtitle {

                display:
                    none;
            }


            .premium-user-area {

                grid-template-columns:
                    minmax(0, 1fr) auto;
            }


            .premium-user-area > form {

                grid-column:
                    1 / -1;
            }


            .premium-logout {

                width:
                    100%;
            }


            .premium-footer {

                margin:
                    12px;
            }


            .premium-footer-top,
            .premium-footer-bottom {

                flex-direction:
                    column;

                text-align:
                    center;
            }


            .premium-footer-brand,
            .premium-footer-links {

                justify-content:
                    center;
            }
        }

    </style>


    <g:layoutHead/>

</head>


<body class="application-shell">



<header class="top-shell">

    <nav
        class="navbar navbar-expand-lg premium-navbar"
        data-bs-theme="dark">

        <div class="container">

            <div class="premium-navbar-inner">


                <a
                    href="${createLink(uri: '/')}"
                    class="premium-brand">

                    <span class="premium-brand-mark">

                        <i class="bi bi-car-front-fill"></i>

                    </span>


                    <span class="premium-brand-copy">

                        <span class="premium-brand-title">
                            Car Rental
                        </span>

                        <span class="premium-brand-subtitle">
                            Premium Mobility
                        </span>

                    </span>

                </a>



                <button
                    class="navbar-toggler premium-toggler ms-auto"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#premiumNavbar"
                    aria-controls="premiumNavbar"
                    aria-expanded="false"
                    aria-label="Toggle navigation">

                    <span class="navbar-toggler-icon"></span>

                </button>



                <div
                    class="collapse navbar-collapse premium-navbar-collapse"
                    id="premiumNavbar">


                    <ul class="navbar-nav me-auto premium-nav-list">

                        <sec:ifLoggedIn>



                            <sec:ifAnyGranted roles="ROLE_ADMIN">


                                <li class="nav-item">

                                    <g:link
                                        controller="dashboard"
                                        action="index"
                                        class="nav-link premium-nav-link ${controllerName == 'dashboard' ? 'active' : ''}">

                                        <i class="bi bi-grid"></i>

                                        <span>
                                            Dashboard
                                        </span>

                                    </g:link>

                                </li>



                                <li class="nav-item">

                                    <g:link
                                        controller="car"
                                        action="index"
                                        class="nav-link premium-nav-link ${controllerName == 'car' ? 'active' : ''}">

                                        <i class="bi bi-car-front"></i>

                                        <span>
                                            Fleet
                                        </span>

                                    </g:link>

                                </li>



                                <li class="nav-item">

                                    <g:link
                                        controller="rental"
                                        action="index"
                                        class="nav-link premium-nav-link ${controllerName == 'rental' ? 'active' : ''}">

                                        <i class="bi bi-calendar-check"></i>

                                        <span>
                                            Rentals
                                        </span>

                                    </g:link>

                                </li>


                                <li class="nav-item">

                                    <g:link
                                        controller="pricingRule"
                                        action="index"
                                        class="nav-link premium-nav-link ${controllerName == 'pricingRule' ? 'active' : ''}">

                                        <i class="bi bi-tags"></i>

                                        <span>
                                            Pricing
                                        </span>

                                    </g:link>

                                </li>


                            </sec:ifAnyGranted>



                            <sec:ifAnyGranted roles="ROLE_CUSTOMER">


                                <li class="nav-item">

                                    <g:link
                                        controller="car"
                                        action="index"
                                        class="nav-link premium-nav-link ${controllerName == 'car' ? 'active' : ''}">

                                        <i class="bi bi-car-front"></i>

                                        <span>
                                            Browse Cars
                                        </span>

                                    </g:link>

                                </li>



                                <li class="nav-item">

                                    <g:link
                                        controller="rental"
                                        action="index"
                                        class="nav-link premium-nav-link ${controllerName == 'rental' ? 'active' : ''}">

                                        <i class="bi bi-calendar-check"></i>

                                        <span>
                                            My Rentals
                                        </span>

                                    </g:link>

                                </li>


                            </sec:ifAnyGranted>


                            <li class="nav-item">

                                <g:link
                                    controller="rentalChat"
                                    action="index"
                                    class="nav-link premium-nav-link ${controllerName == 'rentalChat' ? 'active' : ''}">

                                    <i class="bi bi-chat-square-text"></i>

                                    <span>
                                        Messages
                                    </span>

                                    <app:messageBadge/>

                                </g:link>

                            </li>


                        </sec:ifLoggedIn>


                        <g:pageProperty name="page.nav"/>

                    </ul>



                    <sec:ifLoggedIn>

                        <div class="premium-user-area">

                            <div class="premium-user-card">


                                <div class="premium-user-avatar">

                                    <i class="bi bi-person-fill"></i>

                                </div>


                                <div class="premium-user-meta">


                                    <div class="premium-user-name">

                                        <sec:username/>

                                    </div>



                                    <sec:ifAnyGranted roles="ROLE_ADMIN">

                                        <span class="premium-role admin">

                                            Admin

                                        </span>

                                    </sec:ifAnyGranted>



                                    <sec:ifAnyGranted roles="ROLE_CUSTOMER">

                                        <span class="premium-role customer">

                                            Customer

                                        </span>

                                    </sec:ifAnyGranted>


                                </div>


                            </div>



                            <app:notificationMenu/>



                            <form
                                action="${createLink(uri: '/logout')}"
                                method="POST"
                                class="m-0">

                                <button
                                    type="submit"
                                    class="premium-logout">

                                    <i class="bi bi-box-arrow-right"></i>

                                    Logout

                                </button>

                            </form>


                        </div>

                    </sec:ifLoggedIn>



                    <sec:ifNotLoggedIn>

                        <a
                            href="${createLink(uri: '/login/auth')}"
                            class="premium-signin">

                            <i class="bi bi-person"></i>

                            Sign In

                        </a>

                    </sec:ifNotLoggedIn>


                </div>

            </div>

        </div>

    </nav>

</header>



<main class="application-content">

    <g:layoutBody/>

</main>



<footer
    class="premium-footer"
    role="contentinfo">

    <div class="container premium-footer-content">


        <div class="premium-footer-top">


            <div class="premium-footer-brand">


                <div class="premium-footer-logo">

                    <i class="bi bi-car-front-fill"></i>

                </div>


                <div>

                    <div class="premium-footer-name">

                        Car Rental

                    </div>


                    <div class="premium-footer-caption">

                        Premium Mobility Management

                    </div>

                </div>


            </div>



            <div class="premium-footer-links">


                <a href="${createLink(uri: '/')}">

                    Home

                </a>


                <sec:ifLoggedIn>


                    <g:link
                        controller="car"
                        action="index">

                        Fleet

                    </g:link>


                    <g:link
                        controller="rental"
                        action="index">

                        Rentals

                    </g:link>


                    <sec:ifAnyGranted roles="ROLE_ADMIN">

                        <g:link
                            controller="dashboard"
                            action="index">

                            Dashboard

                        </g:link>

                    </sec:ifAnyGranted>


                </sec:ifLoggedIn>


            </div>


        </div>



        <div class="premium-footer-divider"></div>



        <div class="premium-footer-bottom">


            <span>

                © 2026 Car Rental Management System

            </span>



            <span class="system-online">


                <span class="online-dot"></span>


                System Online


            </span>


        </div>


    </div>

</footer>



<div
    id="spinner"
    style="display:none;">

    <div
        class="spinner-border spinner-border-sm"
        role="status">

        <span class="visually-hidden">

            Loading...

        </span>

    </div>

</div>



<asset:javascript src="application.js"/>


</body>

</html>
