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
    let baseUrl: String = "https://dummyjson.com"
    let path: String = "/auth/login"
    let method: String = "POST"
    let body: Data?
    let headers: [String: String]? = ["Content-Type": "application/json"]
    
    init(username: String, password: String) {
        let params: [String: Any] = [
            "username": username,
            "password": password
        ]
        self.body = try? JSONSerialization.data(withJSONObject: params)
    }
}
