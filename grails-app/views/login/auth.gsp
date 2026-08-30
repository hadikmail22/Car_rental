<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"/>

    <title>Sign In | Car Rental</title>

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
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500&family=Space+Grotesk:wght@500;600;700&display=swap"
        rel="stylesheet">

    <asset:stylesheet src="application.css"/>

    <style>

        :root {
            --login-black: #0b0c0f;
            --login-black-soft: #111318;
            --login-panel: #16181d;

            --login-gold: #f5a623;
            --login-gold-light: #ffd078;
            --login-gold-dark: #c9860f;

            --login-white: #f7f7f5;
            --login-muted: #96989f;

            --login-border:
                rgba(255, 255, 255, 0.10);
        }


        * {
            box-sizing: border-box;
        }


        html,
        body {
            min-height: 100%;
        }


        body {
            margin: 0;

            min-height: 100vh;

            color: var(--login-white);

            background:
                radial-gradient(
                    circle at 15% 15%,
                    rgba(245, 166, 35, 0.10),
                    transparent 24%
                ),
                radial-gradient(
                    circle at 85% 80%,
                    rgba(245, 166, 35, 0.06),
                    transparent 30%
                ),
                var(--login-black);

            font-family:
                'Inter',
                sans-serif;
        }


        /* =====================================
           PAGE
           ===================================== */

        .login-page {
            min-height: 100vh;

            display: grid;

            grid-template-columns:
                1.05fr
                0.95fr;
        }


        /* =====================================
           LEFT PANEL
           ===================================== */

        .login-visual {
            position: relative;

            display: flex;

            flex-direction: column;

            justify-content: space-between;

            overflow: hidden;

            padding: 42px 52px;

            border-right:
                1px solid var(--login-border);

            background:
                linear-gradient(
                    145deg,
                    #111318,
                    #08090b
                );
        }


        .login-visual::before {
            content: "";

            position: absolute;

            inset: 0;

            opacity: .35;

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
        }


        .login-visual::after {
            content: "";

            position: absolute;

            width: 520px;
            height: 520px;

            right: -160px;
            bottom: -180px;

            border-radius: 50%;

            background:
                radial-gradient(
                    circle,
                    rgba(245,166,35,.15),
                    transparent 67%
                );
        }


        .visual-content {
            position: relative;
            z-index: 2;
        }


        /* =====================================
           BRAND
           ===================================== */

        .login-brand {
            display: inline-flex;

            align-items: center;

            gap: 12px;

            color: var(--login-white);

            text-decoration: none;
        }


        .brand-icon {
            width: 48px;
            height: 48px;

            display: flex;

            align-items: center;
            justify-content: center;

            border:
                1px solid rgba(245,166,35,.55);

            border-radius: 13px;

            color: var(--login-gold);

            background:
                rgba(245,166,35,.06);

            font-size: 22px;
        }


        .brand-name {
            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 1.1rem;
            font-weight: 700;

            letter-spacing: -.02em;
        }


        .brand-subtitle {
            display: block;

            margin-top: 2px;

            color: var(--login-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: .57rem;

            letter-spacing: .18em;

            text-transform: uppercase;
        }


        /* =====================================
           HERO TEXT
           ===================================== */

        .visual-main {
            max-width: 620px;

            margin:
                auto 0;
        }


        .visual-eyebrow {
            margin-bottom: 16px;

            color: var(--login-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: .7rem;

            font-weight: 500;

            letter-spacing: .18em;

            text-transform: uppercase;
        }


        .visual-main h1 {
            margin:
                0 0 22px;

            color: #fff;

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size:
                clamp(3rem, 5vw, 5.5rem);

            line-height: .98;

            letter-spacing: -.055em;

            font-weight: 700;
        }


        .visual-main h1 span {
            color: var(--login-gold);
        }


        .visual-main p {
            max-width: 520px;

            margin: 0;

            color: #a7a9af;

            font-size: 1rem;

            line-height: 1.8;
        }


        .visual-footer {
            position: relative;
            z-index: 2;

            color: #65676d;

            font-size: .72rem;
        }


        /* =====================================
           RIGHT PANEL
           ===================================== */

        .login-form-side {
            display: flex;

            align-items: center;
            justify-content: center;

            padding: 40px;

            background:
                linear-gradient(
                    145deg,
                    #0d0e11,
                    #121419
                );
        }


        .login-container {
            width: 100%;
            max-width: 430px;
        }


        .mobile-brand {
            display: none;

            margin-bottom: 45px;
        }


        .login-heading {
            margin-bottom: 34px;
        }


        .login-heading .eyebrow {
            margin-bottom: 10px;

            color: var(--login-gold);

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: .67rem;

            font-weight: 500;

            letter-spacing: .16em;

            text-transform: uppercase;
        }


        .login-heading h2 {
            margin:
                0 0 10px;

            color: #fff;

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 2rem;

            font-weight: 700;

            letter-spacing: -.035em;
        }


        .login-heading p {
            margin: 0;

            color: var(--login-muted);

            font-size: .9rem;

            line-height: 1.6;
        }


        /* =====================================
           ERROR
           ===================================== */

        .login-error {
            margin-bottom: 22px;

            padding:
                13px 15px;

            border:
                1px solid rgba(229,72,77,.32);

            border-radius: 9px;

            color: #ff9699;

            background:
                rgba(229,72,77,.08);

            font-size: .84rem;
        }


        /* =====================================
           FORM
           ===================================== */

        .login-field {
            margin-bottom: 20px;
        }


        .login-label {
            display: block;

            margin-bottom: 7px;

            color: #b7b8bd;

            font-family:
                'JetBrains Mono',
                monospace;

            font-size: .68rem;

            font-weight: 500;

            letter-spacing: .08em;

            text-transform: uppercase;
        }


        .input-shell {
            position: relative;
        }


        .input-icon {
            position: absolute;

            top: 50%;
            left: 15px;

            transform:
                translateY(-50%);

            color: #6f7178;

            font-size: 1rem;

            pointer-events: none;
        }


        .login-input {
            width: 100%;
            height: 52px;

            padding:
                0 46px;

            border:
                1px solid
                rgba(255,255,255,.11);

            border-radius: 10px;

            outline: none;

            color: #fff;

            background:
                rgba(255,255,255,.035);

            font-size: .95rem;

            transition:
                border-color .18s ease,
                box-shadow .18s ease,
                background .18s ease;
        }


        .login-input::placeholder {
            color: #64666d;
        }


        .login-input:focus {
            border-color:
                rgba(245,166,35,.75);

            background:
                rgba(255,255,255,.05);

            box-shadow:
                0 0 0 4px
                rgba(245,166,35,.08);
        }


        .password-toggle {
            position: absolute;

            top: 50%;
            right: 14px;

            transform:
                translateY(-50%);

            border: 0;

            padding: 4px;

            color: #74767d;

            background: transparent;

            cursor: pointer;
        }


        .password-toggle:hover {
            color: var(--login-gold);
        }


        /* =====================================
           OPTIONS
           ===================================== */

        .login-options {
            display: flex;

            justify-content:
                space-between;

            align-items: center;

            gap: 15px;

            margin:
                5px 0 26px;

            color: #92949b;

            font-size: .8rem;
        }


        .remember-wrap {
            display: flex;

            align-items: center;

            gap: 8px;
        }


        .remember-wrap input {
            accent-color:
                var(--login-gold);
        }


        /* =====================================
           LOGIN BUTTON
           ===================================== */

        .login-submit {
            width: 100%;
            min-height: 52px;

            display: flex;

            align-items: center;
            justify-content: center;

            gap: 9px;

            border: 0;

            border-radius: 10px;

            color: #18120a;

            background:
                linear-gradient(
                    135deg,
                    #fac365,
                    #f5a623
                );

            font-weight: 700;

            box-shadow:
                0 12px 30px
                rgba(245,166,35,.15);

            cursor: pointer;

            transition:
                transform .18s ease,
                box-shadow .18s ease;
        }


        .login-submit:hover {
            transform:
                translateY(-2px);

            box-shadow:
                0 17px 38px
                rgba(245,166,35,.25);
        }


        /* =====================================
           BOTTOM
           ===================================== */

        .login-bottom {
            margin-top: 30px;

            padding-top: 24px;

            border-top:
                1px solid var(--login-border);

            text-align: center;

            color: #777981;

            font-size: .8rem;
        }


        .login-bottom a {
            color: var(--login-gold);

            font-weight: 600;

            text-decoration: none;
        }


        .login-bottom a:hover {
            color: var(--login-gold-light);
        }


        /* =====================================
           MOBILE
           ===================================== */

        @media (max-width: 991px) {

            .login-page {
                grid-template-columns:
                    1fr;
            }


            .login-visual {
                display: none;
            }


            .mobile-brand {
                display: block;
            }


            .login-form-side {
                min-height: 100vh;

                padding:
                    35px 20px;
            }
        }


        @media (max-width: 480px) {

            .login-heading h2 {
                font-size: 1.7rem;
            }


            .login-options {
                align-items:
                    flex-start;

                flex-direction:
                    column;
            }
        }

    </style>

</head>


<body>


<div class="login-page">


    <!-- ==================================
         LEFT
         ================================== -->

    <section class="login-visual">


        <div class="visual-content">

            <a
                href="${createLink(uri: '/')}"
                class="login-brand">

                <div class="brand-icon">
                    <i class="bi bi-car-front-fill"></i>
                </div>

                <div>

                    <div class="brand-name">
                        Car Rental
                    </div>

                    <span class="brand-subtitle">
                        Premium Mobility
                    </span>

                </div>

            </a>

        </div>


        <div class="visual-content visual-main">

            <div class="visual-eyebrow">
                Member Access
            </div>


            <h1>
                Your next
                <span>drive</span>
                starts here.
            </h1>


            <p>
                Sign in to browse the fleet,
                manage your rentals and keep
                track of your bookings from one
                secure account.
            </p>

        </div>


        <div class="visual-footer">
            Car Rental Management System · 2026
        </div>


    </section>



    <!-- ==================================
         RIGHT
         ================================== -->

    <section class="login-form-side">

        <div class="login-container">


            <!-- Mobile logo -->
            <div class="mobile-brand">

                <a
                    href="${createLink(uri: '/')}"
                    class="login-brand">

                    <div class="brand-icon">
                        <i class="bi bi-car-front-fill"></i>
                    </div>

                    <div>

                        <div class="brand-name">
                            Car Rental
                        </div>

                        <span class="brand-subtitle">
                            Premium Mobility
                        </span>

                    </div>

                </a>

            </div>


            <div class="login-heading">

                <div class="eyebrow">
                    Secure Sign In
                </div>

                <h2>
                    Welcome back
                </h2>

                <p>
                    Enter your account details
                    to continue.
                </p>

            </div>


            <!-- Error -->
            <g:if test="${flash.message}">

                <div class="login-error">

                    <i class="bi bi-exclamation-circle me-2"></i>

                    ${flash.message}

                </div>

            </g:if>


            <!-- Form -->
            <form
                action="${postUrl ?: createLink(uri: '/login/authenticate')}"
                method="POST"
                autocomplete="off">


                <!-- Username -->
                <div class="login-field">

                    <label
                        class="login-label"
                        for="username">

                        Email Address

                    </label>


                    <div class="input-shell">

                        <i
                            class="bi bi-envelope input-icon">
                        </i>


                        <input
                            type="text"
                            name="${usernameParameter ?: 'username'}"
                            id="username"
                            class="login-input"
                            placeholder="you@example.com"
                            autocomplete="username"
                            autofocus
                            required/>

                    </div>

                </div>


                <!-- Password -->
                <div class="login-field">

                    <label
                        class="login-label"
                        for="password">

                        Password

                    </label>


                    <div class="input-shell">

                        <i
                            class="bi bi-lock input-icon">
                        </i>


                        <input
                            type="password"
                            name="${passwordParameter ?: 'password'}"
                            id="password"
                            class="login-input"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required/>


                        <button
                            type="button"
                            class="password-toggle"
                            onclick="togglePassword()"
                            aria-label="Show or hide password">

                            <i
                                id="passwordIcon"
                                class="bi bi-eye">
                            </i>

                        </button>

                    </div>

                </div>


                <!-- Options -->
                <div class="login-options">

                    <label class="remember-wrap">

                        <input
                            type="checkbox"
                            name="${rememberMeParameter ?: 'remember-me'}"
                            <g:if test="${hasCookie}">
                                checked="checked"
                            </g:if>/>

                        <span>
                            Remember me
                        </span>

                    </label>


                    <span>
                        Secure account access
                    </span>

                </div>


                <!-- Submit -->
                <button
                    type="submit"
                    class="login-submit">

                    Sign In

                    <i class="bi bi-arrow-right"></i>

                </button>


            </form>


            <div class="login-bottom">

                <a href="${createLink(uri: '/')}">
                    ← Back to home
                </a>

            </div>


        </div>

    </section>

</div>


<asset:javascript src="application.js"/>


<script>

    function togglePassword() {

        const password =
            document.getElementById('password');

        const icon =
            document.getElementById('passwordIcon');


        if (password.type === 'password') {

            password.type = 'text';

            icon.classList.remove('bi-eye');

            icon.classList.add('bi-eye-slash');

        } else {

            password.type = 'password';

            icon.classList.remove('bi-eye-slash');

            icon.classList.add('bi-eye');
        }
    }

</script>


</body>

</html>