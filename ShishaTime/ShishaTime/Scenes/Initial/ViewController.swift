//
//  ViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 27/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc = LoginViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }


}

