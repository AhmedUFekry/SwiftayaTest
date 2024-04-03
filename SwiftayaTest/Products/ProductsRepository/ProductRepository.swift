//
//  ProductRepository.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine

class ProductRepository {
    
    private let productRemoteDataSource: ProductRemoteDataSource
    private let productLocalDataSource: ProductLocalDataSource
    
    init(productRemoteDataSource: ProductRemoteDataSource, productLocalDataSource: ProductLocalDataSource) {
        self.productRemoteDataSource = productRemoteDataSource
        self.productLocalDataSource = productLocalDataSource
    }
    
    // MARK: - Remote
    
    func fetchProductsRemotely() -> AnyPublisher<ProductAPIResponse, Error> {
        productRemoteDataSource.fetchData()
    }
    
    func fetchProductRemotely(withId id: Int) -> AnyPublisher<Product, Error> {
        productRemoteDataSource.getProduct(withId: id)
    }
    
    func addNewProductRemotely(title: String) -> AnyPublisher<Product, Error> {
        return productRemoteDataSource.addNewProduct(title: title)
    }
    
    func updateProductRemotely(withId id: Int, title: String) -> AnyPublisher<Product, Error> {
        productRemoteDataSource.updateProduct(withId: id, title: title)
    }
    
    func deleteProductRemotely(withId id: Int) -> AnyPublisher<Product, Error> {
        productRemoteDataSource.deleteProduct(withId: id)
    }
    
    // MARK: - Local
    
    func fetchProductsLocaly() -> AnyPublisher<[ProductEntity], Error> {
        productLocalDataSource.fetchData()
    }
    
    func saveProductsFromJSON(jsonData: Data) {
        productLocalDataSource.saveProductsFromJSON(jsonData: jsonData)
    }
}
