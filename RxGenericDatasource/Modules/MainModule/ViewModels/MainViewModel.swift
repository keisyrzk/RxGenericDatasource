//
//  MainViewModel.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

class MainViewModel {
    
    static func generateSection(header: String?, items: [CellConfigurator]) -> MultipleSectionModel {
        
        var sectionItems: [SectionItem] = []
        items.forEach { (cellConfigurator) in
            sectionItems.append(.GenericItem(cellConfigurator: cellConfigurator))
        }
        
        return MultipleSectionModel.GenericSection(header: header ?? "", items: sectionItems)
    }
}
