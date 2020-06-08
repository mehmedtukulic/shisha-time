//
//  BarsViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class BarsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var Bars = [Bar]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Bars"
        setupTableView()
        getBars()
    }
    
    func setupTableView(){
        let xib = UINib(nibName: "BarCellView", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "BarCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
           
        
    }
    
    func getBars(){
        //Fetching and Decoding JSON
       // https://jsonplaceholder.typicode.com/users
        
        AF.request("https://shisha-time.herokuapp.com/public/bars").responseJSON { (response) in
            let data = response.data
            let usersdecoder  = JSONDecoder()
            
            do {
                self.Bars = try usersdecoder.decode([Bar].self, from : data!)
                self.tableView?.reloadData()
                
            } catch {
                print("Error decoding Users  : \(error.localizedDescription)")
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath)
        let mycell = cell as! BarCell
        
        if Bars.count > 0 {
            let bar = Bars[indexPath.row]
            mycell.setup(bar: bar)
            return mycell
            
        }
        return mycell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC = BarDetailsViewController()
        secondVC.setup(bar: Bars[indexPath.row])
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
}
