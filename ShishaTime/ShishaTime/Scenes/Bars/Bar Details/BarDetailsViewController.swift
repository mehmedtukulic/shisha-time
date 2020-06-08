//
//  BarDetailsViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class BarDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var panoramaImageView: UIImageView!
    @IBOutlet weak var barLogo: UIImageView!
    @IBOutlet weak var barOpenStatus: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var address: UILabel!
    
    private var bar: Bar?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupLabels()
        setupTableView()
    }
    
    func setup(bar: Bar) {
        self.bar = bar
        
        }
    
    func setupTableView(){
        
        let xib = UINib(nibName: "BarInformationCellView", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "BarInformationCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
           
    }
    
    func setupLabels(){
        
        self.barName.text = bar?.name
        self.address.text = bar?.location

        
        barLogo.layer.cornerRadius = barLogo.frame.size.width / 2
        barLogo.clipsToBounds = true
        
        
        barOpenStatus.layer.cornerRadius = 4
        barOpenStatus.layer.borderColor = UIColor.white.cgColor
        barOpenStatus.layer.borderWidth = 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarInformationCell", for: indexPath)
        let mycell = cell as! BarInformationCell
        mycell.setup(bar: self.bar!, row: indexPath.row)
        return mycell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
}
