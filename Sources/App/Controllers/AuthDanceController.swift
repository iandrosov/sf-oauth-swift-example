//
//  AuthDanceController.swift
//  App
//
//  Created by Igor Androsov on 11/17/18.
//

import Vapor

final class AuthDanceController {
    // construct OAuth URL with parameters and strat auth flow
    func sfauth(_ req: Request) throws -> Future<Response> {
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
        let myurl : String = "https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn&redirect_uri=https://localhost:8080/authresult&display=page"
        ///req.http.urlString = myurl
       /*
        let params = [
            "response_type" : "code", // token
            "client_id" : "3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn",
            "redirect_uri" : "https://localhost:5000/oauth/_callback",
            "prompt" : "login consent",
            "display" : "page",
            "state" : "UC115" ] // touch
         */

        return Future.map(on: req) {return req.redirect(to: myurl)}
    }
    
    func sfcallback(_ req: Request) throws -> String {
        print("### TEST: ")
        print(req)
        // Assemble call to get access token
        let urlString = "https://login.salesforce.com/services/oauth2/token"
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        
        // Connect a new client to the supplied hostname.
        let client = try req.client() //try HTTPClient.connect(hostname: "vapor.codes", on: ...).wait()
        print(client) // HTTPClient
        // Create an HTTP request: GET /
        let httpReq = HTTPRequest(method: .POST, url: urlString)
        // Send the HTTP request, fetching a response
        let httpRes = try client.send(httpReq).wait()
        print(httpRes) // HTTPResponse
        
        /**
        let loginRequest = ["grant_type" : "authorization_code",
    "client_id" : "3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn",
            "client_secret" : "",
            "redirect_uri" : "",
            "code" : ""]
        
        return try req.client().post(urlString, headers: headers, beforeSend: { loginReq in
            
            // Encode Content before Request is sent
            return try loginReq.content.encode(loginRequest)
        
        }).map(to: HTTPResponseStatus.self) { response in
    
            let decoded = try response.content.syncDecode(APIAccessResponse.self)
    
            print("token:\(decoded.token)")
    
            //return LoginSession(userID: user.userID, userToken: UUID().uuidString, accessToken: decoded.token)
    
        }
    **/
        
        return "Hello, Salesforce OAuth!"
    }
}
