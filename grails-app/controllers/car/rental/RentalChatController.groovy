package car.rental

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.access.AccessDeniedException
import org.springframework.web.multipart.MultipartFile

@Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
class RentalChatController {

    RentalChatService rentalChatService
    def springSecurityService

    static allowedMethods = [
            send   : 'POST',
            archive: 'POST'
    ]

    def index() {

        User currentUser =
                springSecurityService.currentUser as User

        [
                conversationList:
                        rentalChatService
                                .getConversationsForUser(
                                        currentUser
                                ),
                currentUser: currentUser
        ]
    }

    def show(Long id) {

        User currentUser =
                springSecurityService.currentUser as User

        try {

            Rental rental =
                    rentalChatService
                            .getAccessibleRental(
                                    id,
                                    currentUser
                            )

            List<RentalMessage> messageList =
                    rentalChatService.getMessages(
                            id,
                            currentUser
                    )

            rentalChatService.markConversationRead(
                    id,
                    currentUser
            )

            [
                    rental     : rental,
                    messageList: messageList,
                    currentUser: currentUser
            ]

        } catch (AccessDeniedException exception) {
            throw exception

        } catch (
                IllegalArgumentException |
                IllegalStateException exception
        ) {

            flash.message =
                    exception.message

            redirect(
                    action: 'index'
            )

            null
        }
    }

    def send(Long id) {

        User currentUser =
                springSecurityService.currentUser as User

        List<MultipartFile> photos =
                request.getFiles('photos') ?: []

        try {

            rentalChatService.sendMessage(
                    id,
                    currentUser,
                    params.body?.toString(),
                    params.messageType?.toString(),
                    photos
            )

            flash.message =
                    'Message saved in the rental record.'

        } catch (AccessDeniedException exception) {
            throw exception

        } catch (
                IllegalArgumentException |
                IllegalStateException exception
        ) {

            flash.message =
                    exception.message
        }

        redirect(
                action: 'show',
                id: id
        )
    }

    def archive(Long id) {

        User currentUser =
                springSecurityService.currentUser as User

        try {

            rentalChatService.archiveConversation(
                    id,
                    currentUser
            )

            flash.message =
                    'Old conversation removed from your list.'

        } catch (AccessDeniedException exception) {
            throw exception

        } catch (
                IllegalArgumentException |
                IllegalStateException exception
        ) {

            flash.message =
                    exception.message
        }

        redirect(
                action: 'index'
        )
    }

    def attachment(Long id) {

        User currentUser =
                springSecurityService.currentUser as User

        try {

            RentalMessageAttachment attachment =
                    rentalChatService
                            .getAccessibleAttachment(
                                    id,
                                    currentUser
                            )

            String downloadName =
                    attachment.originalFileName
                            .replaceAll(
                                    '[^A-Za-z0-9._-]',
                                    '_'
                            )

            response.contentType =
                    attachment.contentType

            response.contentLength =
                    attachment.imageData.length

            response.setHeader(
                    'Content-Disposition',
                    'inline; filename="' +
                            downloadName +
                            '"'
            )

            response.setHeader(
                    'Cache-Control',
                    'private, max-age=31536000, immutable'
            )

            response.outputStream.write(
                    attachment.imageData
            )

            response.outputStream.flush()

        } catch (AccessDeniedException exception) {
            throw exception

        } catch (IllegalArgumentException exception) {
            response.sendError(
                    404,
                    exception.message
            )
        }
    }
}
