//
//  CellConfigurator.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    func getCell() -> UIView
}

class CollectionCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    static var reuseId: String { return String(describing: CellType.self) }
    
    let item: DataType
    var cell: CellType? = nil
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
        self.cell = (cell as! CellType)
    }
    
    func getCell() -> UIView {
        return self.cell!
    }
}
