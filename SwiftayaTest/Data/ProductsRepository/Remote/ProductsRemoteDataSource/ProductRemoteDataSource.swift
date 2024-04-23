//
//  ProductRemoteDataSource.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine
import Swiftaya



class ProductRemoteDataSource : ProductRemoteDataSourceProtocol{
    private let apiRequestProvider: APIRequestProviderProtocol = APIRequestProvider()
    
   /* func fetchData() -> AnyPublisher<ProductAPIResponse, Error> {
        let request = APIEndpoints.getProducts()
        return apiRequestProvider.request(request: request)
    }*/

    func fetchData<T: Decodable>(withEndpoint endpoint: BaseAPIRequest<T>) -> AnyPublisher<T,Error>{apiRequestProvider.request(request: endpoint)}
    
    func getProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        let request = APIEndpoints.getProduct(withId: id)
        return apiRequestProvider.request(request: request)
    }
    
    func addNewProduct(title: String) -> AnyPublisher<Product, Error> {
        print("ProductRepoRemote: Making request for addNewProduct")
        let request = APIEndpoints.addNewProduct(title: title)
        return apiRequestProvider.request(request: request)
    }
    
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Product, Error> {
        let request = APIEndpoints.updateProduct(withId: id, title: title)
        return apiRequestProvider.request(request: request)
    }
    
    func deleteProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        let request = APIEndpoints.deleteProduct(withId: id)
        return apiRequestProvider.request(request: request)
    }
}


protocol ProductRemoteDataSourceProtocol {
    func fetchData<T: Decodable>(withEndpoint endpoint: BaseAPIRequest<T>) -> AnyPublisher<T,Error>
    func getProduct(withId id: Int) -> AnyPublisher<Product, Error>
    func addNewProduct(title: String) -> AnyPublisher<Product, Error>
    func updateProduct(withId id: Int, title: String) -> AnyPublisher<Product, Error>
    func deleteProduct(withId id: Int) -> AnyPublisher<Product, Error>
}
