//
//  RemoteProductModificationUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 15/04/2024.
//

import Foundation
import Combine

class AddNewProductUseCase {
    
    private let repository: ProductRepositoryProtocol = ProductRepository.shared

    func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely()
       }
    func addNewProduct(title: String) -> AnyPublisher<Product, Error> {
        return repository.addNewProductRemotely(title: title)
    }
    
    }
