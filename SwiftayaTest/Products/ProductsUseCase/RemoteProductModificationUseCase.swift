//
//  RemoteProductModificationUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 15/04/2024.
//

import Foundation
import Combine

class RemoteProductModificationUseCase {
    
    private let repository: ProductRepository = ProductRepository.shared

    func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely()
       }
    func addNewProduct(title: String) -> AnyPublisher<Product, Error> {
        print("RemoteProductModificationUseCase: Executing addNewProduct")
        return repository.addNewProductRemotely(title: title)
    }
    
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Product, Error> {
        return repository.updateProductRemotely(withId: id, title: title)
    }
    
    func deleteProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.deleteProductRemotely(withId: id)
    }
}
