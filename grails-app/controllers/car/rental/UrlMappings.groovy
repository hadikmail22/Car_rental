package car.rental

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/api/cars"(controller: 'carApi') {
    action = [
            GET : 'index',
            POST: 'save'
    ]
}

"/api/cars/$id"(controller: 'carApi') {
    action = [
            GET   : 'show',
            PUT   : 'update',
            DELETE: 'delete'
    ]
}
get "/api/rentals"(
        controller: "rentalApi",
        action: "index"
)

post "/api/rentals"(
        controller: "rentalApi",
        action: "save"
)

get "/api/rentals/$id"(
        controller: "rentalApi",
        action: "show"
)

put "/api/rentals/$id"(
        controller: "rentalApi",
        action: "update"
)

delete "/api/rentals/$id"(
        controller: "rentalApi",
        action: "delete"
)

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
