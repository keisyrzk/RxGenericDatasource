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
        
        collectionViewModel = CollectionViewModel(collection: tableView)
        
        let krakowProperties = fetchedData.filter{ $0.name == "Kraków" }.first?.property
        let sections: [MultipleSectionModel] = [collectionViewModel.generateSection(header: "All fetched data", from: [fetchedData]),
                                                collectionViewModel.generateSection(header: "Only Krakow properties", from: [krakowProperties!])
                                               ]
        
        let datasource = CustomTableView.seupDatasource()
        
        Observable.just(sections)
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: mainBag)
    }
}
