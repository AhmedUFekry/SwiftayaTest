//
//  ProductUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine


class LocalProductFetchUseCase {
    
    private let repository: ProductRepository = ProductRepository.shared
    
    func fetchProducts() -> AnyPublisher<[ProductEntity], Error> {
        return repository.fetchProductsLocaly()
    }
}


