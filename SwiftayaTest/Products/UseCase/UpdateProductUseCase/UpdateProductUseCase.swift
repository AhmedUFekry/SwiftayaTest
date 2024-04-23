//
//  UpdateProductUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 17/04/2024.
//

import Foundation
import Combine

class UpdateProductUseCase {
    
    private let repository:ProductRepositoryProtocol = ProductRepository.shared

    /*func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely(withEndpoint: <#T##BaseAPIRequest<Decodable & Encodable>#>)
       }*/
    
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Product, Error> {
        return repository.updateProductRemotely(withId: id, title: title)
    }
    
}
