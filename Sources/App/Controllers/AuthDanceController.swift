//
//  AuthDanceController.swift
//  App
//
//  Created by Igor Androsov on 11/17/18.
//

import Vapor

final class AuthDanceController {
    
    struct SFTokenRequest: Content {
        var grant_type: String
        var client_id: String
        var client_secret: String
        var redirect_uri: String
        var code: String
    }
    struct SFAuthCode: Content {
        var display: String?
        var code: String?
    }
    
    // construct OAuth URL with parameters and strat auth flow
    func sfauth(_ req: Request) throws -> Future<Response> {
        //return try req.make("hello")

        let myurl : String = "https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn&redirect_uri=https://localhost:8080/authresult&display=page"

        return Future.map(on: req) {return req.redirect(to: myurl)}
    }
    
    func sfcallback(_ req: Request) throws -> String {
        print("### TEST: ")
        print(req)
        let flags = try req.query.decode(SFAuthCode.self)
        let authCode = flags.code
        print("### CODE: ")
        print(authCode!) // Flags
        
        
        // Assemble call to get access token
        let urlString = "https://login.salesforce.com/services/oauth2/token"
        //var headers = HTTPHeaders()
        //headers.add(name: "Content-Type", value: "application/json")
        
        let tokenRequest = SFTokenRequest(grant_type: "authorization_code",
        client_id: "3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn",
        client_secret: "8219049706333485472",
        redirect_uri: "https://localhost:8080/sessiontoken",
        code: authCode!)
        
        let myurl : String = "https://login.salesforce.com/services/oauth2/token?grant_type=authorization_code&client_id=3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn&client_secret=8219049706333485472&redirect_uri=https://localhost:8080/sessiontoken&code=\(authCode!)"
        
        /*
        let parameters: Parameters = [ "grant_type" : "authorization_code",
                                       "client_id" : "3MVG9yZ.WNe6byQDinV4pEtYbk.XKrK3LwCNZtKCJ9lKnd6keoaNjuNXu7i3EBK_lLzNSZnXAkQE.2gw4xFZn",
                                       "client_secret" : "8219049706333485472",
                                       "redirect_uri" : "https://localhost:8080/sessiontoken",
                                       "code" : authCode! ]
        let urlString = "https://login.salesforce.com/services/oauth2/token"
        let url = URL.init(string: urlString)
        Alamofire.request(url!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                print("### TOKE RSEULT: ")
                print(jsonData)
            case .failure(let error):
                self.errorFailer(error: error)
            }
        }
        */
        
        let res = try req.client().send(.POST, to: urlString) { post in
               try post.content.encode(tokenRequest)
        }
        
        //let reqTest: Request ...
        
        //let res = try req.client().send(tokenRequest)
        
        //let res = try req.client().post(urlString) { loginReq in
            // encode the loginRequest before sending
        //    print("### INSIDE POST")
        //    try loginReq.content.encode(tokenRequest)
        //}
        print("### AFTER RESPONSE: ")
        print(res) // Future<Response>
        //let decoded = try res.content.syncDecode(JSONEncoder.default)
        
        //print("token:\(decoded.token)")
        
        
        // Connect a new client to the supplied hostname.
        //let client = try req.client()
        //let client = try HTTPClient.connect(hostname: urlString, on: ...).wait()
        //print(client) // HTTPClient
        
        // Create an HTTP request: GET /
        //let httpReq = HTTPRequest(method: .POST, url: urlString)
        
        // Send the HTTP request, fetching a response
        //let httpRes = try client.send(httpReq).wait()
        //print(httpRes) // HTTPResponse
        
        return "Hello, Salesforce Code"
        //return Future.map(on: req) {return req.redirect(to: myurl)}
    }
    
    func sftoken(_ req: Request) throws -> String {
        print("### TEST: ")
        print(req)
    
        return "Hello, Salesforce OAuth Session!"
    }
}
