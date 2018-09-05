//
//  Data+prettyJSON.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

extension Data {
    func prettyJSON() -> String {
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            
            do {
                let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                return json.jsonDataToString()
                
            } catch let error as NSError {
                print(error)
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        return jsonDataToString()
    }
    
    func jsonDataToString() -> String {
        return String(data: self, encoding: String.Encoding.utf8) ?? ""
    }
}
