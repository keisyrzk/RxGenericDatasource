//
//  Services.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Services {
    
    static fileprivate let timeout = 20.0
    
    
    
    static func getCities() -> Observable<[City]> {
        
        let scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.userInitiated, relativePriority: 1000))
        
        let urlRequest = RequestBuilder.build(request: CitiesRequest())
        
        return URLSession.shared.rx.response(request: urlRequest)
            .map{ (response, data) -> [City] in
                                
                if 200 ..< 300 ~= response.statusCode {
                    
                    do {
                        let result = try JSONDecoder().decode(Cities.self, from: data)
                        return result.data
                    }
                    catch {
                        throw error
                    }
                }
                else {
                    
                    // NOTE!  this is usefull if we like to create custom errors
                    
                    let errorResponse = ErrorResponse()
                    errorResponse.errorMessage = "An error occured with code \(response.statusCode)"
                    errorResponse.errorCode = "\(response.statusCode)"
                    
                    switch response.statusCode {
                        
                    case 400:
                        throw ErrorResponseType.badRequest(errorResponse: errorResponse)
                        
                    default:
                        throw ErrorResponseType.responseError(errorResponse: errorResponse)
                    }
                }
            }
            .timeout(Services.timeout, scheduler: scheduler)
            .observeOn(scheduler)
    }
}
