//
//  CoreDataStorage.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import CoreData
import Combine

class CoreDataStorageManager: CoreDataStorageManagerProtocol {
    
    static let shared = CoreDataStorageManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveProductsFromJSON(jsonData: Data) {

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(ProductAPIResponse.self, from: jsonData)

            let responseEntity = ProductAPIResponseEntity(context: managedObjectContext)
            responseEntity.total = Int16(response.total)
            responseEntity.skip = Int16(response.skip)
            responseEntity.limit = Int16(response.limit)

            for product in response.products {
                let productEntity = ProductEntity(context: managedObjectContext)
                productEntity.id = Int16(product.id)
                productEntity.title = product.title
                productEntity.describtion = product.description
                productEntity.price = product.price
                productEntity.discountPercentage = product.discountPercentage
                productEntity.rating = product.rating
                productEntity.stock = Int16(product.stock)
                productEntity.brand = product.brand
                productEntity.category = product.category
                productEntity.thumbnail = product.thumbnail
                let nsArray = product.images as NSArray
                productEntity.images = nsArray

                responseEntity.addToProduct(responseEntity)
            }

            try managedObjectContext.save()
        } catch {
            print("Error saving to Core Data: \(error)")
        }
    }

    
    // MARK: - API Operations
    
    func getAllProducts() -> AnyPublisher<[ProductEntity], Error> {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        return Future<[ProductEntity], Error> { promise in
            do {
                let products = try self.managedObjectContext.fetch(fetchRequest)
                promise(.success(products))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getProduct(withId id: Int) -> AnyPublisher<ProductEntity?, Error> {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        return Future<ProductEntity?, Error> { promise in
            do {
                let products = try self.managedObjectContext.fetch(fetchRequest)
                promise(.success(products.first))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    
    func addNewProduct(title: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let newProduct = ProductEntity(context: self.managedObjectContext)
            newProduct.title = title
            
            do {
                try self.managedObjectContext.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Void, Error> {
        return getProduct(withId: id)
            .flatMap { product -> AnyPublisher<Void, Error> in
                guard let product = product else {
                    return Fail(error: NSError(domain: "com.example.error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Product not found"])) .eraseToAnyPublisher()
                }
                
                product.title = title
                
                return self.managedObjectContext.savePublisher()
                    .map { _ in () }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func deleteProduct(withId id: Int) -> AnyPublisher<Void, Error> {
        return getProduct(withId: id)
            .flatMap { product -> AnyPublisher<Void, Error> in
                guard let product = product else {
                    return Fail(error: NSError(domain: "com.example.error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Product not found"])) .eraseToAnyPublisher()
                }
                
                self.managedObjectContext.delete(product)
                
                return self.managedObjectContext.savePublisher()
                    .map { _ in () }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

extension NSManagedObjectContext {
    func savePublisher() -> AnyPublisher<Void, Error> {
        do {
            try self.save()
            return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
