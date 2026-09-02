<style>
    .app-notification-menu{
        position:relative;
        flex:0 0 auto;
    }

    .app-notification-button{
        position:relative;
        width:44px;
        height:44px;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        padding:0;
        color:#f5a623;
        background:rgba(245,166,35,.07);
        border:1px solid rgba(245,166,35,.25);
        border-radius:12px;
        font-size:1rem;
        cursor:pointer;
        transition:background .16s ease,border-color .16s ease,color .16s ease;
    }

    .app-notification-button:hover,
    .app-notification-button:focus{
        color:#101114;
        background:#f5a623;
        border-color:#f5a623;
        outline:none;
    }

    .app-notification-count{
        position:absolute;
        top:-6px;
        right:-6px;
        min-width:20px;
        height:20px;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        padding:0 5px;
        color:#fff;
        background:#c0392b;
        border:2px solid #111318;
        border-radius:999px;
        font-family:'JetBrains Mono',monospace;
        font-size:.55rem;
        font-weight:700;
    }

    .app-notification-dropdown{
        width:min(390px,calc(100vw - 30px));
        max-height:520px;
        padding:0;
        overflow:hidden;
        background:#fff;
        border:1px solid #dfddd6;
        border-radius:14px;
        box-shadow:0 24px 70px rgba(0,0,0,.27);
    }

    .app-notification-header{
        display:flex;
        align-items:center;
        justify-content:space-between;
        gap:12px;
        padding:15px 17px;
        color:#fff;
        background:linear-gradient(135deg,#101114,#1b1d22);
        border-bottom:2px solid #f5a623;
    }

    .app-notification-header strong{
        font-family:'Space Grotesk',sans-serif;
        font-size:.95rem;
    }

    .app-notification-header span{
        color:#f5a623;
        font-family:'JetBrains Mono',monospace;
        font-size:.65rem;
    }

    .app-notification-list{
        max-height:385px;
        overflow-y:auto;
    }

    .app-notification-item{
        display:grid;
        grid-template-columns:38px minmax(0,1fr);
        gap:11px;
        padding:13px 15px;
        color:#33343a;
        border-bottom:1px solid #eceae4;
        text-decoration:none;
        transition:background .15s ease;
    }

    .app-notification-item:hover{
        color:#101114;
        background:#faf7ef;
    }

    .app-notification-icon{
        width:38px;
        height:38px;
        display:flex;
        align-items:center;
        justify-content:center;
        border-radius:10px;
    }

    .app-notification-item.info .app-notification-icon{
        color:#2560c4;
        background:#eaf1fb;
    }

    .app-notification-item.warning .app-notification-icon{
        color:#9a6700;
        background:#fff2d8;
    }

    .app-notification-item.danger .app-notification-icon{
        color:#b9362b;
        background:#fde9e7;
    }

    .app-notification-item.neutral .app-notification-icon{
        color:#5c5e64;
        background:#efefec;
    }

    .app-notification-title{
        display:block;
        margin-bottom:3px;
        color:#17181c;
        font-size:.8rem;
        font-weight:700;
    }

    .app-notification-message{
        display:block;
        color:#6b6d74;
        font-size:.72rem;
        line-height:1.45;
    }

    .app-notification-date{
        display:block;
        margin-top:5px;
        color:#96989f;
        font-family:'JetBrains Mono',monospace;
        font-size:.57rem;
    }

    .app-notification-empty{
        padding:35px 20px;
        color:#777980;
        text-align:center;
        font-size:.8rem;
    }

    .app-notification-empty i{
        display:block;
        margin-bottom:9px;
        color:#b2b3b8;
        font-size:1.5rem;
    }

    .app-notification-footer{
        display:block;
        padding:12px 15px;
        color:#9a6700;
        background:#faf9f6;
        border-top:1px solid #e8e6df;
        font-size:.73rem;
        font-weight:700;
        text-align:center;
        text-decoration:none;
    }

    .app-notification-footer:hover{
        color:#101114;
        background:#fff3dc;
    }
</style>

<div class="dropdown app-notification-menu">

    <button
        type="button"
        class="app-notification-button"
        data-bs-toggle="dropdown"
        data-bs-auto-close="outside"
        aria-expanded="false"
        aria-label="Notifications">

        <i class="bi bi-bell-fill"></i>

        <g:if test="${notificationCount > 0}">
            <span class="app-notification-count">
                ${notificationCount > 99 ? '99+' : notificationCount}
            </span>
        </g:if>

    </button>


    <div class="dropdown-menu dropdown-menu-end app-notification-dropdown">

        <div class="app-notification-header">
            <strong>Notifications</strong>
            <span>${notificationCount} ACTIVE</span>
        </div>


        <div class="app-notification-list">

            <g:if test="${notificationList}">

                <g:each
                    in="${notificationList.take(5)}"
                    var="notification">

                    <g:link
                        controller="${notification.linkController}"
                        action="${notification.linkAction}"
                        id="${notification.linkId}"
                        class="app-notification-item ${notification.severity}">

                        <span class="app-notification-icon">
                            <i class="bi ${notification.icon}"></i>
                        </span>

                        <span>
                            <span class="app-notification-title">
                                ${notification.title}
                            </span>

                            <span class="app-notification-message">
                                ${notification.message}
                            </span>

                            <span class="app-notification-date">
                                ${notification.dateLabel}
                            </span>
                        </span>

                    </g:link>

                </g:each>

            </g:if><g:else>

                <div class="app-notification-empty">
                    <i class="bi bi-bell-slash"></i>
                    No new messages or active reminders.
                </div>

            </g:else>

        </div>


        <g:link
            controller="notification"
            action="index"
            class="app-notification-footer">

            View all notifications
            <i class="bi bi-arrow-right ms-1"></i>

        </g:link>

    </div>

</div>
