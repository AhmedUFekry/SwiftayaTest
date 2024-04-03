//
//  ProductLocalDataSource.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine

class ProductLocalDataSource {
    private let coreDataStorageManager: CoreDataStorageManagerProtocol = CoreDataStorageManager.shared
    
    func fetchData() -> AnyPublisher<[ProductEntity], Error> {
        return coreDataStorageManager.getAllProducts()
    }
    
    func saveProductsFromJSON(jsonData: Data) {
        coreDataStorageManager.saveProductsFromJSON(jsonData: jsonData)
    }
}
