//
//  CollectionViewModel.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

typealias CityCellConfig = CollectionCellConfigurator<CityCell, City>
typealias PropertyCellConfig = CollectionCellConfigurator<PropertyCell, Property>

class CollectionViewModel {
    
    enum ItemType {
        case Cities
        case Properties
    }
    
    private let cityData: [City]
    
    init(collection: UITableView, cityData: [City]) {
        
        self.cityData = cityData
        
        collection.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        collection.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
    }
    
    func generateItems(types: [ItemType]) -> [CellConfigurator] {
        
        var items: [CellConfigurator] = []
        
        types.forEach { (type) in
            
            switch type {
                
            case .Cities:
                items.append(contentsOf: generateCityItems())
            case .Properties:
                items.append(contentsOf: generatePropertyItems())
            }
        }
        
        return items
    }
    
    private func generateCityItems() -> [CellConfigurator] {
        
        var items: [CellConfigurator] = []
        cityData.forEach { (city) in
            items.append(CityCellConfig.init(item: city))
        }
        return items
    }
    
    private func generatePropertyItems() -> [CellConfigurator] {
        
        var items: [CellConfigurator] = []
        cityData.forEach { (city) in
            city.property.forEach({ (property) in
                items.append(PropertyCellConfig(item: property))
            })
        }
        return items
    }
}
