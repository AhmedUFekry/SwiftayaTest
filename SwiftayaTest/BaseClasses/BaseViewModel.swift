//
//  BaseViewModel.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 23/04/2024.
//

import Foundation
import Combine

class BaseViewModel<T> {
    var cancellables = Set<AnyCancellable>()
    
    func handleCompletion<T>(_ completion: Subscribers.Completion<Error>, value: T? = nil, errorCompletion: ((Error) -> Void)? = nil) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            errorCompletion?(error)
        }
    }
}

