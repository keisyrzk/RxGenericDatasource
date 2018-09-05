//
//  RequestBuilder.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

class RequestBuilder {
    
    static func build(request: RequestProtocol) -> URLRequest {
        
        var urlRequest = URLRequest(url: request.url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.httpMethod
        
        if let params = request.params {
            
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        }
        
        return urlRequest
    }
}
