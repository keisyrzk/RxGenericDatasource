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
    
    init(collection: UITableView) {
                
        collection.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        collection.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
    }
    
    ///////////////////
    // generate section
    
    func generateSection(header: String?, from data: [[AnyObject]]) -> MultipleSectionModel {
        
        var sectionItems: [SectionItem] = []
        
        data.forEach { (itemsData) in
            let items = generateItems(data: itemsData)
            items.forEach { (cellConfigurator) in
                sectionItems.append(.GenericItem(cellConfigurator: cellConfigurator))
            }
        }
        
        return MultipleSectionModel.GenericSection(header: header ?? "", items: sectionItems)
    }
    
    /////////////////
    // generate items
    
    private func generateItems(data: [AnyObject]) -> [CellConfigurator] {
        
        var items: [CellConfigurator] = []
        
        if let firstItem = data.first {
            
            if firstItem.isKind(of: Property.self) {
                items.append(contentsOf: generatePropertyItems(data: data))
            }
            if firstItem.isKind(of: City.self) {
                items.append(contentsOf: generateCityItems(data: data))
            }
        }
        
        return items
    }
    
    private func generatePropertyItems(data: [AnyObject]) -> [CellConfigurator] {
        
        var items: [CellConfigurator] = []
        data.forEach { (property) in
            if let _property = property as? Property {
                items.append(PropertyCellConfig.init(item: _property))
            }
        }
        return items
    }
    
    private func generateCityItems(data: [AnyObject]) -> [CellConfigurator] {
        
        var items: [CellConfigurator] = []
        data.forEach { (city) in
            if let _city = city as? City {
                items.append(CityCellConfig.init(item: _city))
            }
        }
        return items
    }
    
//    func generateItems(types: [ItemType]) -> [CellConfigurator] {
//
//        var items: [CellConfigurator] = []
//
//        types.forEach { (type) in
//
//            switch type {
//
//            case .Cities:
//                items.append(contentsOf: generateCityItems())
//            case .Properties:
//                items.append(contentsOf: generatePropertyItems())
//            }
//        }
//
//        return items
//    }
//
//    private func generateCityItems() -> [CellConfigurator] {
//
//        var items: [CellConfigurator] = []
//        cityData.forEach { (city) in
//            items.append(CityCellConfig.init(item: city))
//        }
//        return items
//    }
//
//    private func generatePropertyItems() -> [CellConfigurator] {
//
//        var items: [CellConfigurator] = []
//        cityData.forEach { (city) in
//            city.property.forEach({ (property) in
//                items.append(PropertyCellConfig(item: property))
//            })
//        }
//        return items
//    }
//
//    static func generateSection(header: String?, items: [CellConfigurator]) -> MultipleSectionModel {
//
//        var sectionItems: [SectionItem] = []
//        items.forEach { (cellConfigurator) in
//            sectionItems.append(.GenericItem(cellConfigurator: cellConfigurator))
//        }
//
//        return MultipleSectionModel.GenericSection(header: header ?? "", items: sectionItems)
//    }
}
