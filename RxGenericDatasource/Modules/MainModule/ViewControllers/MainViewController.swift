//
//  MainViewController.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//


import UIKit
import RxDataSources
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var collectionViewModel: CollectionViewModel!
    let mainBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
    }
    
    func fetchData() {
        
        Services.getCities()
            .subscribe(onNext: { [weak self] (cities) in
                DispatchQueue.main.async(execute: {
                    self?.setupCollectionView(fetchedData: cities)
                })
            }, onError: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: mainBag)
    }
    
    func setupCollectionView(fetchedData: [City]) {
        
        collectionViewModel = CollectionViewModel(collection: tableView, cityData: fetchedData)
        
        let sections: [MultipleSectionModel] = [MainViewModel.generateSection(header: "CITIES",
                                                                              items: collectionViewModel.generateItems(types: [.Cities])),
                                                MainViewModel.generateSection(header: nil,
                                                                              items: collectionViewModel.generateItems(types: [.Cities, .Properties]))
        ]
        
        let datasource = MainViewController.seupDatasource()
        
        Observable.just(sections)
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: mainBag)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
}

extension MainViewController {
    
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
}
