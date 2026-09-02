<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Rental Messages</title>

    <style>
        .conversation-page{
            width:min(1050px,calc(100% - 30px));
            margin:42px auto 70px;
        }

        .conversation-header{
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            gap:20px;
            margin-bottom:24px;
        }

        .conversation-kicker{
            display:block;
            margin-bottom:7px;
            color:#a56c00;
            font-family:'JetBrains Mono',monospace;
            font-size:.67rem;
            font-weight:700;
            letter-spacing:.12em;
            text-transform:uppercase;
        }

        .conversation-title{
            margin:0;
            color:#15161a;
            font-family:'Space Grotesk',sans-serif;
            font-size:clamp(1.8rem,4vw,2.7rem);
            font-weight:700;
        }

        .conversation-subtitle{
            max-width:620px;
            margin:8px 0 0;
            color:#74767d;
            font-size:.84rem;
            line-height:1.55;
        }

        .conversation-count{
            flex:0 0 auto;
            padding:9px 13px;
            color:#75510a;
            background:#fff3d7;
            border:1px solid #efd298;
            border-radius:999px;
            font-family:'JetBrains Mono',monospace;
            font-size:.65rem;
            font-weight:700;
        }

        .conversation-list{
            display:grid;
            gap:13px;
        }

        .conversation-card-wrap{
            display:grid;
            grid-template-columns:minmax(0,1fr) auto;
            align-items:stretch;
            gap:8px;
        }

        .conversation-card{
            display:grid;
            grid-template-columns:58px minmax(0,1fr) auto;
            align-items:center;
            gap:16px;
            padding:18px;
            color:#303137;
            background:#fff;
            border:1px solid #e2e0da;
            border-radius:16px;
            box-shadow:0 10px 30px rgba(22,23,27,.07);
            text-decoration:none;
            transition:transform .16s ease,border-color .16s ease,box-shadow .16s ease;
        }

        .conversation-card:hover{
            color:#17181c;
            border-color:#e5bd6b;
            transform:translateY(-2px);
            box-shadow:0 15px 38px rgba(22,23,27,.11);
        }

        .conversation-car-icon{
            width:58px;
            height:58px;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#f5a623;
            background:#17181c;
            border-radius:15px;
            font-size:1.3rem;
        }

        .conversation-card-top{
            display:flex;
            align-items:center;
            flex-wrap:wrap;
            gap:9px;
            margin-bottom:6px;
        }

        .conversation-car{
            color:#17181c;
            font-family:'Space Grotesk',sans-serif;
            font-size:1rem;
            font-weight:700;
        }

        .conversation-rental-id{
            color:#9a9ca2;
            font-family:'JetBrains Mono',monospace;
            font-size:.61rem;
        }

        .conversation-status{
            padding:4px 7px;
            border-radius:999px;
            font-family:'JetBrains Mono',monospace;
            font-size:.57rem;
            font-weight:700;
            letter-spacing:.04em;
        }

        .conversation-status.confirmed{
            color:#1f5ea8;
            background:#e8f1fb;
        }

        .conversation-status.picked_up{
            color:#8a5c00;
            background:#fff0cc;
        }

        .conversation-status.completed{
            color:#27704a;
            background:#e5f5ec;
        }

        .conversation-status.cancelled{
            color:#a6372e;
            background:#fbe9e7;
        }

        .conversation-person{
            display:block;
            margin-bottom:5px;
            color:#5d6067;
            font-size:.76rem;
        }

        .conversation-preview{
            display:block;
            overflow:hidden;
            color:#83858c;
            font-size:.76rem;
            text-overflow:ellipsis;
            white-space:nowrap;
        }

        .conversation-preview strong{
            color:#4a4c52;
        }

        .conversation-stats{
            display:flex;
            align-items:flex-end;
            flex-direction:column;
            gap:8px;
            min-width:118px;
        }

        .conversation-stat-row{
            display:flex;
            align-items:center;
            gap:12px;
            color:#81838a;
            font-family:'JetBrains Mono',monospace;
            font-size:.62rem;
        }

        .conversation-open{
            display:inline-flex;
            align-items:center;
            gap:7px;
            color:#986400;
            font-size:.72rem;
            font-weight:700;
        }

        .conversation-remove-form{
            margin:0;
        }

        .conversation-remove-button{
            width:48px;
            height:100%;
            min-height:72px;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#b63a30;
            background:#fff;
            border:1px solid #ecc5c1;
            border-radius:14px;
            font-size:.92rem;
            transition:color .16s ease,background .16s ease,border-color .16s ease;
        }

        .conversation-remove-button:hover{
            color:#fff;
            background:#b83b31;
            border-color:#b83b31;
        }

        .conversation-empty{
            padding:70px 25px;
            color:#777980;
            background:#fff;
            border:1px dashed #d5d2c9;
            border-radius:18px;
            text-align:center;
        }

        .conversation-empty i{
            display:block;
            margin-bottom:14px;
            color:#c29a48;
            font-size:2.4rem;
        }

        .conversation-empty strong{
            display:block;
            margin-bottom:6px;
            color:#292a2f;
            font-family:'Space Grotesk',sans-serif;
        }

        @media (max-width:700px){
            .conversation-page{
                margin-top:28px;
            }

            .conversation-header{
                align-items:flex-start;
                flex-direction:column;
                gap:12px;
            }

            .conversation-card{
                grid-template-columns:48px minmax(0,1fr);
                gap:12px;
                padding:15px;
            }

            .conversation-car-icon{
                width:48px;
                height:48px;
            }

            .conversation-stats{
                grid-column:2;
                align-items:flex-start;
                min-width:0;
            }
        }
    </style>
