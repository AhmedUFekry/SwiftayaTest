//
//  ProductUseCase.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 02/04/2024.
//

import Foundation
import Combine


class ProductFetchUseCase {
    var cancellables = Set<AnyCancellable>()
    var productsRemoteResponse: ((ProductAPIResponse?) -> Void)?
    var error: ((Error?) -> Void)?
    private let repository: ProductRepositoryProtocol = ProductRepository.shared
    
    func fetchProductsLocaly() -> AnyPublisher<[ProductEntity], Error> {
        return repository.fetchProductsLocaly()
    }
   /* func execute(requestData: Void) -> AnyPublisher<ProductAPIResponse, Error> {
           return repository.fetchProductsRemotely(withEndpoint: <#T##BaseAPIRequest<Decodable & Encodable>#>)
       }*/
   /* func fetchProductsRemotely() -> AnyPublisher<ProductAPIResponse, Error> {
        return repository.fetchProductsRemotely(withEndpoint: <#BaseAPIRequest<ProductAPIResponse>#>)
    }*/

    func fetchProducts() {
            let endPoint = APIEndpoints.getProducts()

            repository.fetchProductsRemotely(
                withEndpoint: endPoint
            )
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(
                    let error
                ):
                    self.error?(
                        error
                    )
                }
            } receiveValue: { productResponse in
                self.productsRemoteResponse?(
                    productResponse
                )
            }
            .store(
                in: &cancellables
            )
        }
    func getProduct(withId id: Int) -> AnyPublisher<Product, Error> {
        return repository.fetchProductRemotely(withId: id)
    }

}


