//
//  RequestProtocol.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    
    var url: URL { get }
    var params: [String: Any]? { get }
    var httpMethod: String { get }
}
