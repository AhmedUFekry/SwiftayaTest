//
//  APIEndpoints.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Swiftaya
struct APIEndpoints {
    static func getProducts() -> BaseAPIRequest<ProductAPIResponse> {
        let request = BaseAPIRequest<ProductAPIResponse>(
            baseUrl:"https://dummyjson.com",
            path: "/products",
            method: "GET"
        )
        return request
    }
    
    static func getProduct(withId id: Int) -> BaseAPIRequest<Product> {
        let request = BaseAPIRequest<Product>(
            baseUrl:"https://dummyjson.com",
            path: "/products/\(id)",
            method: "GET"
        )
        return request
    }
    
    static func addNewProduct(title: String) -> BaseAPIRequest<Product> {
        let bodyDict = ["title": title]
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict)
        let headers = ["Content-Type": "application/json"]
        let request = BaseAPIRequest<Product>(
            baseUrl:"https://dummyjson.com",
            path: "/products/add",
            method: "POST",
            body: bodyData,
            headers: headers
        )
        return request
    }

    static func updateProduct(withId id: Int, title: String) -> BaseAPIRequest<Product> {
        let bodyDict = ["title": title]
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict)
        let headers = ["Content-Type": "application/json"]
        let request = BaseAPIRequest<Product>(
            baseUrl:"https://dummyjson.com",
            path: "/products/\(id)",
            method: "PUT",
            body: bodyData,
            headers: headers
        )
        return request
    }
    
    static func deleteProduct(withId id: Int) -> BaseAPIRequest<Product> {
        let request = BaseAPIRequest<Product>(
            baseUrl:"https://dummyjson.com",
            path: "/products/\(id)",
            method: "DELETE"
        )
        return request
    }
}
