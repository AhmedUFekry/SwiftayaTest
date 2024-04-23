//
//  Presenter.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 23/04/2024.
//

import Foundation
import Combine


class ProductPresenter: BasePresenter<Product> {
    var view : ViewController = ViewController()

    private let addNewProductUseCase: AddNewProductUseCase = AddNewProductUseCase()
    private let productFetchUseCase: ProductFetchUseCase = ProductFetchUseCase()
    private let saveProductUseCase: SaveProductUseCase = SaveProductUseCase()
    private let updateProductUseCase :UpdateProductUseCase = UpdateProductUseCase()
    private let deleteProductUseCase : DeleteProductUseCase = DeleteProductUseCase()
    
    /*func fetchProductsRemote(completion: @escaping (Error?) -> Void) {
     productFetchUseCase.execute(requestData: ())
     .sink(receiveCompletion: {completion($0 as? Error)}) { [weak self] productResponseRemote in
     self?.productResponseRemote = productResponseRemote
     }
     .store(in: &cancellables)
     }*/
    func setupSubscriptions() {
        productFetchUseCase.productsRemoteResponse = { [weak self] response in
            self?.view.productResponseRemote = response
        }
    }
        func fetchProductsRemote() {
            productFetchUseCase.fetchProducts()
        }
        
        func getProduct(withId id: Int) {
            productFetchUseCase.getProduct(withId: id)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                    self?.view.product = product
                })
                .store(in: &cancellables)
        }
        
        
        func addNewProduct(title: String) {
            print("ProductVM: Calling addNewProduct")
            addNewProductUseCase.addNewProduct(title: title)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                    print("ProductVM: Received product from addNewProduct")
                    self?.view.product = product
                })
                .store(in: &cancellables)
        }
        
        func updateProduct(withId id: Int, title: String) {
            updateProductUseCase.updateProduct(withId: id, title: title)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                    self?.view.product = product
                })
                .store(in: &cancellables)
        }
        
        func deleteProduct(withId id: Int) {
            deleteProductUseCase.deleteProduct(withId: id)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] product in
                    self?.view.product = product
                })
                .store(in: &cancellables)
        }
        
        func fetchProductsLocal(completion: @escaping (Error?) -> Void) {
            productFetchUseCase.fetchProductsLocaly()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {completion($0 as? Error)}) { [weak self] productResponseLocal in
                    self?.view.productResponseLocal = productResponseLocal
                }
                .store(in: &cancellables)
        }
        
        func saveProductsToCoreData(products: ProductAPIResponse) {
            do {
                let jsonData = try JSONEncoder().encode(products)
                saveProductUseCase.saveProductsFromJSON(jsonData: jsonData)
            } catch {
                print("Error encoding products to JSON: \(error)")
            }
        }
}
