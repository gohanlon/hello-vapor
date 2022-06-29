import Vapor
import VaporRouting

enum SiteRoute {
    case home
    case hello
}

let siteRouter = OneOf {
    Route(.case(SiteRoute.home))
    Route(.case(SiteRoute.hello)) { Path { "hello" } }
}


// configures your application
public func configure(_ app: Application) throws {
    app.logger.logLevel = .trace

    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    let mode = Environment.get("ROUTING_MODE") ?? ""
    switch mode {
    case "vapor":
        try routes(app)
    case "vapor-routing":
        app.mount(siteRouter, use: siteHandler)
    default:
        fatalError("Invalid ROUTING_MODE: was '\(mode)' but must be 'vapor' or 'vapor-routing'")
    }
}

func siteHandler(
    request: Request,
    route: SiteRoute
) async throws -> any AsyncResponseEncodable {
    switch route {
    case .home:
        return "vapor-routing works!"
    case .hello:
        return "hello, vapor-routing!"
    }
}
