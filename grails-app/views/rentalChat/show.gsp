<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Rental #${rental.id} Conversation</title>

    <style>
        .rental-chat-page{
            width:min(1080px,calc(100% - 24px));
            margin:30px auto 65px;
        }

        .rental-chat-back{
            display:inline-flex;
            align-items:center;
            gap:7px;
            margin-bottom:13px;
            color:#8d600a;
            font-size:.76rem;
            font-weight:700;
            text-decoration:none;
        }

        .rental-chat-back:hover{
            color:#17181c;
        }

        .rental-chat-shell{
            overflow:hidden;
            background:#fff;
            border:1px solid #dedcd5;
            border-radius:20px;
            box-shadow:0 18px 55px rgba(20,21,25,.11);
        }

        .rental-chat-header{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:20px;
            padding:19px 22px;
            color:#fff;
            background:linear-gradient(135deg,#101114,#1c1e23);
            border-bottom:2px solid #f5a623;
        }

        .rental-chat-car{
            display:flex;
            align-items:center;
            gap:13px;
        }

        .rental-chat-car-icon{
            width:48px;
            height:48px;
            display:flex;
            align-items:center;
            justify-content:center;
            flex:0 0 auto;
            color:#101114;
            background:#f5a623;
            border-radius:13px;
            font-size:1.15rem;
        }

        .rental-chat-car strong{
            display:block;
            font-family:'Space Grotesk',sans-serif;
            font-size:1.05rem;
        }

        .rental-chat-car span{
            display:block;
            margin-top:3px;
            color:#bcbec3;
            font-family:'JetBrains Mono',monospace;
            font-size:.62rem;
        }

        .rental-chat-status{
            display:flex;
            align-items:flex-end;
            flex-direction:column;
            gap:6px;
        }

        .rental-chat-status-badge{
            padding:5px 8px;
            color:#f5a623;
            background:rgba(245,166,35,.1);
            border:1px solid rgba(245,166,35,.25);
            border-radius:999px;
            font-family:'JetBrains Mono',monospace;
            font-size:.59rem;
            font-weight:700;
        }

        .rental-chat-dates{
            color:#aeb0b6;
            font-family:'JetBrains Mono',monospace;
            font-size:.59rem;
        }

        .rental-chat-evidence-note{
            display:flex;
            align-items:flex-start;
            gap:10px;
            padding:12px 18px;
            color:#695329;
            background:#fff7e7;
            border-bottom:1px solid #ecd8ad;
            font-size:.74rem;
            line-height:1.5;
        }

        .rental-chat-evidence-note i{
            margin-top:2px;
            color:#bd7a00;
        }

        .rental-chat-messages{
            min-height:360px;
            max-height:620px;
            overflow-y:auto;
            padding:24px;
            background:
                radial-gradient(circle at 10% 0%,rgba(245,166,35,.06),transparent 25%),
                #f6f5f2;
            scroll-behavior:smooth;
        }

        .chat-message{
            display:flex;
            align-items:flex-end;
            gap:9px;
            margin-bottom:18px;
        }

        .chat-message.mine{
            justify-content:flex-end;
        }

        .chat-avatar{
            width:32px;
            height:32px;
            display:flex;
            align-items:center;
            justify-content:center;
            flex:0 0 auto;
            color:#fff;
            background:#74777f;
            border-radius:50%;
            font-size:.78rem;
        }

        .chat-message.mine .chat-avatar{
            order:2;
            color:#17181c;
            background:#f5a623;
        }

        .chat-bubble{
            width:min(590px,78%);
            padding:12px 13px 9px;
            color:#33343a;
            background:#fff;
            border:1px solid #dfddd6;
            border-radius:15px 15px 15px 4px;
            box-shadow:0 6px 18px rgba(20,21,25,.06);
        }

        .chat-message.mine .chat-bubble{
            color:#f4f4f2;
            background:#191b20;
            border-color:#282b31;
            border-radius:15px 15px 4px 15px;
        }

        .chat-bubble-head{
            display:flex;
            align-items:center;
            justify-content:space-between;
            flex-wrap:wrap;
            gap:8px;
            margin-bottom:7px;
        }

        .chat-sender{
            color:#805600;
            font-size:.69rem;
            font-weight:700;
        }

        .chat-message.mine .chat-sender{
            color:#f5a623;
        }

        .chat-time{
            color:#9a9ca2;
            font-family:'JetBrains Mono',monospace;
            font-size:.55rem;
        }

        .chat-message-type{
            display:inline-flex;
            align-items:center;
            gap:5px;
            margin-bottom:8px;
            padding:4px 7px;
            color:#885a00;
            background:#fff0cc;
            border-radius:999px;
            font-family:'JetBrains Mono',monospace;
            font-size:.54rem;
            font-weight:700;
        }

        .chat-message.mine .chat-message-type{
            color:#ffd681;
            background:rgba(245,166,35,.13);
        }

        .chat-message-body{
            color:inherit;
            font-size:.81rem;
            line-height:1.58;
            overflow-wrap:anywhere;
            white-space:pre-wrap;
        }

        .chat-photo-grid{
            display:grid;
            grid-template-columns:repeat(2,minmax(0,1fr));
            gap:7px;
            margin-top:10px;
        }

        .chat-photo{
            overflow:hidden;
            position:relative;
            aspect-ratio:4/3;
            background:#0f1013;
            border-radius:10px;
        }

        .chat-photo img{
            width:100%;
            height:100%;
            display:block;
            object-fit:cover;
            transition:transform .2s ease;
        }

        .chat-photo:hover img{
            transform:scale(1.035);
        }

        .chat-photo-lock{
            position:absolute;
            top:7px;
            right:7px;
            width:25px;
            height:25px;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#17181c;
            background:rgba(245,166,35,.92);
            border-radius:7px;
            font-size:.64rem;
        }

        .chat-photo-proof{
            margin-top:7px;
            color:#999ba1;
            font-family:'JetBrains Mono',monospace;
            font-size:.5rem;
            overflow-wrap:anywhere;
        }

        .chat-empty{
            display:flex;
            align-items:center;
            justify-content:center;
            flex-direction:column;
            min-height:310px;
            color:#84868c;
            text-align:center;
        }

        .chat-empty i{
            margin-bottom:12px;
            color:#c19a4a;
            font-size:2.2rem;
        }

        .chat-empty strong{
            margin-bottom:5px;
            color:#33343a;
            font-family:'Space Grotesk',sans-serif;
        }

        .rental-chat-composer{
            padding:18px;
            background:#fff;
            border-top:1px solid #dfddd6;
        }

        .chat-composer-top{
            display:grid;
            grid-template-columns:220px minmax(0,1fr);
            gap:11px;
            margin-bottom:11px;
        }

        .chat-field-label{
            display:block;
            margin-bottom:6px;
            color:#6d6f75;
            font-family:'JetBrains Mono',monospace;
            font-size:.6rem;
            font-weight:700;
            letter-spacing:.06em;
            text-transform:uppercase;
        }

        .chat-select,
        .chat-textarea{
            width:100%;
            color:#303137;
            background:#f8f7f4;
            border:1px solid #dcd9d1;
            border-radius:11px;
            font-size:.78rem;
        }

        .chat-select{
            height:46px;
            padding:0 11px;
        }

        .chat-textarea{
            min-height:82px;
            padding:11px 12px;
            resize:vertical;
        }

        .chat-select:focus,
        .chat-textarea:focus{
            outline:none;
            border-color:#d99a21;
            box-shadow:0 0 0 3px rgba(245,166,35,.12);
        }

        .chat-upload-row{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
        }

        .chat-photo-input{
            flex:1;
            min-width:0;
            padding:9px;
            color:#676970;
            background:#f8f7f4;
            border:1px dashed #d2ad66;
            border-radius:11px;
            font-size:.71rem;
        }

        .chat-send-button{
            height:44px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            flex:0 0 auto;
            padding:0 18px;
            color:#17181c;
            background:#f5a623;
            border:1px solid #e29a13;
            border-radius:11px;
            font-size:.76rem;
            font-weight:800;
        }

        .chat-send-button:hover{
            background:#ffc04d;
        }

        .chat-preview{
            display:flex;
            flex-wrap:wrap;
            gap:7px;
            margin-top:10px;
        }

        .chat-preview-item{
            width:68px;
            height:55px;
            overflow:hidden;
            border:1px solid #d9d6ce;
            border-radius:8px;
            background:#eee;
        }

        .chat-preview-item img{
            width:100%;
            height:100%;
            object-fit:cover;
        }

        .chat-upload-help{
            display:block;
            margin-top:7px;
            color:#95979d;
            font-size:.64rem;
        }

        @media (max-width:720px){
            .rental-chat-header{
                align-items:flex-start;
                flex-direction:column;
            }

            .rental-chat-status{
                align-items:flex-start;
            }

            .rental-chat-messages{
                padding:16px 11px;
            }

            .chat-bubble{
                width:86%;
            }

            .chat-composer-top{
                grid-template-columns:1fr;
            }

            .chat-upload-row{
                align-items:stretch;
                flex-direction:column;
            }

            .chat-send-button{
                width:100%;
            }
        }
    </style>
</head>
<body>

<main class="rental-chat-page">
    <g:link
        controller="rentalChat"
        action="index"
        class="rental-chat-back">
        <i class="bi bi-arrow-left"></i>
        All conversations
    </g:link>

    <g:if test="${flash.message}">
        <div class="alert alert-info">
            ${flash.message}
        </div>
    </g:if>

    <section class="rental-chat-shell">
        <header class="rental-chat-header">
            <div class="rental-chat-car">
                <span class="rental-chat-car-icon">
                    <i class="bi bi-car-front-fill"></i>
                </span>

                <span>
                    <strong>
                        ${rental.car.brand} ${rental.car.model}
                    </strong>
                    <span>
                        RENTAL #${rental.id} ·
                        ${rental.customer.fullName ?: rental.customer.username}
                    </span>
                </span>
            </div>

            <div class="rental-chat-status">
                <span class="rental-chat-status-badge">
                    ${rental.status.replace('_', ' ')}
                </span>
                <span class="rental-chat-dates">
                    <g:formatDate date="${rental.startDate}" format="dd MMM yyyy"/>
                    —
                    <g:formatDate date="${rental.endDate}" format="dd MMM yyyy"/>
                </span>
            </div>
        </header>

        <div class="rental-chat-evidence-note">
            <i class="bi bi-shield-lock-fill"></i>
            <span>
                Messages and photos are permanent rental evidence. They cannot be edited
                or deleted, and each photo receives a SHA-256 digital fingerprint.
            </span>
        </div>

        <section
            id="chatMessages"
            class="rental-chat-messages">

            <g:if test="${messageList}">
                <g:each in="${messageList}" var="message">
                    <g:set
                        var="mine"
                        value="${message.sender.id == currentUser.id}"/>

                    <article class="chat-message ${mine ? 'mine' : 'theirs'}">
                        <span class="chat-avatar">
                            <i class="bi bi-person-fill"></i>
                        </span>

                        <div class="chat-bubble">
                            <div class="chat-bubble-head">
                                <span class="chat-sender">
                                    ${message.sender.fullName ?: message.sender.username}
                                    <g:if test="${mine}">(You)</g:if>
                                </span>

                                <span class="chat-time">
                                    <g:formatDate
                                        date="${message.dateCreated}"
                                        format="dd MMM yyyy · HH:mm"/>
                                </span>
                            </div>

                            <g:if test="${message.messageType == 'PICKUP_INSPECTION'}">
                                <span class="chat-message-type">
                                    <i class="bi bi-camera-fill"></i>
                                    PICKUP INSPECTION
                                </span>
                            </g:if>

                            <g:if test="${message.messageType == 'RETURN_INSPECTION'}">
                                <span class="chat-message-type">
                                    <i class="bi bi-camera-fill"></i>
                                    RETURN INSPECTION
                                </span>
                            </g:if>

                            <g:if test="${message.body}">
                                <div class="chat-message-body">${message.body}</div>
                            </g:if>

                            <g:if test="${message.attachments}">
                                <div class="chat-photo-grid">
                                    <g:each
                                        in="${message.attachments}"
                                        var="photo">

                                        <g:link
                                            controller="rentalChat"
                                            action="attachment"
                                            id="${photo.id}"
                                            class="chat-photo"
                                            target="_blank"
                                            title="Open original photo">

                                            <img
                                                src="${createLink(controller: 'rentalChat', action: 'attachment', id: photo.id)}"
                                                alt="${photo.originalFileName}"
                                                loading="lazy"/>

                                            <span class="chat-photo-lock">
                                                <i class="bi bi-lock-fill"></i>
                                            </span>
                                        </g:link>
                                    </g:each>
                                </div>

                                <g:each
                                    in="${message.attachments}"
                                    var="photo">
                                    <div class="chat-photo-proof">
                                        SHA-256:
                                        ${photo.sha256}
                                    </div>
                                </g:each>
                            </g:if>
                        </div>
                    </article>
                </g:each>
            </g:if><g:else>
                <div class="chat-empty">
                    <i class="bi bi-camera"></i>
                    <strong>No messages or vehicle photos yet</strong>
                    <span>Start the record before handing over the vehicle.</span>
                </div>
            </g:else>

            <div id="chatEnd"></div>
        </section>

        <g:uploadForm
            controller="rentalChat"
            action="send"
            id="${rental.id}"
            class="rental-chat-composer">

            <div class="chat-composer-top">
                <label>
                    <span class="chat-field-label">Record type</span>
                    <select
                        name="messageType"
                        class="chat-select">
                        <option value="CHAT">Regular message</option>
                        <option value="PICKUP_INSPECTION">Pickup inspection evidence</option>
                        <option value="RETURN_INSPECTION">Return inspection evidence</option>
                    </select>
                </label>

                <label>
                    <span class="chat-field-label">Message or damage description</span>
                    <textarea
                        name="body"
                        maxlength="2000"
                        class="chat-textarea"
                        placeholder="Example: Existing scratch on the rear-left door before pickup"></textarea>
                </label>
            </div>

            <div class="chat-upload-row">
                <input
                    type="file"
                    id="rentalPhotos"
                    name="photos"
                    class="chat-photo-input"
                    accept="image/jpeg,image/png,image/webp"
                    capture="environment"
                    multiple/>

                <button
                    type="submit"
                    class="chat-send-button">
                    <i class="bi bi-send-fill"></i>
                    Save to record
                </button>
            </div>

            <span class="chat-upload-help">
                Up to 8 photos per message. Each photo must be 5MB or smaller.
                Allowed formats: JPEG, PNG and WebP.
            </span>

            <div
                id="rentalPhotoPreview"
                class="chat-preview"></div>
        </g:uploadForm>
    </section>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var messages = document.getElementById('chatMessages');
        var input = document.getElementById('rentalPhotos');
        var preview = document.getElementById('rentalPhotoPreview');

        if (messages) {
            messages.scrollTop = messages.scrollHeight;
        }

        if (!input || !preview) {
            return;
        }

        input.addEventListener('change', function () {
            preview.innerHTML = '';

            var files = Array.from(input.files || []);

            if (files.length > 8) {
                alert('You can select a maximum of 8 photos.');
                input.value = '';
                return;
            }

            var tooLarge = files.some(function (file) {
                return file.size > 5 * 1024 * 1024;
            });

            if (tooLarge) {
                alert('Each photo must be 5MB or smaller.');
                input.value = '';
                return;
            }

            files.forEach(function (file) {
                var item = document.createElement('span');
                var image = document.createElement('img');
                var objectUrl = URL.createObjectURL(file);

                item.className = 'chat-preview-item';
                image.src = objectUrl;
                image.alt = file.name;
                image.onload = function () {
                    URL.revokeObjectURL(objectUrl);
                };

                item.appendChild(image);
                preview.appendChild(item);
            });
        });
    });
</script>

</body>
</html>
