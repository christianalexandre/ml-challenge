//
//  BaseRepository.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

/// A base repository class for handling network requests.
class BaseRepository {
    static let shared = BaseRepository()
    private init() {
        let config = Session.default.session.configuration
        manager = Session(configuration: config)
    }
    
    private var manager: Session!
}


// - MARK: Base request
private extension BaseRepository {
    /// Base network request
    /// - Parameters:
    ///   - method: The HTTP method to use
    ///   - url: The URL for request
    ///   - parameters: The parameters to include in the request
    /// - Returns: An Observable emitting the data from request
    func createBaseRequest(method: HTTPMethod, url: String, parameters: Parameters? = nil) -> Observable<Data> {
        return self.manager.rx.request(method, url, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .flatMap { $0.validateRequest() }
    }
}

// - MARK: Public request methods
extension BaseRepository {
    /// Create Observable request and decode the response
    /// - Parameters:
    ///   - method: The HTTP method to use
    ///   - url: The URL for request
    ///   - parameters: The parameters to include in the request
    /// - Returns: An Observable emitting the decoded response
    func createObservableRequest<T: Decodable>(method: HTTPMethod, url: String, parameters: Parameters? = nil) -> Observable<T> {
        return createBaseRequest(method: method, url: url, parameters: parameters)
            .map { return try JSONDecoder().decode(T.self, from: $0) }
    }
    
    /// Create Single request and decode the response
    /// - Parameters:
    ///   - method: The HTTP method to use
    ///   - url: The URL for request
    ///   - parameters: The parameters to include in the request
    /// - Returns: An Single emitting the decoded response
    func createSingleRequest<T: Decodable>(method: HTTPMethod, url: String, parameters: Parameters? = nil) -> Single<T> {
        return createObservableRequest(method: method, url: url, parameters: parameters)
            .asSingle()
    }
}
