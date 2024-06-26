//
//  ViewController.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import UIKit
import Combine
class ViewController: BaseViewController {
    
    var productResponseRemote: ProductAPIResponse?
    var productResponseLocal: [ProductEntity]?
    var product: Product?
    
    var presenter : ProductPresenter?
    

    private var viewModel = LoginViewModel()

    var productVM = ProductVM()
    let pm = ProductVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //////
        //loginResponse()
        fetchProducts()
        //observeProductResponseLocalChanges()
        bindData()
    }
    
    private func bindData(){
        productVM.$productResponseRemote
            .sink { [weak self] productResponse in
                if let product = productResponse?.products {
                            print(
                                product
                            )
                        } else {
                            print(
                                "Product response is nil or empty"
                            )
                        }                    }
                    .store(
                        in: &cancellables
                    )
    }
    
    /*private func fetchProducts() {
        productVM.fetchProductsRemote { [weak self] error in
            if let error = error {
                print("Error fetching products: \(error)")
            } else {
                if let products = self?.productVM.productResponseRemote {
                    self?.productVM.saveProductsToCoreData(products: products)
                    
                    self?.productVM.fetchProductsLocal { error in
                        if let error = error {
                            print("Error fetching products: \(error)")
                        }
                    }
                }
            }
        }
    }*/
    
    private func loginResponse(){
        viewModel.login(username: "kminchelle", password: "0lelplR")
        
        viewModel.$user
            .sink { user in
                if let user = user {
                    print(user)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .sink { error in
                if let error = error {
                    // Handle the error if needed
                    print("Error: \(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchProducts() {
        productVM.fetchProductsRemote()
        
    }
    
    private func observeProductResponseLocalChanges() {
        productVM.$productResponseLocal
            .sink { [weak self] productEntities in
                guard let productEntities = productEntities else {
                    return
                }
                
                for productEntity in productEntities {
                    print("Product ID: \(productEntity.id)")
                    print("Product Title: \(productEntity.title ?? "")")
                    // Print other product details...
                }
            }
            .store(in: &cancellables)
    }
    
    private func observeProductChanges() {
        productVM.$product
            .sink { [weak self] product in
                guard let product = product else {
                    return
                }
                
                print("Product ID: \(product.id)")
                print("Product Title: \(product.title)")
                // Print other product details...
            }
            .store(in: &cancellables)
    }
    
    private func getProduct(withId id: Int) {
        productVM.getProduct(withId: id)
    }
    
    private func addNewProduct(title: String) {
        productVM.addNewProduct(title: title)
    }
    
    private func updateProduct(withId id: Int, title: String) {
        productVM.updateProduct(withId: id, title: title)
    }
    
    private func deleteProduct(withId id: Int) {
        productVM.deleteProduct(withId: id)
    }

}

