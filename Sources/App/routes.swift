import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "Stock Vapor works!"
    }

    app.get("hello") { req -> String in
        return "Hello, from stock Vapor!"
    }
}
