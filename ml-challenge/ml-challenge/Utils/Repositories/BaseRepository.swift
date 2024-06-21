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
    func createBaseRequest(method: HTTPMethod, url: String, parameters: Parameters? = nil) -> Observable<Data> {
        return self.manager.rx.request(method, url, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .flatMap { $0.validateRequest() }
    }
}


extension BaseRepository {
    func createObservableRequest<T: Decodable>(method: HTTPMethod, url: String, parameters: Parameters? = nil) -> Observable<T> {
        return createBaseRequest(method: method, url: url, parameters: parameters)
            .map { return try JSONDecoder().decode(T.self, from: $0) }
    }
    
    func createSingleRequest<T: Decodable>(method: HTTPMethod, url: String, parameters: Parameters? = nil) -> Single<T> {
        return createObservableRequest(method: method, url: url, parameters: parameters)
            .asSingle()
    }
}
