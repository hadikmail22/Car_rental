<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Sign In | Car Rental</title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Geist+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
    <asset:stylesheet src="application.css"/>
    <style>
        :root {
            --login-gold: #f5a623;
            --login-gold-light: #ffd27c;
            --login-white: #f8f8f6;
            --login-muted: #a8abb2;
            --login-border: rgba(255, 255, 255, .14);
            --login-panel: rgba(9, 11, 15, .72);
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
            color: var(--login-white);
            background: #07090c;
            font-family: 'Inter', sans-serif;
        }

        button,
        input {
            font: inherit;
        }

        .login-page {
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            overflow: hidden;
            isolation: isolate;
            background-image:
                linear-gradient(90deg, rgba(3, 5, 8, .88) 0%, rgba(3, 5, 8, .69) 38%, rgba(3, 5, 8, .22) 72%, rgba(3, 5, 8, .30) 100%),
                url('https://images.unsplash.com/photo-1525198748134-37e71b522e9c?auto=format&fit=crop&w=2400&q=88');
            background-position: center;
            background-size: cover;
        }

        .login-page::before {
            content: "";
            position: absolute;
            inset: 0;
            z-index: -1;
            pointer-events: none;
            background:
                radial-gradient(circle at 24% 54%, rgba(245, 166, 35, .12), transparent 31%),
                linear-gradient(180deg, rgba(0, 0, 0, .27), transparent 32%, transparent 68%, rgba(0, 0, 0, .62));
        }

        .login-page::after {
            content: "";
            position: absolute;
            inset: 0;
            z-index: -1;
            opacity: .15;
            pointer-events: none;
            background-image:
                linear-gradient(rgba(255, 255, 255, .025) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 255, 255, .025) 1px, transparent 1px);
            background-size: 54px 54px;
            mask-image: linear-gradient(90deg, #000, transparent 68%);
        }

        .login-shell {
            width: min(100% - 48px, 1280px);
            min-height: 100vh;
            margin: 0 auto;
            padding: 58px 0;
            display: grid;
            grid-template-columns: minmax(340px, 480px) 1fr;
            align-items: center;
            gap: clamp(48px, 8vw, 130px);
        }

        .login-card {
            position: relative;
            width: 100%;
            padding: clamp(30px, 4vw, 46px);
            overflow: hidden;
            border: 1px solid var(--login-border);
            border-radius: 26px;
            background:
                linear-gradient(145deg, rgba(24, 27, 33, .79), rgba(7, 9, 13, .68)),
                var(--login-panel);
            box-shadow:
                0 32px 90px rgba(0, 0, 0, .48),
                inset 0 1px 0 rgba(255, 255, 255, .08);
            backdrop-filter: blur(24px) saturate(125%);
            -webkit-backdrop-filter: blur(24px) saturate(125%);
        }

        .login-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 44px;
            width: 120px;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--login-gold), transparent);
            box-shadow: 0 0 18px rgba(245, 166, 35, .55);
        }

        .login-brand {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            color: #fff;
            text-decoration: none;
        }

        .brand-mark {
            width: 48px;
            height: 48px;
            display: grid;
            place-items: center;
            flex: 0 0 48px;
            border: 1px solid rgba(245, 166, 35, .5);
            border-radius: 15px;
            color: var(--login-gold);
            background: rgba(245, 166, 35, .1);
            box-shadow: inset 0 0 22px rgba(245, 166, 35, .05);
            font-size: 1.25rem;
        }

        .brand-name {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.05rem;
            font-weight: 700;
            letter-spacing: -.02em;
        }

        .brand-subtitle {
            display: block;
            margin-top: 2px;
            color: var(--login-gold);
            font-family: 'JetBrains Mono', monospace;
            font-size: .55rem;
            font-weight: 600;
            letter-spacing: .16em;
            text-transform: uppercase;
        }

        .login-heading {
            margin: 42px 0 30px;
        }

        .login-eyebrow {
            margin-bottom: 10px;
            color: var(--login-gold);
            font-family: 'JetBrains Mono', monospace;
            font-size: .66rem;
            font-weight: 600;
            letter-spacing: .16em;
            text-transform: uppercase;
        }

        .login-heading h1 {
            margin: 0 0 9px;
            color: #fff;
            font-family: 'Space Grotesk', sans-serif;
            font-size: clamp(2rem, 4vw, 2.55rem);
            font-weight: 700;
            letter-spacing: -.045em;
        }

        .login-heading p {
            margin: 0;
            color: var(--login-muted);
            font-size: .91rem;
            line-height: 1.65;
        }

        .login-error {
            margin-bottom: 22px;
            padding: 13px 15px;
            display: flex;
            align-items: flex-start;
            gap: 9px;
            border: 1px solid rgba(255, 96, 102, .36);
            border-radius: 11px;
            color: #ffafb2;
            background: rgba(188, 38, 45, .13);
            font-size: .84rem;
            line-height: 1.5;
        }

        .login-field {
            margin-bottom: 19px;
        }

        .login-label {
            display: block;
            margin-bottom: 8px;
            color: #d0d1d5;
            font-family: 'JetBrains Mono', monospace;
            font-size: .66rem;
            font-weight: 600;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .input-shell {
            position: relative;
        }

        .input-icon {
            position: absolute;
            top: 50%;
            left: 16px;
            transform: translateY(-50%);
            color: #8d9097;
            pointer-events: none;
        }

        .login-input {
            width: 100%;
            height: 54px;
            padding: 0 48px;
            border: 1px solid rgba(255, 255, 255, .13);
            border-radius: 12px;
            outline: none;
            color: #fff;
            background: rgba(255, 255, 255, .075);
            caret-color: var(--login-gold);
            transition: border-color .18s ease, box-shadow .18s ease, background .18s ease;
        }

        .login-input::placeholder {
            color: #82858c;
        }

        .login-input:focus {
            border-color: rgba(245, 166, 35, .78);
            background: rgba(255, 255, 255, .1);
            box-shadow: 0 0 0 4px rgba(245, 166, 35, .11);
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 13px;
            width: 34px;
            height: 34px;
            display: grid;
            place-items: center;
            transform: translateY(-50%);
            border: 0;
            border-radius: 9px;
            color: #92959b;
            background: transparent;
            cursor: pointer;
            transition: color .18s ease, background .18s ease;
        }

        .password-toggle:hover,
        .password-toggle:focus-visible {
            color: var(--login-gold-light);
            background: rgba(245, 166, 35, .1);
            outline: none;
        }

        .login-options {
            margin: 3px 0 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            color: #a4a6ac;
            font-size: .79rem;
        }

        .remember-wrap {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .remember-wrap input {
            width: 16px;
            height: 16px;
            margin: 0;
            accent-color: var(--login-gold);
        }

        .secure-access {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #85888f;
        }

        .secure-access i {
            color: #5fcf8d;
        }

        .login-submit {
            width: 100%;
            min-height: 54px;
            padding: 0 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            border: 0;
            border-radius: 12px;
            color: #171108;
            background: linear-gradient(135deg, #ffd078, #f5a623 62%, #da8b0e);
            font-weight: 800;
            box-shadow: 0 15px 36px rgba(245, 166, 35, .22);
            cursor: pointer;
            transition: transform .18s ease, box-shadow .18s ease, filter .18s ease;
        }

        .login-submit:hover {
            transform: translateY(-2px);
            filter: brightness(1.04);
            box-shadow: 0 19px 44px rgba(245, 166, 35, .31);
        }

        .login-submit:active {
            transform: translateY(0);
        }

        .login-submit:focus-visible {
            outline: 3px solid rgba(255, 208, 120, .35);
            outline-offset: 3px;
        }

        .login-bottom {
            margin-top: 26px;
            padding-top: 21px;
            border-top: 1px solid rgba(255, 255, 255, .09);
            text-align: center;
        }

        .login-bottom a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #c5c7cb;
            font-size: .8rem;
            font-weight: 600;
            text-decoration: none;
            transition: color .18s ease;
        }

        .login-bottom a:hover {
            color: var(--login-gold-light);
        }

        .login-copy {
            max-width: 510px;
            justify-self: end;
            align-self: end;
            margin-bottom: 24px;
            text-align: right;
            text-shadow: 0 3px 28px rgba(0, 0, 0, .8);
        }

        .login-copy .copy-line {
            margin-bottom: 12px;
            color: var(--login-gold-light);
            font-family: 'JetBrains Mono', monospace;
            font-size: .65rem;
            font-weight: 600;
            letter-spacing: .18em;
            text-transform: uppercase;
        }

        .login-copy h2 {
            margin: 0;
            color: #fff;
            font-family: 'Space Grotesk', sans-serif;
            font-size: clamp(2.2rem, 4vw, 4.7rem);
            font-weight: 700;
            line-height: .98;
            letter-spacing: -.055em;
        }

        .photo-credit {
            position: absolute;
            right: 22px;
            bottom: 14px;
            z-index: 2;
            color: rgba(255, 255, 255, .54);
            font-size: .62rem;
            text-decoration: none;
            transition: color .18s ease;
        }

        .photo-credit:hover {
            color: #fff;
        }

        @media (max-width: 960px) {
            .login-page {
                background-position: 64% center;
                background-image:
                    linear-gradient(90deg, rgba(3, 5, 8, .82), rgba(3, 5, 8, .55)),
                    url('https://images.unsplash.com/photo-1525198748134-37e71b522e9c?auto=format&fit=crop&w=1800&q=86');
            }

            .login-shell {
                grid-template-columns: minmax(0, 480px);
                justify-content: center;
            }

            .login-copy {
                display: none;
            }
        }

        @media (max-width: 560px) {
            .login-page {
                align-items: stretch;
                background-position: 61% center;
            }

            .login-shell {
                width: min(100% - 28px, 480px);
                min-height: 100vh;
                padding: 28px 0 44px;
            }

            .login-card {
                padding: 28px 22px;
                border-radius: 22px;
            }

            .login-heading {
                margin: 34px 0 27px;
            }

            .login-options {
                align-items: flex-start;
                flex-direction: column;
            }

            .photo-credit {
                right: 14px;
                bottom: 10px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                scroll-behavior: auto !important;
                transition-duration: .01ms !important;
            }
        }
    </style>
    <asset:stylesheet src="theme-advent.css"/>
</head>
<body>
<main class="login-page">
    <div class="login-shell">
        <section class="login-card" aria-labelledby="loginTitle">
            <a href="${createLink(uri: '/')}" class="login-brand">
                <span class="brand-mark">
                    <i class="bi bi-car-front-fill"></i>
                </span>
                <span>
                    <span class="brand-name">Car Rental</span>
                    <span class="brand-subtitle">Premium Mobility</span>
                </span>
            </a>

            <div class="login-heading">
                <div class="login-eyebrow">Secure Member Access</div>
                <h1 id="loginTitle">Welcome back</h1>
                <p>Enter your account details to manage your rentals and continue your journey.</p>
            </div>

            <g:if test="${flash.message}">
                <div class="login-error" role="alert">
                    <i class="bi bi-exclamation-circle-fill"></i>
                    <span>${flash.message}</span>
                </div>
            </g:if>

            <form action="${postUrl ?: createLink(uri: '/login/authenticate')}" method="POST" autocomplete="off">
                <div class="login-field">
                    <label class="login-label" for="username">Email Address</label>
                    <div class="input-shell">
                        <i class="bi bi-envelope input-icon"></i>
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

                <div class="login-field">
                    <label class="login-label" for="password">Password</label>
                    <div class="input-shell">
                        <i class="bi bi-lock input-icon"></i>
                        <input
                            type="password"
                            name="${passwordParameter ?: 'password'}"
                            id="password"
                            class="login-input"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required/>
                        <button type="button" class="password-toggle" id="passwordToggle" aria-label="Show password" aria-pressed="false">
                            <i id="passwordIcon" class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="login-options">
                    <label class="remember-wrap">
                        <input
                            type="checkbox"
                            name="${rememberMeParameter ?: 'remember-me'}"
                            <g:if test="${hasCookie}">checked="checked"</g:if>/>
                        <span>Remember me</span>
                    </label>
                    <span class="secure-access">
                        <i class="bi bi-shield-check"></i>
                        Secure access
                    </span>
                </div>

                <button type="submit" class="login-submit">
                    <span>Sign In</span>
                    <i class="bi bi-arrow-right"></i>
                </button>
            </form>

            <div class="login-bottom">
                <a href="${createLink(uri: '/')}">
                    <i class="bi bi-arrow-left"></i>
                    Back to home
                </a>
            </div>
        </section>

        <section class="login-copy" aria-hidden="true">
            <div class="copy-line">Luxury in every journey</div>
            <h2>Your next drive starts here.</h2>
        </section>
    </div>

    <a class="photo-credit" href="https://unsplash.com/photos/black-mercedes-benz-sedan-qqUik37MSb0" target="_blank" rel="noreferrer">
        Photo by Jeremy Thomas on Unsplash
    </a>
</main>

<asset:javascript src="application.js"/>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const password = document.getElementById('password');
        const toggle = document.getElementById('passwordToggle');
        const icon = document.getElementById('passwordIcon');

        if (!password || !toggle || !icon) {
            return;
        }

        toggle.addEventListener('click', function () {
            const isHidden = password.type === 'password';
            password.type = isHidden ? 'text' : 'password';
            toggle.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
            toggle.setAttribute('aria-pressed', isHidden ? 'true' : 'false');
            icon.classList.toggle('bi-eye', !isHidden);
            icon.classList.toggle('bi-eye-slash', isHidden);
            password.focus();
        });
    });
</script>
</body>
</html>
