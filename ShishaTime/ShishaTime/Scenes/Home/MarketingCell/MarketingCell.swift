//
//  MarketingCell.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 10/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class MarketingCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    
    func setImage(for add: Add){
        
        if add.Image_url == "shishaHome" {
            image.image = UIImage(named: "shishaHome")
        }
        
        DispatchQueue.global().async { [weak self] in
            
            guard let imageUrl = URL(string: (add.Image_url)!) else {return}
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image.image = image
                    }
                }
            }
        }
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.height = contentView.frame.height
        self.frame.size.width = contentView.frame.width
        
    }

}
