//
//  CitiesRequest.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

class CitiesRequest: RequestProtocol {
    
    private static let endpointName = "http://www.mocky.io/v2/5a095f8d320000382613816e"
    let httpMethod: String = "GET"
    let url: URL = URL(string: CitiesRequest.endpointName)!
    public let params: [String: Any]?
    
    // here we can pass any needed arguments
    public init() {
        
        params = nil
    }
}

/*
 this is a sample complex params structure
 
 params = ["name": CitiesRequest.endpointName,
 "data": ["method": CitiesRequest.method,
 "data": [ "code": [ "$in": [ sample_argument ] ] ],
 "options": ["include" : ["SampleContentStructure"]]
 ]
 ]
 */
