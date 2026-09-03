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
        href="https://fonts.googleapis.com/css2?family=Geist+Mono:wght@400;500;600;700&display=swap"
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

        .hero-car-price-offer{
            display:flex;
            align-items:flex-end;
            gap:10px;
        }

        .hero-car-price-old{
            color:#8d9098;
            font-size:.84rem;
            font-weight:500;
            text-decoration:line-through;
        }

        .hero-car-price-new{
            color:var(--home-gold-light);
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

        .hero-car-badge-offer{
            color:#17120a;
            background:linear-gradient(135deg,#ffd37a,#f5a623);
            border-color:rgba(255,211,122,.8);
            box-shadow:0 10px 30px rgba(245,166,35,.24);
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

        .home-offers-section{
            position:relative;
            background:
                radial-gradient(circle at 15% 0%,rgba(245,166,35,.11),transparent 28%),
                #0a0b0e;
        }

        .coverflow{
            --coverflow-card-width:clamp(250px,31vw,410px);
            position:relative;
            width:100%;
        }

        .coverflow-stage{
            position:relative;
            height:470px;
            overflow:hidden;
            cursor:grab;
            outline:none;
            perspective:1200px;
            touch-action:pan-y;
            user-select:none;
        }

        .coverflow-stage:active{
            cursor:grabbing;
        }

        .coverflow-stage:focus-visible{
            border-radius:18px;
            box-shadow:0 0 0 2px var(--home-gold);
        }

        .coverflow-track{
            position:relative;
            width:100%;
            height:100%;
            transform-style:preserve-3d;
        }

        .coverflow-card{
            position:absolute;
            top:50%;
            left:50%;
            z-index:1;
            width:var(--coverflow-card-width);
            aspect-ratio:1.38/1;
            overflow:hidden;
            border:1px solid rgba(255,255,255,.14);
            border-radius:22px;
            background:#111318;
            box-shadow:0 24px 65px rgba(0,0,0,.48);
            opacity:0;
            transform-origin:center center;
            will-change:transform,opacity;
        }

        .coverflow-card:first-child{
            z-index:200;
            opacity:1;
            transform:translate3d(-50%,-50%,0);
        }

        .coverflow-card.is-active{
            border-color:rgba(245,166,35,.72);
            box-shadow:
                0 34px 95px rgba(0,0,0,.62),
                0 0 0 1px rgba(245,166,35,.15),
                0 0 54px rgba(245,166,35,.13);
        }

        .coverflow-card-link{
            position:absolute;
            inset:0;
            display:block;
            color:#fff;
            text-decoration:none;
        }

        .coverflow-card-link:hover{
            color:#fff;
        }

        .coverflow-image,
        .coverflow-fallback{
            width:100%;
            height:100%;
        }

        .coverflow-image{
            display:block;
            object-fit:cover;
            pointer-events:none;
        }

        .coverflow-fallback{
            display:grid;
            place-items:center;
            color:var(--home-gold);
            font-size:5rem;
            background:
                radial-gradient(circle,rgba(245,166,35,.15),transparent 40%),
                #111318;
        }

        .coverflow-card-link::after{
            content:"";
            position:absolute;
            inset:0;
            background:
                linear-gradient(to top,rgba(4,5,7,.96) 0%,rgba(4,5,7,.25) 52%,transparent 76%),
                linear-gradient(to right,rgba(4,5,7,.22),transparent 55%);
            pointer-events:none;
        }

        .coverflow-badge{
            position:absolute;
            z-index:3;
            top:17px;
            left:17px;
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:7px 11px;
            border:1px solid rgba(255,255,255,.16);
            border-radius:999px;
            color:#8ee2ae;
            background:rgba(14,67,37,.74);
            backdrop-filter:blur(10px);
            font-family:'JetBrains Mono',monospace;
            font-size:.58rem;
            font-weight:700;
            letter-spacing:.08em;
        }

        .coverflow-badge-offer{
            color:#17120a;
            border-color:rgba(255,211,122,.8);
            background:linear-gradient(135deg,#ffd37a,#f5a623);
            box-shadow:0 10px 28px rgba(245,166,35,.25);
        }

        .coverflow-card-content{
            position:absolute;
            z-index:3;
            left:20px;
            right:20px;
            bottom:18px;
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            gap:16px;
        }

        .coverflow-card-name{
            margin:0;
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.18rem;
            font-weight:700;
        }

        .coverflow-card-meta{
            display:block;
            margin-top:5px;
            color:#a2a5ad;
            font-family:'JetBrains Mono',monospace;
            font-size:.6rem;
        }

        .coverflow-card-prices{
            display:flex;
            flex-direction:column;
            align-items:flex-end;
            flex:0 0 auto;
        }

        .coverflow-card-old-price{
            color:#999ca4;
            font-family:'JetBrains Mono',monospace;
            font-size:.65rem;
            text-decoration:line-through;
        }

        .coverflow-card-price{
            color:var(--home-gold-light);
            font-family:'Space Grotesk',sans-serif;
            font-size:1.12rem;
            font-weight:700;
        }

        .coverflow-card-price small{
            color:#a2a5ad;
            font-family:'Inter',sans-serif;
            font-size:.62rem;
            font-weight:500;
        }

        .coverflow-navigation{
            position:absolute;
            z-index:220;
            top:50%;
            left:0;
            right:0;
            display:flex;
            justify-content:space-between;
            padding:0 10px;
            pointer-events:none;
            transform:translateY(-50%);
        }

        .coverflow-nav-button{
            width:46px;
            height:46px;
            display:grid;
            place-items:center;
            border:1px solid rgba(245,166,35,.4);
            border-radius:50%;
            color:var(--home-gold-light);
            background:rgba(8,9,11,.76);
            backdrop-filter:blur(12px);
            box-shadow:0 12px 30px rgba(0,0,0,.35);
            pointer-events:auto;
            transition:.2s ease;
        }

        .coverflow-nav-button:hover,
        .coverflow-nav-button:focus-visible{
            color:#17120a;
            border-color:var(--home-gold);
            background:var(--home-gold);
            outline:none;
        }

        .coverflow-caption{
            min-height:112px;
            display:flex;
            align-items:center;
            justify-content:center;
            gap:26px;
            margin-top:-18px;
            text-align:center;
        }

        .coverflow-caption-main{
            min-width:0;
        }

        .coverflow-caption-label{
            display:block;
            margin-bottom:6px;
            color:var(--home-gold);
            font-family:'JetBrains Mono',monospace;
            font-size:.6rem;
            font-weight:700;
            letter-spacing:.12em;
            text-transform:uppercase;
        }

        .coverflow-caption-title{
            margin:0;
            color:#fff;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.45rem;
            font-weight:700;
        }

        .coverflow-caption-subtitle{
            margin:5px 0 0;
            color:#8f929a;
            font-size:.76rem;
        }

        .coverflow-caption-price{
            color:var(--home-gold-light);
            font-family:'Space Grotesk',sans-serif;
            font-size:1.3rem;
            font-weight:700;
            white-space:nowrap;
        }

        .coverflow-caption-price small{
            color:#7d8089;
            font-family:'Inter',sans-serif;
            font-size:.66rem;
            font-weight:500;
        }

        .coverflow-pagination{
            display:flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            margin-top:8px;
        }

        .coverflow-dot{
            width:7px;
            height:7px;
            padding:0;
            border:0;
            border-radius:50%;
            background:#5d6068;
            transition:width .2s ease,background .2s ease,border-radius .2s ease;
        }

        .coverflow-dot.is-active{
            width:25px;
            border-radius:999px;
            background:var(--home-gold);
        }

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

            .coverflow{
                --coverflow-card-width:clamp(245px,48vw,380px);
            }

            .coverflow-stage{
                height:430px;
            }

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

            .coverflow{
                --coverflow-card-width:min(76vw,330px);
            }

            .coverflow-stage{
                height:355px;
            }

            .coverflow-navigation{
                padding:0 2px;
            }

            .coverflow-nav-button{
                width:40px;
                height:40px;
            }

            .coverflow-card{
                border-radius:18px;
            }

            .coverflow-card-content{
                left:15px;
                right:15px;
                bottom:14px;
            }

            .coverflow-card-name{
                font-size:1rem;
            }

            .coverflow-caption{
                min-height:124px;
                flex-direction:column;
                gap:10px;
                margin-top:-6px;
            }

            .coverflow-caption-title{
                font-size:1.25rem;
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

        .home-hero.home-hero-gallery{
            min-height:720px;
            display:block;
            padding:128px 0 105px;
        }

        .home-hero-compact{
            position:relative;
            z-index:3;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:26px;
            margin-bottom:24px;
            padding-bottom:18px;
            border-bottom:1px solid var(--home-line);
        }

        .home-hero-message{
            min-width:0;
            display:flex;
            align-items:center;
            gap:18px;
        }

        .home-hero-compact .home-eyebrow{
            flex:0 0 auto;
            margin:0;
            white-space:nowrap;
        }

        .home-hero-compact .home-eyebrow::after{
            width:30px;
        }

        .home-hero-compact h1{
            flex:0 0 auto;
            margin:0;
            max-width:none;
            color:var(--home-white);
            font-size:clamp(1.15rem,1.75vw,1.7rem);
            line-height:1.15;
            letter-spacing:-.045em;
            white-space:nowrap;
        }

        .home-hero-compact .home-hero-copy{
            max-width:335px;
            margin:0;
            color:var(--home-muted);
            font-size:.7rem;
            line-height:1.55;
        }

        .home-hero-compact .home-actions{
            flex:0 0 auto;
            flex-wrap:nowrap;
            gap:8px;
        }

        .home-hero-compact .home-button{
            min-height:40px;
            padding:0 15px;
            font-size:.68rem;
        }

        .luxury-gallery-heading{
            position:relative;
            z-index:3;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:20px;
            margin-bottom:12px;
            color:var(--home-white);
        }

        .luxury-gallery-heading span{
            color:var(--home-gold-light);
            font-size:.68rem;
            font-weight:700;
            letter-spacing:.12em;
            text-transform:uppercase;
        }

        .luxury-gallery-heading small{
            color:var(--home-muted);
            font-size:.62rem;
        }

        .luxury-gallery{
            position:relative;
            z-index:3;
            width:100%;
            height:430px;
            display:flex;
            gap:9px;
            overflow:hidden;
        }

        .luxury-gallery-item{
            position:relative;
            min-width:0;
            flex:1 1 0;
            overflow:hidden;
            color:#fff;
            background:var(--home-panel);
            border:1px solid var(--home-line);
            border-radius:0;
            text-decoration:none;
            box-shadow:0 18px 45px rgba(0,0,0,.18);
            isolation:isolate;
            transition:
                flex-grow .48s cubic-bezier(.2,.75,.25,1),
                border-color .25s ease,
                box-shadow .25s ease,
                transform .25s ease;
        }

        .luxury-gallery:hover .luxury-gallery-item{
            flex-grow:1;
        }

        .luxury-gallery .luxury-gallery-item:hover,
        .luxury-gallery .luxury-gallery-item:focus-visible{
            flex-grow:3.8;
            color:#fff;
            border-color:var(--home-gold);
            outline:none;
            box-shadow:6px 6px 0 rgba(49,120,198,.26);
            transform:translateY(-2px);
        }

        .luxury-gallery-image,
        .luxury-gallery-fallback{
            position:absolute;
            inset:0;
            width:100%;
            height:100%;
        }

        .luxury-gallery-image{
            display:block;
            object-fit:cover;
            transform:scale(1.01);
            transition:transform .65s cubic-bezier(.2,.75,.25,1),filter .3s ease;
        }

        .luxury-gallery-item:hover .luxury-gallery-image,
        .luxury-gallery-item:focus-visible .luxury-gallery-image{
            transform:scale(1.075);
        }

        .luxury-gallery-fallback{
            display:grid;
            place-items:center;
            color:var(--home-gold);
            background:
                radial-gradient(circle,rgba(247,220,111,.22),transparent 40%),
                var(--home-panel-2);
            font-size:4.5rem;
        }

        .luxury-gallery-shade{
            position:absolute;
            inset:0;
            z-index:1;
            pointer-events:none;
            background:
                linear-gradient(to top,rgba(8,12,18,.92),rgba(8,12,18,.12) 58%,transparent 78%),
                linear-gradient(to right,rgba(8,12,18,.35),transparent 45%);
        }

        .luxury-gallery-rank{
            position:absolute;
            top:14px;
            left:14px;
            z-index:2;
            min-width:31px;
            height:27px;
            display:grid;
            place-items:center;
            padding:0 7px;
            color:#171717;
            background:var(--home-gold);
            border:1px solid rgba(255,255,255,.45);
            font-size:.61rem;
            font-weight:800;
        }

        .luxury-gallery-details{
            position:absolute;
            z-index:2;
            left:18px;
            right:18px;
            bottom:17px;
            min-width:210px;
            display:flex;
            flex-direction:column;
            align-items:flex-start;
            opacity:0;
            transform:translateY(10px);
            transition:opacity .3s ease .08s,transform .3s ease .08s;
        }

        .luxury-gallery-item:hover .luxury-gallery-details,
        .luxury-gallery-item:focus-visible .luxury-gallery-details{
            opacity:1;
            transform:translateY(0);
        }

        .luxury-gallery-kicker{
            margin-bottom:7px;
            color:var(--home-gold);
            font-size:.59rem;
            font-weight:700;
            letter-spacing:.1em;
            text-transform:uppercase;
        }

        .luxury-gallery-details strong{
            color:#fff;
            font-size:1.18rem;
            line-height:1.15;
            letter-spacing:-.04em;
        }

        .luxury-gallery-meta{
            display:flex;
            align-items:center;
            gap:7px;
            margin-top:7px;
            color:#d9dde4;
            font-size:.67rem;
        }

        .luxury-gallery-empty{
            position:relative;
            z-index:3;
            min-height:330px;
            display:grid;
            place-items:center;
            color:var(--home-muted);
            background:var(--home-panel);
            border:1px dashed var(--home-line);
        }

        @media (max-width:1199px){
            .home-hero-message{
                flex-wrap:wrap;
                gap:10px 16px;
            }

            .home-hero-compact .home-hero-copy{
                max-width:520px;
            }

            .luxury-gallery{
                height:395px;
            }
        }

        @media (max-width:991px){
            .home-hero.home-hero-gallery{
                padding:132px 0 100px;
            }

            .home-hero-compact{
                align-items:flex-start;
                flex-direction:column;
            }

            .home-hero-compact .home-actions{
                width:100%;
            }

            .home-hero-compact .home-button{
                flex:1;
            }

            .luxury-gallery{
                height:360px;
            }

            .luxury-gallery .luxury-gallery-item:hover,
            .luxury-gallery .luxury-gallery-item:focus-visible{
                flex-grow:4.4;
            }
        }

        @media (max-width:640px){
            .home-hero.home-hero-gallery{
                padding:120px 0 92px;
            }

            .home-hero-compact h1{
                width:100%;
                font-size:1.22rem;
                white-space:normal;
            }

            .home-hero-compact .home-hero-copy{
                max-width:none;
            }

            .home-hero-compact .home-actions{
                flex-direction:column;
            }

            .luxury-gallery-heading{
                align-items:flex-start;
                flex-direction:column;
                gap:4px;
            }

            .luxury-gallery{
                height:330px;
                gap:12px;
                overflow-x:auto;
                scroll-snap-type:x mandatory;
                scrollbar-width:none;
            }

            .luxury-gallery::-webkit-scrollbar{
                display:none;
            }

            .luxury-gallery-item,
            .luxury-gallery:hover .luxury-gallery-item,
            .luxury-gallery .luxury-gallery-item:hover,
            .luxury-gallery .luxury-gallery-item:focus-visible{
                min-width:82%;
                flex:0 0 82%;
                scroll-snap-align:start;
                transform:none;
            }

            .luxury-gallery-details{
                opacity:1;
                transform:none;
            }
        }
    </style>

    <asset:stylesheet src="theme-advent.css"/>
</head>

<body>

<div class="home-shell">

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

                    <a
                        href="${createLink(uri:'/')}"
                        class="home-nav-link active"
                        aria-label="Home">

                        <i class="bi bi-house-door"></i>
                        <span>Home</span>
                    </a>

                    <a
                        href="#offers"
                        class="home-nav-link"
                        aria-label="${activeOfferCount ? 'Offers' : 'Top Picks'}">

                        <i class="bi bi-tags"></i>
                        <span>${activeOfferCount ? 'Offers' : 'Top Picks'}</span>
                    </a>

                    <a
                        href="#featured"
                        class="home-nav-link"
                        aria-label="Fleet">

                        <i class="bi bi-car-front"></i>
                        <span>Fleet</span>
                    </a>

                    <a
                        href="#experience"
                        class="home-nav-link"
                        aria-label="How it works">

                        <i class="bi bi-compass"></i>
                        <span>How It Works</span>
                    </a>

                    <g:link
                        controller="car"
                        action="index"
                        class="home-nav-link"
                        aria-label="Browse cars">

                        <i class="bi bi-search"></i>
                        <span>Browse Cars</span>
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


    <section class="home-hero home-hero-gallery">

        <div class="container">

            <div class="home-hero-compact">

                <div class="home-hero-message">

                    <span class="home-eyebrow">
                        Premium Car Rental
                    </span>

                    <h1>
                        Drive luxury. Rent with
                        <span class="gold">confidence.</span>
                    </h1>

                    <p class="home-hero-copy">
                        Explore our highest daily-rate vehicles and choose your next drive.
                    </p>

                </div>


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


            <div class="luxury-gallery-heading">

                <span>
                    Highest Daily Rates
                </span>

                <small>
                    Hover over a vehicle to explore it
                </small>

            </div>


            <g:if test="${highestPriceCars}">

                <div class="luxury-gallery" data-luxury-gallery>

                    <g:each
                        in="${highestPriceCars}"
                        var="premiumCar"
                        status="premiumIndex">

                        <g:link
                            controller="car"
                            action="show"
                            id="${premiumCar.id}"
                            class="luxury-gallery-item"
                            aria-label="View ${premiumCar.brand} ${premiumCar.model}">

                            <g:if test="${premiumCar.carImage}">

                                <img
                                    src="${createLink(
                                            controller:'car',
                                            action:'image',
                                            id:premiumCar.id
                                    )}"
                                    alt="${premiumCar.brand} ${premiumCar.model}"
                                    class="luxury-gallery-image"/>

                            </g:if><g:else>

                                <span class="luxury-gallery-fallback">
                                    <i class="bi bi-car-front-fill"></i>
                                </span>

                            </g:else>


                            <span class="luxury-gallery-shade"></span>


                            <span class="luxury-gallery-rank">
                                <g:formatNumber number="${premiumIndex + 1}" format="00"/>
                            </span>


                            <span class="luxury-gallery-details">

                                <span class="luxury-gallery-kicker">
                                    ${premiumCar.category?.name ?: 'Premium Vehicle'}
                                </span>

                                <strong>
                                    ${premiumCar.brand} ${premiumCar.model}
                                </strong>

                                <span class="luxury-gallery-meta">
                                    ${premiumCar.year}
                                    <span aria-hidden="true">·</span>
                                    ${premiumCar.pricePerDay} / day
                                </span>

                            </span>

                        </g:link>

                    </g:each>

                </div>

            </g:if><g:else>

                <div class="luxury-gallery-empty">
                    No available vehicles right now.
                </div>

            </g:else>

        </div>

    </section>


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
                            <i class="bi bi-tags"></i>
                        </span>

                        <span class="home-stat-value">
                            ${activeOfferCount ?: 0}
                        </span>

                    </div>

                    <div class="home-stat-label">
                        Active offers today
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


    <section
        id="offers"
        class="home-section home-offers-section">

        <div class="container">

            <div class="home-section-header">

                <div>

                    <span class="home-section-label">
                        ${activeOfferCount ? 'Limited-Time Offers' : 'Featured Vehicles'}
                    </span>

                    <h2 class="home-section-title">
                        ${activeOfferCount ? 'More road. Less per day.' : 'Ready for your next drive.'}
                    </h2>

                </div>


                <a
                    href="${createLink(uri:'/login/auth')}"
                    class="home-section-link">

                    Sign in to reserve
                    <i class="bi bi-arrow-right ms-1"></i>

                </a>

            </div>


            <g:if test="${landingCars}">

                <g:set
                    var="coverflowFirstItem"
                    value="${landingCars[0]}"/>

                <g:set
                    var="coverflowFirstCar"
                    value="${coverflowFirstItem.car}"/>

                <g:set
                    var="coverflowFirstOffer"
                    value="${coverflowFirstItem.offer}"/>

                <div
                    class="coverflow"
                    data-coverflow
                    role="region"
                    aria-roledescription="carousel"
                    aria-label="Available rental vehicles">

                    <div
                        class="coverflow-stage"
                        data-coverflow-stage
                        tabindex="0">

                        <div class="coverflow-track">

                            <g:each
                                in="${landingCars}"
                                var="offerItem"
                                status="slideIndex">

                                <g:set
                                    var="offerCar"
                                    value="${offerItem.car}"/>

                                <g:set
                                    var="offer"
                                    value="${offerItem.offer}"/>

                                <article
                                    class="coverflow-card"
                                    data-coverflow-card
                                    data-slide-index="${slideIndex}"
                                    data-title="${offerCar.brand} ${offerCar.model}"
                                    data-year="${offerCar.year}"
                                    data-category="${offerCar.category?.name ?: 'Vehicle'}"
                                    data-price="${offer ? offer.dailyPrice : offerCar.pricePerDay}"
                                    data-offer-name="${offer ? offer.name : ''}"
                                    data-offer-end="${offer ? offer.endDate : ''}"
                                    role="group"
                                    aria-roledescription="slide"
                                    aria-label="${slideIndex + 1} of ${landingCars.size()}">

                                    <a
                                        href="${createLink(uri:'/login/auth')}"
                                        class="coverflow-card-link"
                                        draggable="false">

                                        <g:if test="${offerCar.carImage}">

                                            <img
                                                src="${createLink(
                                                        controller:'car',
                                                        action:'image',
                                                        id:offerCar.id
                                                )}"
                                                alt="${offerCar.brand} ${offerCar.model}"
                                                class="coverflow-image"
                                                draggable="false"/>

                                        </g:if><g:else>

                                            <div class="coverflow-fallback">
                                                <i class="bi bi-car-front-fill"></i>
                                            </div>

                                        </g:else>

                                        <g:if test="${offer}">

                                            <span class="coverflow-badge coverflow-badge-offer">
                                                <i class="bi bi-tag-fill"></i>
                                                SAVE ${offer.percentage}%
                                            </span>

                                        </g:if><g:else>

                                            <span class="coverflow-badge">
                                                <i class="bi bi-check-circle-fill"></i>
                                                AVAILABLE
                                            </span>

                                        </g:else>

                                        <div class="coverflow-card-content">

                                            <div>
                                                <h3 class="coverflow-card-name">
                                                    ${offerCar.brand} ${offerCar.model}
                                                </h3>

                                                <span class="coverflow-card-meta">
                                                    ${offerCar.year}
                                                    ·
                                                    ${offerCar.category?.name ?: 'Vehicle'}
                                                </span>
                                            </div>

                                            <div class="coverflow-card-prices">

                                                <g:if test="${offer}">
                                                    <span class="coverflow-card-old-price">
                                                        ${offer.basePrice}
                                                    </span>
                                                </g:if>

                                                <span class="coverflow-card-price">
                                                    ${offer ? offer.dailyPrice : offerCar.pricePerDay}
                                                    <small>/ day</small>
                                                </span>

                                            </div>

                                        </div>

                                    </a>

                                </article>

                            </g:each>

                        </div>

                        <g:if test="${landingCars.size() > 1}">

                            <div class="coverflow-navigation">

                                <button
                                    type="button"
                                    class="coverflow-nav-button"
                                    data-coverflow-previous
                                    aria-label="Previous vehicle">
                                    <i class="bi bi-chevron-left"></i>
                                </button>

                                <button
                                    type="button"
                                    class="coverflow-nav-button"
                                    data-coverflow-next
                                    aria-label="Next vehicle">
                                    <i class="bi bi-chevron-right"></i>
                                </button>

                            </div>

                        </g:if>

                    </div>

                    <div class="coverflow-caption" aria-live="polite">

                        <div class="coverflow-caption-main">

                            <span
                                class="coverflow-caption-label"
                                data-coverflow-caption-label>
                                ${coverflowFirstOffer ? coverflowFirstOffer.name : 'Available now'}
                            </span>

                            <h3
                                class="coverflow-caption-title"
                                data-coverflow-caption-title>
                                ${coverflowFirstCar.brand} ${coverflowFirstCar.model}
                            </h3>

                            <p
                                class="coverflow-caption-subtitle"
                                data-coverflow-caption-subtitle>
                                ${coverflowFirstCar.year}
                                ·
                                ${coverflowFirstCar.category?.name ?: 'Vehicle'}
                                <g:if test="${coverflowFirstOffer}">
                                    · Ends ${coverflowFirstOffer.endDate}
                                </g:if>
                            </p>

                        </div>

                        <div class="coverflow-caption-price">
                            <span data-coverflow-caption-price>
                                ${coverflowFirstOffer ? coverflowFirstOffer.dailyPrice : coverflowFirstCar.pricePerDay}
                            </span>
                            <small>/ day</small>
                        </div>

                    </div>

                    <g:if test="${landingCars.size() > 1}">

                        <div class="coverflow-pagination" aria-label="Choose vehicle">

                            <g:each
                                in="${landingCars}"
                                var="paginationItem"
                                status="paginationIndex">

                                <button
                                    type="button"
                                    class="coverflow-dot ${paginationIndex == 0 ? 'is-active' : ''}"
                                    data-coverflow-dot
                                    data-slide-index="${paginationIndex}"
                                    aria-label="Go to vehicle ${paginationIndex + 1}"
                                    aria-current="${paginationIndex == 0 ? 'true' : 'false'}">
                                </button>

                            </g:each>

                        </div>

                    </g:if>

                </div>

            </g:if><g:else>

                <div class="featured-empty">
                    No available vehicles right now.
                </div>

            </g:else>

        </div>

    </section>


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


    <footer class="home-footer home-cinematic-footer">

        <div class="home-footer-grid"></div>

        <div class="home-footer-glow"></div>

        <div class="home-footer-marquee" aria-hidden="true">
            <div>
                PREMIUM MOBILITY <span>✦</span> DRIVE WITH CONFIDENCE <span>✦</span> YOUR NEXT JOURNEY STARTS HERE <span>✦</span>
                PREMIUM MOBILITY <span>✦</span> DRIVE WITH CONFIDENCE <span>✦</span> YOUR NEXT JOURNEY STARTS HERE <span>✦</span>
            </div>
        </div>

        <div class="home-footer-word" aria-hidden="true">
            DRIVE
        </div>

        <div class="container home-footer-content">

            <div class="home-footer-main">

                <span class="home-footer-kicker">
                    CAR RENTAL MANAGEMENT
                </span>

                <h2>
                    Ready for your next <span>drive?</span>
                </h2>

                <p>
                    Choose your car, reserve your dates and start your journey with confidence.
                </p>

                <div class="home-footer-actions">

                    <g:link
                        controller="car"
                        action="index"
                        class="home-footer-action home-footer-action-primary">

                        <i class="bi bi-car-front-fill"></i>
                        Browse Fleet

                    </g:link>

                    <a
                        href="${createLink(uri:'/login/auth')}"
                        class="home-footer-action">

                        <i class="bi bi-person"></i>
                        Sign In

                    </a>

                </div>

            </div>

            <div class="home-footer-bottom">

                <div class="home-footer-brand">

                    <span class="home-footer-logo">
                        <i class="bi bi-car-front-fill"></i>
                    </span>

                    <span>
                        <strong>Car Rental</strong>
                        <small>Premium Mobility</small>
                    </span>

                </div>

                <div class="home-footer-links">
                    <a href="#offers">Offers</a>
                    <a href="#featured">Fleet</a>
                    <a href="#experience">How It Works</a>
                </div>

                <button
                    type="button"
                    class="home-footer-top-button"
                    data-home-scroll-top
                    aria-label="Back to top">

                    <i class="bi bi-arrow-up"></i>

                </button>

            </div>

            <div class="home-footer-legal">
                © 2026 Car Rental Management System
            </div>

        </div>

    </footer>

</div>

<asset:javascript src="application.js"/>

<script>
    document.querySelectorAll('[data-home-scroll-top]').forEach((button) => {
        button.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    });

    (() => {
        document.querySelectorAll('[data-coverflow]').forEach((root) => {
            const stage = root.querySelector('[data-coverflow-stage]');
            const cards = Array.from(root.querySelectorAll('[data-coverflow-card]'));
            const dots = Array.from(root.querySelectorAll('[data-coverflow-dot]'));
            const previousButton = root.querySelector('[data-coverflow-previous]');
            const nextButton = root.querySelector('[data-coverflow-next]');
            const captionLabel = root.querySelector('[data-coverflow-caption-label]');
            const captionTitle = root.querySelector('[data-coverflow-caption-title]');
            const captionSubtitle = root.querySelector('[data-coverflow-caption-subtitle]');
            const captionPrice = root.querySelector('[data-coverflow-caption-price]');
            const count = cards.length;

            if (!stage || !count) {
                return;
            }

            const loop = count > 2;
            const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
            let position = 0;
            let target = 0;
            let selectedIndex = 0;
            let cardWidth = 0;
            let animationFrame = null;
            let drag = null;
            let suppressClickUntil = 0;

            const indexAt = (value) => {
                if (!loop) {
                    return Math.max(0, Math.min(count - 1, Math.round(value)));
                }

                return ((Math.round(value) % count) + count) % count;
            };

            const clampPosition = (value) => {
                if (loop) {
                    return value;
                }

                return Math.max(0, Math.min(count - 1, value));
            };

            const updateCaption = (index) => {
                const card = cards[index];

                if (!card) {
                    return;
                }

                const offerName = card.dataset.offerName || '';
                const offerEnd = card.dataset.offerEnd || '';
                const details = [card.dataset.year, card.dataset.category]
                    .filter(Boolean);

                if (offerEnd) {
                    details.push('Ends ' + offerEnd);
                }

                if (captionLabel) {
                    captionLabel.textContent = offerName || 'Available now';
                }

                if (captionTitle) {
                    captionTitle.textContent = card.dataset.title || '';
                }

                if (captionSubtitle) {
                    captionSubtitle.textContent = details.join(' · ');
                }

                if (captionPrice) {
                    captionPrice.textContent = card.dataset.price || '';
                }
            };

            const select = (index) => {
                if (selectedIndex === index && cards[index].classList.contains('is-active')) {
                    return;
                }

                selectedIndex = index;

                cards.forEach((card, cardIndex) => {
                    const active = cardIndex === index;
                    const link = card.querySelector('.coverflow-card-link');
                    card.classList.toggle('is-active', active);
                    card.setAttribute('aria-current', active ? 'true' : 'false');

                    if (link) {
                        link.tabIndex = active ? 0 : -1;
                    }
                });

                dots.forEach((dot, dotIndex) => {
                    const active = dotIndex === index;
                    dot.classList.toggle('is-active', active);
                    dot.setAttribute('aria-current', active ? 'true' : 'false');
                });

                updateCaption(index);
            };

            const paint = () => {
                if (!cardWidth) {
                    return;
                }

                const pitch = cardWidth * 0.62;

                cards.forEach((card, index) => {
                    let offset = index - position;

                    if (loop) {
                        offset = ((offset % count) + count) % count;

                        if (offset > count / 2) {
                            offset -= count;
                        }
                    }

                    const distance = Math.abs(offset);
                    const ramp = Math.pow(distance, 0.62);
                    const tilt = Math.min(48 * ramp, 78) * Math.sign(offset);
                    const translateX = offset * pitch;
                    const translateZ = -cardWidth * 0.56 * ramp;
                    const edge = loop
                        ? Math.min(1, Math.max(0, (count / 2 - distance) * 2))
                        : 1;
                    const opacity = Math.max(0, 1 - 0.17 * distance) * edge;

                    card.style.transform =
                        'translate3d(calc(-50% + ' + translateX +
                        'px), -50%, ' + translateZ +
                        'px) rotateY(' + (-tilt) + 'deg)';
                    card.style.opacity = String(opacity);
                    card.style.zIndex = String(200 - Math.round(distance * 10));
                    card.style.visibility = opacity < 0.01 ? 'hidden' : 'visible';
                    card.style.pointerEvents = distance <= 2 ? 'auto' : 'none';
                    card.setAttribute('aria-hidden', distance < 0.5 ? 'false' : 'true');
                });

                select(indexAt(position));
            };

            const settle = (nextTarget) => {
                if (animationFrame !== null) {
                    cancelAnimationFrame(animationFrame);
                }

                target = clampPosition(nextTarget);

                if (reducedMotion) {
                    position = target;
                    paint();
                    animationFrame = null;
                    return;
                }

                const step = () => {
                    const remaining = target - position;

                    if (Math.abs(remaining) < 0.0004) {
                        position = target;
                        paint();
                        animationFrame = null;
                        return;
                    }

                    position += remaining * 0.16;
                    paint();
                    animationFrame = requestAnimationFrame(step);
                };

                animationFrame = requestAnimationFrame(step);
            };

            const goTo = (index) => {
                const nextTarget = loop
                    ? index + Math.round((target - index) / count) * count
                    : index;

                settle(nextTarget);
            };

            const nudge = (amount) => {
                settle(Math.round(target) + amount);
            };

            stage.addEventListener('pointerdown', (event) => {
                if (event.target.closest('[data-coverflow-previous], [data-coverflow-next]')) {
                    return;
                }

                if (animationFrame !== null) {
                    cancelAnimationFrame(animationFrame);
                    animationFrame = null;
                }

                stage.setPointerCapture(event.pointerId);
                target = position;
                drag = {
                    id: event.pointerId,
                    startX: event.clientX,
                    startPosition: position,
                    previousPosition: position,
                    previousTime: performance.now(),
                    velocity: 0,
                    moved: false
                };
            });

            stage.addEventListener('pointermove', (event) => {
                if (!drag || drag.id !== event.pointerId || !cardWidth) {
                    return;
                }

                const pitch = cardWidth * 0.62;
                const now = performance.now();
                const nextPosition = clampPosition(
                    drag.startPosition - (event.clientX - drag.startX) / pitch
                );

                drag.moved = drag.moved || Math.abs(event.clientX - drag.startX) > 5;
                drag.velocity =
                    ((nextPosition - drag.previousPosition) /
                    Math.max(now - drag.previousTime, 1)) * 1000;
                drag.previousPosition = nextPosition;
                drag.previousTime = now;
                position = nextPosition;
                target = nextPosition;
                paint();
            });

            const finishDrag = (event) => {
                if (!drag || drag.id !== event.pointerId) {
                    return;
                }

                const carried = Math.max(-2, Math.min(2, drag.velocity * 0.16));

                if (drag.moved) {
                    suppressClickUntil = Date.now() + 300;
                }

                drag = null;
                settle(Math.round(position + carried));
            };

            stage.addEventListener('pointerup', finishDrag);
            stage.addEventListener('pointercancel', finishDrag);

            stage.addEventListener('click', (event) => {
                if (Date.now() < suppressClickUntil) {
                    event.preventDefault();
                    event.stopPropagation();
                    return;
                }

                const card = event.target.closest('[data-coverflow-card]');

                if (!card) {
                    return;
                }

                const cardIndex = Number(card.dataset.slideIndex);

                if (cardIndex !== selectedIndex) {
                    event.preventDefault();
                    goTo(cardIndex);
                }
            });

            stage.addEventListener('keydown', (event) => {
                if (event.key === 'ArrowLeft') {
                    event.preventDefault();
                    nudge(-1);
                }

                if (event.key === 'ArrowRight') {
                    event.preventDefault();
                    nudge(1);
                }
            });

            previousButton?.addEventListener('click', () => nudge(-1));
            nextButton?.addEventListener('click', () => nudge(1));

            dots.forEach((dot) => {
                dot.addEventListener('click', () => {
                    goTo(Number(dot.dataset.slideIndex));
                });
            });

            const measure = () => {
                cardWidth = cards[0].getBoundingClientRect().width;
                paint();
            };

            measure();

            if ('ResizeObserver' in window) {
                const observer = new ResizeObserver(measure);
                observer.observe(stage);
            } else {
                window.addEventListener('resize', measure);
            }
        });
    })();
</script>

</body>
</html>