</head>
<body>

<main class="conversation-page">
    <header class="conversation-header">
        <div>
            <span class="conversation-kicker">Protected rental records</span>
            <h1 class="conversation-title">Messages & Vehicle Photos</h1>
            <p class="conversation-subtitle">
                Every conversation is attached to one rental. Photos keep the sender,
                upload time and a digital fingerprint.
            </p>
        </div>

        <span class="conversation-count">
            ${conversationList.size()} CONVERSATIONS
        </span>
    </header>

    <g:if test="${flash.message}">
        <div class="alert alert-info">
            ${flash.message}
        </div>
    </g:if>

    <g:if test="${conversationList}">
        <section class="conversation-list">
            <g:each in="${conversationList}" var="conversation">
                <div class="conversation-card-wrap">
                    <g:link
                        controller="rentalChat"
                        action="show"
                        id="${conversation.rental.id}"
                        class="conversation-card">

                        <span class="conversation-car-icon">
                            <i class="bi bi-chat-square-text-fill"></i>
                        </span>

                        <span>
                            <span class="conversation-card-top">
                                <span class="conversation-car">
                                    ${conversation.rental.car.brand}
                                    ${conversation.rental.car.model}
                                </span>

                                <span class="conversation-rental-id">
                                    RENTAL #${conversation.rental.id}
                                </span>

                                <span class="conversation-status ${conversation.rental.status.toLowerCase()}">
                                    ${conversation.rental.status.replace('_', ' ')}
                                </span>
                            </span>

                            <span class="conversation-person">
                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    Customer:
                                    ${conversation.rental.customer.fullName ?: conversation.rental.customer.username}
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_CUSTOMER">
                                    Rental office conversation
                                </sec:ifAllGranted>
                            </span>

                            <span class="conversation-preview">
                                <g:if test="${conversation.lastMessage}">
                                    <strong>
                                        ${conversation.lastMessage.sender.fullName ?: conversation.lastMessage.sender.username}:
                                    </strong>
                                    ${conversation.lastMessage.body ?: 'Vehicle photo evidence'}
                                </g:if><g:else>
                                    No messages yet. Open the conversation to begin.
                                </g:else>
                            </span>
                        </span>

                        <span class="conversation-stats">
                            <span class="conversation-stat-row">
                                <span>
                                    <i class="bi bi-chat-left-text me-1"></i>
                                    ${conversation.messageCount}
                                </span>
                                <span>
                                    <i class="bi bi-images me-1"></i>
                                    ${conversation.photoCount}
                                </span>
                            </span>

                            <span class="conversation-open">
                                Open conversation
                                <i class="bi bi-arrow-right"></i>
                            </span>
                        </span>
                    </g:link>

                    <g:if test="${conversation.rental.status in ['COMPLETED', 'CANCELLED']}">
                        <g:form
                            controller="rentalChat"
                            action="archive"
                            id="${conversation.rental.id}"
                            method="POST"
                            class="conversation-remove-form">

                            <button
                                type="submit"
                                class="conversation-remove-button"
                                title="Remove old conversation"
                                aria-label="Remove old conversation"
                                onclick="return confirm('Remove this old conversation from your list? Messages and evidence photos will remain securely stored.');">
                                <i class="bi bi-trash3"></i>
                            </button>
                        </g:form>
                    </g:if>
                </div>
            </g:each>
        </section>
    </g:if><g:else>
        <section class="conversation-empty">
            <i class="bi bi-chat-square-dots"></i>
            <strong>No confirmed rental conversations yet</strong>
            <span>A conversation appears after a booking is confirmed.</span>
        </section>
    </g:else>
</main>

</body>
</html>
