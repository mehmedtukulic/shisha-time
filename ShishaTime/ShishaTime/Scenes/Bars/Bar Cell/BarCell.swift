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
  //  @IBOutlet weak var barOpenStatus: UIView!
   // @IBOutlet weak var containerView: UIView!
    
    func setup(bar: User){
        barImage.image = UIImage(named: "twitter")
        barTitle.text = bar.name
        barLocation.text = bar.location
      //  barOpenStatus.backgroundColor = UIColor.green
        
        
    /*    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
        barOpenStatus.layer.cornerRadius = 4
        barOpenStatus.layer.borderColor = UIColor.white.cgColor
        barOpenStatus.layer.borderWidth = 1
        
        containerView.layer.cornerRadius = 0
        containerView.backgroundColor = UIColor.white
        */
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.height = 80
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        
    }
}
