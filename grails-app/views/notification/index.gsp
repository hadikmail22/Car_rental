<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Notifications</title>

    <style>
        .notification-page{
            width:min(920px,calc(100% - 30px));
            margin:46px auto 70px;
        }

        .notification-page-header{
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            gap:20px;
            margin-bottom:22px;
        }

        .notification-page-kicker{
            display:block;
            margin-bottom:7px;
            color:#a56c00;
            font-family:'JetBrains Mono',monospace;
            font-size:.68rem;
            font-weight:700;
            letter-spacing:.12em;
            text-transform:uppercase;
        }

        .notification-page-title{
            margin:0;
            color:#15161a;
            font-family:'Space Grotesk',sans-serif;
            font-size:clamp(1.75rem,4vw,2.6rem);
            font-weight:700;
        }

        .notification-page-count{
            flex:0 0 auto;
            padding:9px 13px;
            color:#72500e;
            background:#fff4dc;
            border:1px solid #f0d39a;
            border-radius:999px;
            font-family:'JetBrains Mono',monospace;
            font-size:.67rem;
            font-weight:700;
        }

        .notification-page-list{
            display:grid;
            gap:12px;
        }

        .notification-card{
            display:grid;
            grid-template-columns:50px minmax(0,1fr) auto;
            align-items:center;
            gap:16px;
            padding:18px;
            color:#33343a;
            background:#fff;
            border:1px solid #e2e0da;
            border-left:4px solid #a9abb1;
            border-radius:15px;
            box-shadow:0 9px 28px rgba(24,25,29,.07);
            text-decoration:none;
            transition:transform .16s ease,border-color .16s ease,box-shadow .16s ease;
        }

        .notification-card:hover{
            color:#17181c;
            transform:translateY(-2px);
            box-shadow:0 14px 34px rgba(24,25,29,.11);
        }

        .notification-card.info{
            border-left-color:#3973cf;
        }

        .notification-card.warning{
            border-left-color:#e0a321;
        }

        .notification-card.danger{
            border-left-color:#c84337;
        }

        .notification-card.neutral{
            border-left-color:#777a82;
        }

        .notification-card-icon{
            width:50px;
            height:50px;
            display:flex;
            align-items:center;
            justify-content:center;
            border-radius:13px;
            font-size:1.1rem;
        }

        .notification-card.info .notification-card-icon{
            color:#2560c4;
            background:#eaf1fb;
        }

        .notification-card.warning .notification-card-icon{
            color:#946000;
            background:#fff2d8;
        }

        .notification-card.danger .notification-card-icon{
            color:#b9362b;
            background:#fde9e7;
        }

        .notification-card.neutral .notification-card-icon{
            color:#5c5e64;
            background:#efefec;
        }

        .notification-card-title{
            display:block;
            margin-bottom:5px;
            color:#17181c;
            font-family:'Space Grotesk',sans-serif;
            font-size:1rem;
            font-weight:700;
        }

        .notification-card-message{
            display:block;
            color:#676970;
            font-size:.84rem;
            line-height:1.55;
        }

        .notification-card-date{
            display:inline-flex;
            align-items:center;
            gap:7px;
            white-space:nowrap;
            color:#8a8c93;
            font-family:'JetBrains Mono',monospace;
            font-size:.65rem;
        }

        .notification-empty-state{
            padding:68px 25px;
            color:#777980;
            background:#fff;
            border:1px dashed #d4d1c8;
            border-radius:18px;
            text-align:center;
        }

        .notification-empty-state i{
            display:block;
            margin-bottom:14px;
            color:#c0a15f;
            font-size:2.25rem;
        }

        .notification-empty-state strong{
            display:block;
            margin-bottom:5px;
            color:#292a2f;
            font-family:'Space Grotesk',sans-serif;
            font-size:1rem;
        }

        @media (max-width:700px){
            .notification-page{
                margin-top:30px;
            }

            .notification-page-header{
                align-items:flex-start;
                flex-direction:column;
                gap:12px;
            }

            .notification-card{
                grid-template-columns:44px minmax(0,1fr);
                gap:12px;
                padding:15px;
            }

            .notification-card-icon{
                width:44px;
                height:44px;
            }

            .notification-card-date{
                grid-column:2;
            }
        }
    </style>
</head>
<body>

<main class="notification-page">
    <header class="notification-page-header">
        <div>
            <span class="notification-page-kicker">Rental reminders</span>
            <h1 class="notification-page-title">Notifications</h1>
        </div>

        <span class="notification-page-count">
            ${notificationCount} ACTIVE
        </span>
    </header>

    <g:if test="${notificationList}">
        <section class="notification-page-list">
            <g:each in="${notificationList}" var="notification">
                <g:link
                    controller="${notification.linkController}"
                    action="${notification.linkAction}"
                    id="${notification.linkId}"
                    class="notification-card ${notification.severity}">

                    <span class="notification-card-icon">
                        <i class="bi ${notification.icon}"></i>
                    </span>

                    <span>
                        <span class="notification-card-title">
                            ${notification.title}
                        </span>

                        <span class="notification-card-message">
                            ${notification.message}
                        </span>
                    </span>

                    <span class="notification-card-date">
                        <i class="bi bi-calendar3"></i>
                        ${notification.dateLabel}
                    </span>
                </g:link>
            </g:each>
        </section>
    </g:if><g:else>
        <section class="notification-empty-state">
            <i class="bi bi-bell-slash"></i>
            <strong>No active notifications</strong>
            <span>New messages and rental reminders will appear here.</span>
        </section>
    </g:else>
</main>

</body>
</html>
