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
        
        collectionViewModel = CollectionViewModel(collection: tableView, cityData: fetchedData)
        
        let sections: [MultipleSectionModel] = [MainViewModel.generateSection(header: "CITIES",
                                                                              items: collectionViewModel.generateItems(types: [.Cities])),
                                                MainViewModel.generateSection(header: "CITIES 2",
                                                                              items: collectionViewModel.generateItems(types: [.Cities])),
                                                MainViewModel.generateSection(header: "CITIES 3",
                                                                              items: collectionViewModel.generateItems(types: [.Cities])),
                                                MainViewModel.generateSection(header: nil,
                                                                              items: collectionViewModel.generateItems(types: [.Cities, .Properties]))
        ]
        
        let datasource = CustomTableView.seupDatasource()
        
        Observable.just(sections)
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: mainBag)
    }
}
