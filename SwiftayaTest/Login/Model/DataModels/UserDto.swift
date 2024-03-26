//
//  UserDto.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import Foundation
struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let token: String
}
