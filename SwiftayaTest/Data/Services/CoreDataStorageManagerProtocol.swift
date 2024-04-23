//
//  CoreDataStorageManagerProtocol.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine
import CoreData

protocol CoreDataStorageManagerProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
    
    func saveProductsFromJSON(jsonData: Data)
    func getAllProducts() -> AnyPublisher<[ProductEntity], Error>
    func getProduct(withId id: Int) -> AnyPublisher<ProductEntity?, Error>
    func addNewProduct(title: String) -> AnyPublisher<Void, Error>
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Void, Error>
    func deleteProduct(withId id: Int) -> AnyPublisher<Void, Error>
}
