//
//  MultipleSectionModel.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

//A LIST OF SECTIONS MODELS
enum MultipleSectionModel {
    //    case CitySection(header: String, items: [SectionItem])
    //    case PropertySection(header: String, items: [SectionItem])
    
    case GenericSection(header: String, items: [SectionItem])
}

//A LIST OF SECTION ITEMS
enum SectionItem {
    //    case CityItem(name: String, imageUrl: String)
    //    case PropertyItem(name: String, price: String, chosen: Bool)
    
    case GenericItem(cellConfigurator: CellConfigurator)
}

extension MultipleSectionModel: SectionModelType {
    
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        
        switch self {
            
            //        case .CitySection(header: _, items: let items):
            //            return items.map { $0 }
            //        case .PropertySection(header: _, items: let items):
            //            return items.map { $0 }
            
        case .GenericSection(header: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        
        switch original {
            
            //        case let .CitySection(header: header, items: _):
            //            self = .CitySection(header: header, items: items)
            //        case let .PropertySection(header: header, items: _):
            //            self = .PropertySection(header: header, items: items)
            
        case let .GenericSection(header: header, items: _):
            self = .GenericSection(header: header, items: items)
        }
    }
}

extension MultipleSectionModel {
    
    var header: String {
        
        switch self {
            
            //        case .CitySection(header: let header, items: _):
            //            return header
            //        case .PropertySection(header: let header, items: _):
            //            return header
            
        case .GenericSection(header: let header, items: _):
            return header
        }
    }
}

///////////////////////
// SECTIONS DEFINITIONS

//struct CitySection {
//    
//    var header: String
//    var items: [SectionItem]
//    
//    init(header: String, items: [SectionItem]) {
//        
//        self.header = header
//        self.items = items
//    }
//}
//
//struct PropertySection {
//    
//    var header: String
//    var items: [SectionItem]
//    
//    init(header: String, items: [SectionItem]) {
//        
//        self.header = header
//        self.items = items
//    }
//}

struct GenericSection {
    
    var header: String
    var items: [SectionItem]
    
    init(header: String, items: [SectionItem]) {
        
        self.header = header
        self.items = items
    }
}

////////////////////
// ITEMS DEFINITIONS

struct GenericItem {
    
    var cellConfigurator: CellConfigurator
    
    init(cellConfigurator: CellConfigurator) {
        self.cellConfigurator = cellConfigurator
    }
}
