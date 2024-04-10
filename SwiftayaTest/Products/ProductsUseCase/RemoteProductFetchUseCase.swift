//
//  RemoteProductFetchUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 15/04/2024.
//

import Foundation
import Combine

class RemoteProductFetchUseCase {
    
    private let repository: ProductRepository = ProductRepository.shared

 
    func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely()
       }
    func fetchProducts() -> AnyPublisher<ProductAPIResponse, Error> {
        return repository.fetchProductsRemotely()
    }
    
    func getProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.fetchProductRemotely(withId: id)
    }
}
