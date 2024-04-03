//
//  LoginRequest.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import Foundation
import Swiftaya
struct LoginRequest: APIRequestProtocol {
    typealias Response = User
    var baseUrl: String = "https://dummyjson.com"
    var path: String = "/auth/login"
    var method: String = "POST"
    var body: Data?
    var headers: [String: String]? = ["Content-Type": "application/json"]
    
    init(username: String, password: String) {
        let params: [String: Any] = [
            "username": username,
            "password": password
        ]
        self.body = try? JSONSerialization.data(withJSONObject: params)
    }
}
