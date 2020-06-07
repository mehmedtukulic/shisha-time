//
//  BarDetailsViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class BarDetailsViewController: UIViewController {
    
    @IBOutlet weak var panoramaImageView: UIImageView!
    @IBOutlet weak var barLogo: UIImageView!
    @IBOutlet weak var barOpenStatus: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupLabels()
        
    }
    
    func setupLabels(){
        
        barLogo.layer.cornerRadius = barLogo.frame.size.width / 2
        barLogo.clipsToBounds = true
        
        
        barOpenStatus.layer.cornerRadius = 4
        barOpenStatus.layer.borderColor = UIColor.white.cgColor
        barOpenStatus.layer.borderWidth = 1
    }
}
