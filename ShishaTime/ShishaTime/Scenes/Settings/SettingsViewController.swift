//
//  SettingsViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 11/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var headerView: EliHeaderView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.headerView.title = "Settings"
        self.headerView.setCenteredTitle()
        self.headerView.backgroundColor = .white
        
        userImage.layer.cornerRadius = 75
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.borderWidth = 1
        
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        
        infoView.layer.cornerRadius = 20
        infoView.layer.borderColor = UIColor.black.cgColor
        infoView.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let defaults = UserDefaults()
        if let image = defaults.object(forKey: "image_url"){
            setLogo(url: image as! String)
        }
        
        if let email = defaults.object(forKey: "email"){
            self.userEmail.text = email as? String
        }
    }
    
    private func setLogo(url: String){
        DispatchQueue.global().async { [weak self] in
            
            guard let imageUrl = URL(string: url) else {return}
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.userImage.image = image
                    }
                }
            }
        }
    }
}
