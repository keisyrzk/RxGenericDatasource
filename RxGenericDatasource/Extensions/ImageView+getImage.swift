//
//  ImageView+getImage.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImage(from url: String) {
        if url != "" {
            let imgURL: URL = URL(string: url)!
            let request: URLRequest = URLRequest(url: imgURL)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                guard error == nil, let imageData = data, let imageItem = UIImage(data: imageData) else {
                    // Fail
                    DispatchQueue.main.async(execute: {
                        self.image = UIImage(named: "cityDefault")
                    })
                    
                    return
                }
                // Successful
                DispatchQueue.main.async(execute: {
                    self.image = imageItem
                })
            })
            task.resume()
        } else {
            // Fail
            DispatchQueue.main.async(execute: {
                self.image = UIImage(named: "cityDefault")
            })
            
            return
        }
    }
}
