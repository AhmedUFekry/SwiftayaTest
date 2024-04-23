//
//  Prooduct.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation

// Product Model
struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

// APIResponse Model
struct ProductAPIResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
