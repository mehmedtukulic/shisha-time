//
//  BarCell.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 31/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit


class BarCell: UITableViewCell {
    
    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var barTitle: UILabel!
    @IBOutlet weak var barLocation: UILabel!
    @IBOutlet weak var barOpenStatus: UIView!
   // @IBOutlet weak var containerView: UIView!
    
    func setup(bar: Bar){
        setLogo(bar: bar)
        barTitle.text = bar.name
        barLocation.text = bar.location
      
        
        barOpenStatus.layer.cornerRadius = 4
        barOpenStatus.layer.borderColor = UIColor.white.cgColor
        barOpenStatus.layer.borderWidth = 1
        
        
        barImage.layer.cornerRadius = 20
        barImage.layer.borderColor = UIColor.white.cgColor
        barImage.layer.borderWidth = 1
    }
    
    
    private func setLogo(bar: Bar){
        DispatchQueue.global().async { [weak self] in
            
            guard let imageUrl = URL(string: (bar.bar_logo)!) else {return}
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.barImage.image = image
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.height = 80
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        
    }
}
