//
//  AuthDanceController.swift
//  App
//
//  Created by Igor Androsov on 11/17/18.
//

import Vapor

final class AuthDanceController {
    
    func sfauth(_ req: Request) throws -> String {
        //return try req.make("hello")
        // Connect a new client to the supplied hostname.
        //let client = try HTTPClient.connect(hostname: "vapor.codes", on: ...).wait()
        //print(client) // HTTPClient
        // Create an HTTP request: GET /
        //let httpReq = HTTPRequest(method: .GET, url: "https://login.salesforce.com/services/oauth2/authorize")
        // Send the HTTP request, fetching a response
        //let httpRes = try client.send(httpReq).wait()
        //print(httpRes) // HTTPResponse
        
        
        // Creates a generic Client
        let client = try req.client()
        //let req: Request
        let res = try client.send(req)
        print(res) // Future<Response>
        
        return "hello"
    }
    
    func sfcallback(_ req: Request) throws -> String {
        return "Hello, Salesforce OAuth!"
    }
}
