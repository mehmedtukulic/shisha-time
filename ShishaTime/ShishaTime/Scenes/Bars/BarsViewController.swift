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

//MODEL
struct User : Decodable{
    var id : Int?
    var name : String?
    var location : String?
  //  var email : String?
   // var phone : String?
   // var website : String?
    
}

class BarsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var Users = [User]()
    
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
                self.Users = try usersdecoder.decode([User].self, from : data!)
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
        return Users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath)
        let mycell = cell as! BarCell
        
        if Users.count > 0 {
            let bar = Users[indexPath.row]
            mycell.setup(bar: bar)
            return mycell
            
        }
        return mycell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let secondVC = BarDetailsViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
}
