//
//  BarInformationCell.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 07/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class BarInformationCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    
    func setup(bar: Bar, row: Int) {
        
        switch row {
        case 0:
            icon.image = UIImage(named: "emailIcon")
            label.text = bar.email_address
        case 1:
            icon.image = UIImage(named: "phoneIcon")
            label.text = bar.contact
        case 2:
            icon.image = UIImage(named: "websiteIcon")
            label.text = bar.web_address
        case 3:
        icon.image = UIImage(named: "facebookIcon")
        label.text = "Facebook"
        case 4:
        icon.image = UIImage(named: "instaIcon")
        label.text = "Instagram"
        default:
            break
        }
    }
}
