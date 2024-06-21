//
//  DataRequestExtension.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {
    func validateRequest() -> Observable<Data> {
        return Observable.create { observer in
            self.responseString(encoding: .utf8, completionHandler: { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let statusCode = dataResponse.response?.statusCode ?? 0
                    switch statusCode {
                    case 200 ..< 300:
                        if let data = data.data(using: .utf8) {
                            observer.onNext(data)
                            observer.onCompleted()
                        } else {
                            observer.onError(NSError.thowError(message: "Error parsing data"))
                        }
                    default:
                        observer.onError(NSError.thowError(message: "Error parsing status code"))
                    }
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
}

