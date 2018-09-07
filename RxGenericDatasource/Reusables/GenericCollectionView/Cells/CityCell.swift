//
//  CityCell.swift
//  RxDatasourceTest
//
//  Created by Esteban on 11.06.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet weak var cityimage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var data: City? = nil
    
    func configure(data: City) {
        
        self.data = data
        cityLabel.text = data.name
        cityimage.getImage(from: data.image)
    }
    
    override func prepareForReuse() {
        cityimage.image = UIImage(named: "cityDefault")
        cityLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
