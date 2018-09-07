//
//  CustomTableView.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class CustomTableView: UITableView {

    private let localBag = DisposeBag()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 140
        
        handleRx()
    }

    static func seupDatasource() -> RxTableViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxTableViewSectionedReloadDataSource<MultipleSectionModel>(configureCell: { (datasource, table, idxPath, item) in
            switch datasource[idxPath] {
                
            case let .GenericItem(cellConfigurator: cellConfigurator):
                let cell = table.dequeueReusableCell(withIdentifier: type(of: cellConfigurator).reuseId)!
                cellConfigurator.configure(cell: cell)
                
                return cell
            }
        },
            titleForHeaderInSection: { datasource, index in
            let section = datasource[index]
            return section.header
        })
    }
    
    func handleRx() {
        
        self.rx.itemSelected
            .subscribe(onNext: { (idxPath) in
                if let selectedCell = self.cellForRow(at: idxPath) {
                    print("CHOSEN CELL:  \(selectedCell.classForCoder)")
                }
            })
        .disposed(by: localBag)
        
        self.rx.modelSelected(SectionItem.self)
            .subscribe(onNext: { (sectionItem) in
                switch sectionItem {
                    
                case let .GenericItem(cellConfigurator: cellConfigurator):
                    let gotCell = cellConfigurator.getCell()
                    
                    if gotCell.isKind(of: CityCell.self) {
                        print((gotCell as! CityCell).data?.name)
                    }
                    if gotCell.isKind(of: PropertyCell.self) {
                        print((gotCell as! PropertyCell).data?.type.rawValue)
                    }
                }
            })
        .disposed(by: localBag)
    }
}
