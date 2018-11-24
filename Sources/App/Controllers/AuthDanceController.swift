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

        //let httpReq = Request(http: .GET, using: "https://login.salesforce.com/services/oauth2/authorize")
        let myurl : String = "https://login.salesforce.com/services/oauth2/authorize"
        ///req.http.urlString = myurl
        
        let params = [
            "response_type" : "code", // token
            "client_id" : "3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn",
            "redirect_uri" : "https://localhost:5000/oauth/_callback",
            "prompt" : "login consent",
            "display" : "page",
            "state" : "UC115" ] // touch

        // Creates a generic Client
        let client = try req.client()
        //let req: Request
        //let res = client.send(req)
        let res = client.get(myurl)
        print(res) // Future<Response>T##url: URLRepresentable##URLRepresentable
        
        return "authresult"
    }
    
    func sfcallback(_ req: Request) throws -> String {
        return "Hello, Salesforce OAuth!"
    }
}
