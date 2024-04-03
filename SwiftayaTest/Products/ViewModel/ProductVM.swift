//
//  File.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine

class ProductVM {
    @Published var productResponseRemote: ProductAPIResponse?
    @Published var productResponseLocal: [ProductEntity]?
    @Published var product: Product?

    private let productUseCase: ProductUseCase = ProductUseCase()
    
    func fetchProductsRemote(completion: @escaping (Error?) -> Void) {
        productUseCase.execute(requestData: ())
            .sink(receiveCompletion: {completion($0 as? Error)}) { [weak self] productResponseRemote in
                self?.productResponseRemote = productResponseRemote
            }
            .store(in: &cancellables)
    }
    
    func getProduct(withId id: Int) {
        productUseCase.getProduct(withId: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func addNewProduct(title: String) {
        print("ProductVM: Calling addNewProduct")
        productUseCase.addNewProduct(title: title)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                print("ProductVM: Received product from addNewProduct")
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func updateProduct(withId id: Int, title: String) {
        productUseCase.updateProduct(withId: id, title: title)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func deleteProduct(withId id: Int) {
        productUseCase.deleteProduct(withId: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func fetchProductsLocal(completion: @escaping (Error?) -> Void) {
        productUseCase.execute(
            requestData: ())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {completion($0 as? Error)}) { [weak self] productResponseLocal in
            self?.productResponseLocal = productResponseLocal
        }
        .store(in: &cancellables)
    }
    
    func saveProductsToCoreData(products: ProductAPIResponse) {
        do {
            let jsonData = try JSONEncoder().encode(products)
            productUseCase.saveProductsFromJSON(jsonData: jsonData)
        } catch {
            print("Error encoding products to JSON: \(error)")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
}

