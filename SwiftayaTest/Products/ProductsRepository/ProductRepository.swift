//
//  ProductRepository.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine

class ProductRepository : ProductRepositoryProtocol{

    

    
    
    static let shared = ProductRepository()
    
    private let productRemoteDataSource: ProductRemoteDataSourceProtocol
    private let productLocalDataSource: ProductLocalDataSourceProtocol
    
    private init() {
        self.productRemoteDataSource = ProductRemoteDataSource()
        self.productLocalDataSource = ProductLocalDataSource()
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


protocol ProductRepositoryProtocol {
    // Remote
    func fetchProductsRemotely() -> AnyPublisher<ProductAPIResponse, Error>
    func fetchProductRemotely(withId id: Int) -> AnyPublisher<Product, Error>
    func addNewProductRemotely(title: String) -> AnyPublisher<Product, Error>
    func updateProductRemotely(withId id: Int, title: String) -> AnyPublisher<Product, Error>
    func deleteProductRemotely(withId id: Int) -> AnyPublisher<Product, Error>
    
    // Local
    func fetchProductsLocaly() -> AnyPublisher<[ProductEntity], Error>
    func saveProductsFromJSON(jsonData: Data)
}
