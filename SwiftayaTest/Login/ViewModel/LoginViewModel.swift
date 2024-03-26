//
//  LoginViewModel.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import Foundation
import Combine
class LoginViewModel: ObservableObject {
    private let useCase: LoginUseCase
    
    @Published var user: User?
    @Published var error: Error?
    
    init(useCase: LoginUseCase = LoginUseCase()) {
        self.useCase = useCase
    }
    
    func login(username: String, password: String) {
         useCase.login(username: username, password: password)
              .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            }, receiveValue: { user in
                self.user = user
            })
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
}
