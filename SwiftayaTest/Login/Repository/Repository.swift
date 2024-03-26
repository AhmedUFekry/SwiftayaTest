//
//  Repository.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import Foundation
import Swiftaya
import Combine
class UserRepository: BaseRepository<LoginRequest> {
    func login(username: String, password: String) -> AnyPublisher<User, Error> {
        let request = LoginRequest(username: username, password: password)
        return execute(request: request)
    }
}
