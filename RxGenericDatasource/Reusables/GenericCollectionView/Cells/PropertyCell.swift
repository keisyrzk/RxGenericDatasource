//
//  PropertyCell.swift
//  RxDatasourceTest
//
//  Created by Esteban on 11.06.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

class PropertyCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var data: Property? = nil
    
    func configure(data: Property) {
        
        self.data = data
        typeLabel.text = data.type.rawValue
        priceLabel.text = data.price
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
