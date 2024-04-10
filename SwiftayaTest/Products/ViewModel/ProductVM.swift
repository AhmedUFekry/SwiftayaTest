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

    private let remoteProductFetchUseCase: RemoteProductFetchUseCase = RemoteProductFetchUseCase()
    private let remoteProductModificationUseCase: RemoteProductModificationUseCase = RemoteProductModificationUseCase()
    private let localProductFetchUseCase: LocalProductFetchUseCase = LocalProductFetchUseCase()
    private let localProductModificationUseCase: LocalProductModificationUseCase = LocalProductModificationUseCase()


    func fetchProductsRemote(completion: @escaping (Error?) -> Void) {
        remoteProductFetchUseCase.execute(requestData: ())
            .sink(receiveCompletion: {completion($0 as? Error)}) { [weak self] productResponseRemote in
                self?.productResponseRemote = productResponseRemote
            }
            .store(in: &cancellables)
    }
    
    func getProduct(withId id: Int) {
        remoteProductFetchUseCase.getProduct(withId: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func addNewProduct(title: String) {
        print("ProductVM: Calling addNewProduct")
        remoteProductModificationUseCase.addNewProduct(title: title)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                print("ProductVM: Received product from addNewProduct")
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func updateProduct(withId id: Int, title: String) {
        remoteProductModificationUseCase.updateProduct(withId: id, title: title)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func deleteProduct(withId id: Int) {
        remoteProductModificationUseCase.deleteProduct(withId: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancellables)
    }
    
    func fetchProductsLocal(completion: @escaping (Error?) -> Void) {
        localProductFetchUseCase.fetchProducts()
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {completion($0 as? Error)}) { [weak self] productResponseLocal in
            self?.productResponseLocal = productResponseLocal
        }
        .store(in: &cancellables)
    }
    
    func saveProductsToCoreData(products: ProductAPIResponse) {
        do {
            let jsonData = try JSONEncoder().encode(products)
            localProductModificationUseCase.saveProductsFromJSON(jsonData: jsonData)
        } catch {
            print("Error encoding products to JSON: \(error)")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
}

