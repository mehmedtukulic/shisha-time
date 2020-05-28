//
//  HomeViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        let vc = BarDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
