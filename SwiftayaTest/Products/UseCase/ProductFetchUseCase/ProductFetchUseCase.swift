//
//  ProductUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine


class ProductFetchUseCase {
    
    private let repository: ProductRepositoryProtocol = ProductRepository.shared
    
    func fetchProductsLocaly() -> AnyPublisher<[ProductEntity], Error> {
        return repository.fetchProductsLocaly()
    }
    func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely()
       }
    func fetchProductsRemotely() -> AnyPublisher<ProductAPIResponse, Error> {
        return repository.fetchProductsRemotely()
    }
    
    func getProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.fetchProductRemotely(withId: id)
    }

}


