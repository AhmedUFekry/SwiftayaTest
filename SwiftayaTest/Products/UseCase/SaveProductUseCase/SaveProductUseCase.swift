//
//  LocalProductModificationUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 15/04/2024.
//

import Foundation
import Combine
class SaveProductUseCase {
    
    private let repository: ProductRepositoryProtocol = ProductRepository.shared
    
    func saveProductsFromJSON(jsonData: Data) {
        repository.saveProductsFromJSON(jsonData: jsonData)
    }
}
