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
    
    @IBOutlet weak var tableView: CustomTableView!
    
    var tableViewModel: TableViewModel!
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
                    self?.setupTableView(fetchedData: cities)
                })
            }, onError: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: mainBag)
    }
    
    func setupTableView(fetchedData: [City]) {
        
        tableViewModel = TableViewModel(collection: tableView)
        
        let krakowProperties = fetchedData.filter{ $0.name == "Kraków" }.first?.property
        let sections: [MultipleSectionModel] = [tableViewModel.generateSection(header: "All fetched data", from: [fetchedData]),
                                                tableViewModel.generateSection(header: "Only Krakow properties", from: [krakowProperties!])
                                               ]
        
        let datasource = CustomTableView.seupDatasource()
        
        Observable.just(sections)
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: mainBag)
    }
}
