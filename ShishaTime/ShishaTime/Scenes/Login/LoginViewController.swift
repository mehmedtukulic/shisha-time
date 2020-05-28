//
//  LoginViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 27/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: Any) {
        let vc = MainTabController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        print("loaded")
    }
}
