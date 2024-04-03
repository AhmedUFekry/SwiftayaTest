//
//  ViewController.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import UIKit
import Combine
class ViewController: UIViewController {

    private var viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()

    private var productVM = ProductVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        //////
        fetchProducts()
        observeProductResponseLocalChanges()
    }
    
    private func fetchProducts() {
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

