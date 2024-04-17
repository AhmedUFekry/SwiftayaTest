//
//  DeleteProductUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 17/04/2024.
//

import Foundation
import Combine
class DeleteProductUseCase {
    
    private let repository: ProductRepositoryProtocol = ProductRepository.shared

    func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely()
       }
    
    func deleteProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.deleteProductRemotely(withId: id)
    }
}
