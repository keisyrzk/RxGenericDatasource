//
//  City.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

class City: Codable {
    
    var name: String = ""
    var image: String = ""
    var population: String = ""
    var property_type: [String] = []
    var property: [Property] = []
}
