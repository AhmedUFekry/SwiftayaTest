//
//  ProductUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine

class ProductUseCase {
    
    private let repository: ProductRepository = ProductRepository(
        productRemoteDataSource: ProductRemoteDataSource(),
        productLocalDataSource: ProductLocalDataSource()
    )
    
    // MARK: - Remote
    
    func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
        return repository.fetchProductsRemotely()
    }
    
    func getProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.fetchProductRemotely(withId: id)
    }
    
    func addNewProduct(title: String) -> AnyPublisher<Product, Error> {
        print("ProductUseCaseRemote: Executing addNewProduct")
        return repository.addNewProductRemotely(title: title)
    }
    
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Product, Error> {
        return repository.updateProductRemotely(withId: id, title: title)
    }
    
    func deleteProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.deleteProductRemotely(withId: id)
    }
    
    // MARK: - Local
    
    func execute(requestData: Void) -> AnyPublisher<[ProductEntity], Error> {
        return repository.fetchProductsLocaly()
    }
    
    func saveProductsFromJSON(jsonData: Data) {
        repository.saveProductsFromJSON(jsonData: jsonData)
    }
}
