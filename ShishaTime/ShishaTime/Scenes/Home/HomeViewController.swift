//
//  HomeViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
       self.navigationController?.navigationBar.topItem?.title = "Home"
       GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        let vc = BarDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
}
