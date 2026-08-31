<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <title>Car Rental | Premium Mobility</title>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&family=Space+Grotesk:wght@500;600;700&display=swap"
        rel="stylesheet">

    <asset:stylesheet src="application.css"/>

    <style>
        :root{
            --home-black:#08090b;
            --home-black-2:#0d0f13;
            --home-panel:#13161b;
            --home-panel-2:#181b20;
            --home-gold:#f5a623;
            --home-gold-light:#ffd37a;
            --home-white:#f7f7f5;
            --home-muted:#9ea1aa;
            --home-line:rgba(255,255,255,.10);
            --home-green:#47c47a;
        }

        *{ box-sizing:border-box; }

        html{ scroll-behavior:smooth; }

        body{
            margin:0;
            min-height:100vh;
            background:var(--home-black);
            color:var(--home-white);
            font-family:'Inter',sans-serif;
        }

        .home-shell{
            overflow:hidden;
            background:
                radial-gradient(circle at 72% 12%, rgba(245,166,35,.09), transparent 24%),
                var(--home-black);
        }

        /* =========================
           NAVIGATION
           ========================= */

        .home-nav{
            position:absolute;
            inset:0 0 auto 0;
            z-index:50;
            padding:20px 0;
            border-bottom:1px solid rgba(255,255,255,.05);
            background:linear-gradient(
                to bottom,
                rgba(8,9,11,.97),
                rgba(8,9,11,.72),
                transparent
            );
        }

        .home-nav-row{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:24px;
        }

        .home-brand{
            display:flex;
            align-items:center;
            gap:12px;
            color:#fff;
            text-decoration:none;
        }

        .home-brand:hover{ color:#fff; }

        .home-brand-mark{
            width:48px;
            height:48px;
            display:grid;
            place-items:center;
            border:1px solid rgba(245,166,35,.45);
            border-radius:14px;
            background:rgba(245,166,35,.08);
            color:var(--home-gold);
            font-size:1.35rem;
            box-shadow:0 0 30px rgba(245,166,35,.07);
        }

        .home-brand-name{
            font-family:'Space Grotesk',sans-serif;
            font-size:1.08rem;
            font-weight:700;
            line-height:1;
        }

        .home-brand-sub{
            display:block;
            margin-top:5px;
            color:var(--home-gold);
            font-family:'JetBrains Mono',monospace;
            font-size:.55rem;
            letter-spacing:.2em;
            text-transform:uppercase;
        }

        .home-nav-links{
            display:flex;
            align-items:center;
            gap:30px;
        }

        .home-nav-links a{
            color:#b9bbc3;
            text-decoration:none;
            font-size:.88rem;
            font-weight:500;
            transition:.2s ease;
        }

        .home-nav-links a:hover{
            color:var(--home-gold-light);
        }

        .home-nav-actions{
            display:flex;
            align-items:center;
            gap:10px;
        }

        .home-nav-button{
            min-height:42px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            padding:0 18px;
            border-radius:9px;
            text-decoration:none;
            font-size:.86rem;
            font-weight:700;
            transition:.2s ease;
        }

        .home-nav-button-outline{
            color:var(--home-gold-light);
            border:1px solid rgba(245,166,35,.55);
            background:rgba(245,166,35,.035);
        }

        .home-nav-button-outline:hover{
            color:#15110a;
            background:var(--home-gold);
            border-color:var(--home-gold);
        }

        /* =========================
           HERO
           ========================= */

        .home-hero{
            position:relative;
            min-height:760px;
            display:flex;
            align-items:center;
            padding:128px 0 105px;
            overflow:hidden;
        }

        .home-hero::before{
            content:"";
            position:absolute;
            inset:0;
            pointer-events:none;
            opacity:.17;
            background-image:
                linear-gradient(rgba(255,255,255,.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.03) 1px, transparent 1px);
            background-size:58px 58px;
            mask-image:linear-gradient(to bottom, transparent, #000 20%, #000 78%, transparent);
        }

        .home-hero::after{
            content:"";
            position:absolute;
            width:560px;
            height:560px;
            right:8%;
            top:17%;
            border-radius:50%;
            background:radial-gradient(
                circle,
                rgba(245,166,35,.14),
                rgba(245,166,35,.035) 42%,
                transparent 70%
            );
            filter:blur(3px);
        }

        .home-hero-grid{
            position:relative;
            z-index:2;
            display:grid;
            grid-template-columns:minmax(0,.92fr) minmax(430px,1.08fr);
            gap:70px;
            align-items:center;
        }

        .home-eyebrow{
            display:flex;
            align-items:center;
            gap:12px;
            margin-bottom:20px;
            color:var(--home-gold);
            font-family:'JetBrains Mono',monospace;
            font-size:.7rem;
            font-weight:600;
            letter-spacing:.18em;
            text-transform:uppercase;
        }

        .home-eyebrow::after{
            content:"";
            width:50px;
            height:1px;
            background:var(--home-gold);
        }

        .home-hero h1{
            margin:0;
            max-width:700px;
            font-family:'Space Grotesk',sans-serif;
            font-weight:700;
            font-size:clamp(3.5rem,6vw,6.2rem);
            line-height:.94;
            letter-spacing:-.06em;
            color:#fff;
        }

        .home-hero h1 .gold{
            color:var(--home-gold);
        }

        .home-hero-copy{
            max-width:590px;
            margin:28px 0 34px;
            color:#b5b7bf;
            line-height:1.8;
            font-size:1.02rem;
        }

        .home-actions{
            display:flex;
            flex-wrap:wrap;
            gap:12px;
        }

        .home-button{
            min-height:52px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:9px;
            padding:0 24px;
            border-radius:9px;
            font-weight:700;
            text-decoration:none;
            transition:transform .2s ease, box-shadow .2s ease, border-color .2s ease;
        }

        .home-button:hover{
            transform:translateY(-2px);
        }

        .home-button-primary{
            color:#17120a;
            background:linear-gradient(135deg,#f9bf5a,#f5a623);
            box-shadow:0 14px 36px rgba(245,166,35,.18);
        }

        .home-button-primary:hover{
            color:#17120a;
            box-shadow:0 18px 44px rgba(245,166,35,.28);
        }

        .home-button-ghost{
            color:#e5e5e7;
            border:1px solid rgba(255,255,255,.16);
            background:rgba(255,255,255,.025);
        }

        .home-button-ghost:hover{
            color:var(--home-gold-light);
            border-color:rgba(245,166,35,.48);
        }

        /* HERO VEHICLE */

        .hero-car-stage{
            position:relative;
            min-height:470px;
        }

        .hero-car-card{
            position:absolute;
            inset:34px 0 28px 0;
            overflow:hidden;
            border:1px solid var(--home-line);
            border-radius:24px;
            background:
                linear-gradient(145deg,rgba(255,255,255,.07),rgba(255,255,255,.02)),
                #111318;
            box-shadow:0 42px 110px rgba(0,0,0,.55);
        }

        .hero-car-image{
            width:100%;
            height:100%;
            object-fit:cover;
            display:block;
        }

        .hero-car-card::after{
            content:"";
            position:absolute;
            inset:0;
            background:
                linear-gradient(to top,rgba(5,6,8,.96) 0%,rgba(5,6,8,.20) 48%,transparent 72%),
                linear-gradient(to right,rgba(5,6,8,.18),transparent);
        }

        .hero-car-info{
            position:absolute;
            left:26px;
            right:26px;
            bottom:24px;
            z-index:3;
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            gap:20px;
        }

        .hero-car-kicker{
            display:block;
            margin-bottom:7px;
            color:var(--home-gold);
            font-family:'JetBrains Mono',monospace;
            font-size:.62rem;
            letter-spacing:.16em;
            text-transform:uppercase;
        }

        .hero-car-name{
            margin:0;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.6rem;
            font-weight:700;
        }

        .hero-car-price{
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.25rem;
            font-weight:700;
            white-space:nowrap;
        }

        .hero-car-price small{
            color:#9ea1aa;
            font-family:'Inter',sans-serif;
            font-size:.72rem;
            font-weight:500;
        }

        .hero-car-badge{
            position:absolute;
            top:52px;
            right:18px;
            z-index:4;
            padding:7px 10px;
            border:1px solid rgba(71,196,122,.32);
            border-radius:999px;
            color:#72dc9a;
            background:rgba(26,91,53,.48);
            backdrop-filter:blur(10px);
            font-family:'JetBrains Mono',monospace;
            font-size:.61rem;
            letter-spacing:.1em;
        }

        .hero-car-fallback{
            height:100%;
            display:grid;
            place-items:center;
            color:var(--home-gold);
            font-size:8rem;
            background:
                radial-gradient(circle,rgba(245,166,35,.13),transparent 38%),
                #121419;
        }

        /* =========================
           STATS
           ========================= */

        .home-stats{
            position:relative;
            z-index:10;
            margin-top:-62px;
        }

        .home-stats-grid{
            display:grid;
            grid-template-columns:repeat(4,1fr);
            overflow:hidden;
            border:1px solid var(--home-line);
            border-radius:17px;
            background:rgba(19,22,27,.97);
            box-shadow:0 30px 80px rgba(0,0,0,.34);
        }

        .home-stat{
            position:relative;
            padding:26px 28px;
        }

        .home-stat:not(:last-child)::after{
            content:"";
            position:absolute;
            top:24%;
            bottom:24%;
            right:0;
            width:1px;
            background:var(--home-line);
        }

        .home-stat-top{
            display:flex;
            align-items:center;
            gap:12px;
            margin-bottom:10px;
        }

        .home-stat-icon{
            width:40px;
            height:40px;
            display:grid;
            place-items:center;
            border:1px solid rgba(245,166,35,.25);
            border-radius:50%;
            color:var(--home-gold);
            background:rgba(245,166,35,.06);
        }

        .home-stat-value{
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.7rem;
            font-weight:700;
        }

        .home-stat-label{
            color:#8f929a;
            font-size:.77rem;
        }

        /* =========================
           SECTIONS
           ========================= */

        .home-section{
            padding:108px 0;
        }

        .home-section-dark{
            background:#0d0f12;
        }

        .home-section-header{
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            gap:24px;
            margin-bottom:34px;
        }

        .home-section-label{
            color:var(--home-gold);
            font-family:'JetBrains Mono',monospace;
            font-size:.68rem;
            font-weight:600;
            letter-spacing:.18em;
            text-transform:uppercase;
        }

        .home-section-title{
            margin:10px 0 0;
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:clamp(2rem,3vw,3rem);
            font-weight:700;
            letter-spacing:-.035em;
        }

        .home-section-link{
            color:var(--home-gold-light);
            text-decoration:none;
            font-size:.82rem;
            font-weight:600;
        }

        .home-section-link:hover{
            color:#fff;
        }

        /* FEATURED CARS */

        .featured-grid{
            display:grid;
            grid-template-columns:repeat(3,minmax(0,1fr));
            gap:18px;
        }

        .featured-card{
            overflow:hidden;
            border:1px solid var(--home-line);
            border-radius:15px;
            background:linear-gradient(145deg,#171a20,#111318);
            transition:transform .22s ease,border-color .22s ease,box-shadow .22s ease;
        }

        .featured-card:hover{
            transform:translateY(-5px);
            border-color:rgba(245,166,35,.35);
            box-shadow:0 24px 60px rgba(0,0,0,.3);
        }

        .featured-image-wrap{
            position:relative;
            height:225px;
            overflow:hidden;
            background:#0b0c0f;
        }

        .featured-image{
            width:100%;
            height:100%;
            object-fit:cover;
            display:block;
            transition:transform .35s ease;
        }

        .featured-card:hover .featured-image{
            transform:scale(1.035);
        }

        .featured-image-wrap::after{
            content:"";
            position:absolute;
            inset:0;
            background:linear-gradient(to top,rgba(10,11,13,.78),transparent 48%);
        }

        .featured-status{
            position:absolute;
            z-index:2;
            top:14px;
            left:14px;
            padding:6px 9px;
            border-radius:999px;
            color:#7ae0a0;
            background:rgba(17,76,42,.78);
            border:1px solid rgba(89,211,133,.24);
            font-family:'JetBrains Mono',monospace;
            font-size:.56rem;
            letter-spacing:.09em;
        }

        .featured-fallback{
            height:100%;
            display:grid;
            place-items:center;
            color:var(--home-gold);
            font-size:4.5rem;
            background:
                radial-gradient(circle,rgba(245,166,35,.11),transparent 40%),
                #101216;
        }

        .featured-body{
            padding:21px;
        }

        .featured-top{
            display:flex;
            align-items:flex-start;
            justify-content:space-between;
            gap:14px;
        }

        .featured-name{
            margin:0;
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.15rem;
            font-weight:700;
        }

        .featured-year{
            display:block;
            margin-top:5px;
            color:#777a83;
            font-family:'JetBrains Mono',monospace;
            font-size:.62rem;
        }

        .featured-price{
            color:var(--home-gold-light);
            font-family:'Space Grotesk',sans-serif;
            font-weight:700;
            white-space:nowrap;
        }

        .featured-price small{
            color:#7d8089;
            font-family:'Inter',sans-serif;
            font-size:.66rem;
            font-weight:500;
        }

        .featured-divider{
            height:1px;
            margin:18px 0;
            background:var(--home-line);
        }

        .featured-action{
            display:flex;
            align-items:center;
            justify-content:space-between;
            color:#c9cbd0;
            text-decoration:none;
            font-size:.78rem;
            font-weight:600;
        }

        .featured-action i{
            color:var(--home-gold);
            transition:transform .2s ease;
        }

        .featured-action:hover{
            color:var(--home-gold-light);
        }

        .featured-action:hover i{
            transform:translateX(4px);
        }

        .featured-empty{
            grid-column:1/-1;
            padding:38px;
            border:1px dashed var(--home-line);
            border-radius:14px;
            color:#8f929a;
            text-align:center;
            background:#121419;
        }

        /* EXPERIENCE */

        .experience-grid{
            display:grid;
            grid-template-columns:repeat(3,1fr);
            gap:18px;
        }

        .experience-card{
            padding:30px;
            border:1px solid var(--home-line);
            border-radius:14px;
            background:linear-gradient(145deg,#171a20,#121419);
        }

        .experience-number{
            color:var(--home-gold);
            font-family:'JetBrains Mono',monospace;
            font-size:.64rem;
            letter-spacing:.1em;
        }

        .experience-icon{
            width:48px;
            height:48px;
            display:grid;
            place-items:center;
            margin:24px 0 20px;
            border:1px solid rgba(245,166,35,.25);
            border-radius:12px;
            color:var(--home-gold);
            background:rgba(245,166,35,.055);
            font-size:1.2rem;
        }

        .experience-card h3{
            margin:0 0 10px;
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.12rem;
        }

        .experience-card p{
            margin:0;
            color:#91949c;
            line-height:1.7;
            font-size:.86rem;
        }

        /* CTA */

        .home-cta{
            padding:0 0 105px;
            background:#0d0f12;
        }

        .home-cta-panel{
            position:relative;
            overflow:hidden;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:30px;
            padding:48px 52px;
            border:1px solid rgba(245,166,35,.22);
            border-radius:18px;
            background:
                radial-gradient(circle at 85% 50%,rgba(245,166,35,.14),transparent 28%),
                linear-gradient(135deg,#17191e,#101216);
        }

        .home-cta-panel::after{
            content:"";
            position:absolute;
            width:300px;
            height:300px;
            right:-90px;
            top:-100px;
            border:1px solid rgba(245,166,35,.11);
            border-radius:50%;
        }

        .home-cta h2{
            margin:0 0 10px;
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:2rem;
            font-weight:700;
        }

        .home-cta p{
            margin:0;
            color:#9699a1;
        }

        .home-cta .home-button{
            position:relative;
            z-index:2;
            flex:0 0 auto;
        }

        /* FOOTER */

        .home-footer{
            padding:30px 0;
            border-top:1px solid var(--home-line);
            background:#08090b;
        }

        .home-footer-row{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:20px;
            color:#72757d;
            font-size:.76rem;
        }

        /* RESPONSIVE */

        @media (max-width:991px){
            .home-nav-links{ display:none; }

            .home-hero{
                min-height:auto;
                padding:145px 0 125px;
            }

            .home-hero-grid{
                grid-template-columns:1fr;
                gap:45px;
            }

            .hero-car-stage{
                min-height:420px;
            }

            .home-stats-grid{
                grid-template-columns:repeat(2,1fr);
            }

            .home-stat:nth-child(2)::after{ display:none; }

            .featured-grid,
            .experience-grid{
                grid-template-columns:1fr;
            }
        }

        @media (max-width:640px){
            .home-brand-sub{ display:none; }

            .home-nav-actions .home-nav-button{
                padding:0 13px;
            }

            .home-hero h1{
                font-size:3.35rem;
            }

            .hero-car-stage{
                min-height:330px;
            }

            .hero-car-card{
                inset:15px 0;
            }

            .hero-car-info{
                left:18px;
                right:18px;
                bottom:18px;
            }

            .hero-car-name{
                font-size:1.25rem;
            }

            .home-stats{
                margin-top:-45px;
            }

            .home-stats-grid{
                grid-template-columns:1fr;
            }

            .home-stat:not(:last-child)::after{
                top:auto;
                left:8%;
                right:8%;
                bottom:0;
                width:auto;
                height:1px;
            }

            .home-section{
                padding:82px 0;
            }

            .home-section-header{
                align-items:flex-start;
                flex-direction:column;
            }

            .home-cta-panel{
                padding:36px 28px;
                align-items:flex-start;
                flex-direction:column;
            }

            .home-footer-row{
                flex-direction:column;
                text-align:center;
            }
        }
    </style>
</head>

<body>

<g:set var="heroCar" value="${featuredCars ? featuredCars[0] : null}"/>

<div class="home-shell">

    <!-- NAVBAR -->
    <nav class="home-nav">

        <div class="container">

            <div class="home-nav-row">

                <a href="${createLink(uri:'/')}" class="home-brand">

                    <span class="home-brand-mark">
                        <i class="bi bi-car-front-fill"></i>
                    </span>

                    <span>
                        <span class="home-brand-name">
                            Car Rental
                        </span>

                        <span class="home-brand-sub">
                            Premium Mobility
                        </span>
                    </span>

                </a>


                <div class="home-nav-links">

                    <a href="${createLink(uri:'/')}">
                        Home
                    </a>

                    <a href="#featured">
                        Fleet
                    </a>

                    <a href="#experience">
                        How It Works
                    </a>

                    <g:link controller="car" action="index">
                        Browse Cars
                    </g:link>

                </div>


                <div class="home-nav-actions">

                    <sec:ifNotLoggedIn>

                        <a
                            href="${createLink(uri:'/login/auth')}"
                            class="home-nav-button home-nav-button-outline">

                            <i class="bi bi-person"></i>
                            Sign In

                        </a>

                    </sec:ifNotLoggedIn>


                    <sec:ifLoggedIn>

                        <g:link
                            controller="car"
                            action="index"
                            class="home-nav-button home-nav-button-outline">

                            <i class="bi bi-grid"></i>
                            Enter System

                        </g:link>

                    </sec:ifLoggedIn>

                </div>

            </div>

        </div>

    </nav>


    <!-- HERO -->
    <section class="home-hero">

        <div class="container">

            <div class="home-hero-grid">

                <div>

                    <div class="home-eyebrow">
                        Premium Car Rental
                    </div>

                    <h1>
                        Drive luxury.
                        <br/>
                        Rent with
                        <span class="gold">confidence.</span>
                    </h1>

                    <p class="home-hero-copy">
                        Browse real vehicles, compare daily prices and
                        reserve your next car through a simple rental
                        experience built around clear availability.
                    </p>

                    <div class="home-actions">

                        <g:link
                            controller="car"
                            action="index"
                            class="home-button home-button-primary">

                            <i class="bi bi-car-front"></i>
                            Explore Cars

                        </g:link>


                        <a
                            href="#featured"
                            class="home-button home-button-ghost">

                            <i class="bi bi-stars"></i>
                            Featured Fleet

                        </a>

                    </div>

                </div>


                <div class="hero-car-stage">

                    <div class="hero-car-card">

                        <g:if test="${heroCar}">

                            <g:if test="${heroCar.carImage}">

                                <img
                                    src="${createLink(
                                            controller:'car',
                                            action:'image',
                                            id:heroCar.id
                                    )}"
                                    alt="${heroCar.brand} ${heroCar.model}"
                                    class="hero-car-image"/>

                            </g:if><g:else>

                                <div class="hero-car-fallback">
                                    <i class="bi bi-car-front-fill"></i>
                                </div>

                            </g:else>


                            <span class="hero-car-badge">
                                AVAILABLE
                            </span>


                            <div class="hero-car-info">

                                <div>

                                    <span class="hero-car-kicker">
                                        Featured Vehicle
                                    </span>

                                    <h2 class="hero-car-name">
                                        ${heroCar.brand} ${heroCar.model}
                                    </h2>

                                </div>

                                <div class="hero-car-price">
                                    ${heroCar.pricePerDay}
                                    <small>/ day</small>
                                </div>

                            </div>

                        </g:if><g:else>

                            <div class="hero-car-fallback">
                                <i class="bi bi-car-front-fill"></i>
                            </div>

                        </g:else>

                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- LIVE STATS -->
    <section class="home-stats">

        <div class="container">

            <div class="home-stats-grid">

                <div class="home-stat">

                    <div class="home-stat-top">

                        <span class="home-stat-icon">
                            <i class="bi bi-car-front-fill"></i>
                        </span>

                        <span class="home-stat-value">
                            ${totalCars ?: 0}
                        </span>

                    </div>

                    <div class="home-stat-label">
                        Vehicles in our fleet
                    </div>

                </div>


                <div class="home-stat">

                    <div class="home-stat-top">

                        <span class="home-stat-icon">
                            <i class="bi bi-check-circle"></i>
                        </span>

                        <span class="home-stat-value">
                            ${availableCars ?: 0}
                        </span>

                    </div>

                    <div class="home-stat-label">
                        Available right now
                    </div>

                </div>


                <div class="home-stat">

                    <div class="home-stat-top">

                        <span class="home-stat-icon">
                            <i class="bi bi-credit-card"></i>
                        </span>

                        <span class="home-stat-value">
                            50
                        </span>

                    </div>

                    <div class="home-stat-label">
                        Booking deposit
                    </div>

                </div>


                <div class="home-stat">

                    <div class="home-stat-top">

                        <span class="home-stat-icon">
                            <i class="bi bi-clock"></i>
                        </span>

                        <span class="home-stat-value">
                            24/7
                        </span>

                    </div>

                    <div class="home-stat-label">
                        Online rental access
                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- FEATURED VEHICLES -->
    <section
        id="featured"
        class="home-section home-section-dark">

        <div class="container">

            <div class="home-section-header">

                <div>

                    <span class="home-section-label">
                        Featured Vehicles
                    </span>

                    <h2 class="home-section-title">
                        Ready for your next drive.
                    </h2>

                </div>


                <g:link
                    controller="car"
                    action="index"
                    class="home-section-link">

                    View all vehicles
                    <i class="bi bi-arrow-right ms-1"></i>

                </g:link>

            </div>


            <div class="featured-grid">

                <g:if test="${featuredCars}">

                    <g:each
                        in="${featuredCars}"
                        var="featuredCar">

                        <article class="featured-card">

                            <div class="featured-image-wrap">

                                <g:if test="${featuredCar.carImage}">

                                    <img
                                        src="${createLink(
                                                controller:'car',
                                                action:'image',
                                                id:featuredCar.id
                                        )}"
                                        alt="${featuredCar.brand} ${featuredCar.model}"
                                        class="featured-image"/>

                                </g:if><g:else>

                                    <div class="featured-fallback">
                                        <i class="bi bi-car-front-fill"></i>
                                    </div>

                                </g:else>

                                <span class="featured-status">
                                    AVAILABLE
                                </span>

                            </div>


                            <div class="featured-body">

                                <div class="featured-top">

                                    <div>

                                        <h3 class="featured-name">
                                            ${featuredCar.brand}
                                            ${featuredCar.model}
                                        </h3>

                                        <span class="featured-year">
                                            ${featuredCar.year}
                                        </span>

                                    </div>

                                    <div class="featured-price">
                                        ${featuredCar.pricePerDay}
                                        <small>/ day</small>
                                    </div>

                                </div>


                                <div class="featured-divider"></div>


                                <g:link
                                    controller="car"
                                    action="show"
                                    id="${featuredCar.id}"
                                    class="featured-action">

                                    <span>
                                        View Details
                                    </span>

                                    <i class="bi bi-arrow-right"></i>

                                </g:link>

                            </div>

                        </article>

                    </g:each>

                </g:if><g:else>

                    <div class="featured-empty">
                        No available featured vehicles right now.
                    </div>

                </g:else>

            </div>

        </div>

    </section>


    <!-- EXPERIENCE -->
    <section id="experience" class="home-section">

        <div class="container">

            <div class="home-section-header">

                <div>

                    <span class="home-section-label">
                        How It Works
                    </span>

                    <h2 class="home-section-title">
                        Rental without the guesswork.
                    </h2>

                </div>

            </div>


            <div class="experience-grid">

                <div class="experience-card">

                    <span class="experience-number">
                        01
                    </span>

                    <div class="experience-icon">
                        <i class="bi bi-search"></i>
                    </div>

                    <h3>
                        Choose your vehicle
                    </h3>

                    <p>
                        Browse the fleet, compare daily prices and
                        open full vehicle details before you reserve.
                    </p>

                </div>


                <div class="experience-card">

                    <span class="experience-number">
                        02
                    </span>

                    <div class="experience-icon">
                        <i class="bi bi-calendar3"></i>
                    </div>

                    <h3>
                        Select your dates
                    </h3>

                    <p>
                        Review existing confirmed bookings and
                        choose a rental period that works for you.
                    </p>

                </div>


                <div class="experience-card">

                    <span class="experience-number">
                        03
                    </span>

                    <div class="experience-icon">
                        <i class="bi bi-key"></i>
                    </div>

                    <h3>
                        Confirm and drive
                    </h3>

                    <p>
                        Pay the booking deposit, track your rental
                        status and complete pickup through one system.
                    </p>

                </div>

            </div>

        </div>

    </section>


    <!-- CTA -->
    <section class="home-cta">

        <div class="container">

            <div class="home-cta-panel">

                <div>

                    <h2>
                        Your next car is already here.
                    </h2>

                    <p>
                        Explore the fleet and find the right vehicle
                        for your next trip.
                    </p>

                </div>


                <g:link
                    controller="car"
                    action="index"
                    class="home-button home-button-primary">

                    Browse the Fleet
                    <i class="bi bi-arrow-right"></i>

                </g:link>

            </div>

        </div>

    </section>


    <!-- FOOTER -->
    <footer class="home-footer">

        <div class="container">

            <div class="home-footer-row">

                <span>
                    Car Rental Management System
                </span>

                <span>
                    © 2026 Car Rental
                </span>

            </div>

        </div>

    </footer>

</div>

<asset:javascript src="application.js"/>

</body>
</html>
