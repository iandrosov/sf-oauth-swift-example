import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    // Start Salesforce OAuth call routes
    let authController = AuthDanceController()
    router.get("sfauth", use: authController.sfauth)
    router.get("authresult", use: authController.sfcallback)
    router.post("sessiontoken", use: authController.sftoken)
    
}
