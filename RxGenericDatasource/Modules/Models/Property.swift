//
//  Property.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

struct Property: Codable {
    
    // NOTE! these enum names must fit those values comming from the JSON - these could be String, Int etc.
    enum PropertyType: String, Codable {
        case house
        case flat
        case plot
    }
    
    var type: PropertyType
    var size: Int
    var size_symbol: String
    var price: String
}
