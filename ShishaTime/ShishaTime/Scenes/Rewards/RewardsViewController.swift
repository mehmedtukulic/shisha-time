//
//  RewardsViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RewardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var rewards = [Giveaway]()
    var dayName = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: EliHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.headerView.title = "Rewards"
        self.headerView.setCenteredTitle()
        self.headerView.backgroundColor = .white

        setupTableView()
        
        let day = Date().dayNumberOfWeek()
        setDayName(day: day!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        getRewards()
    }
    
    func setupTableView(){
        
        let xib = UINib(nibName: "RewardCellView", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "RewardCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
    }
    
    func setDayName(day: Int){
        switch day {
        case 1:
            self.dayName = "Ponedeljak"
        case 2:
            self.dayName = "Utorak"
        case 3:
            self.dayName = "Srijeda"
        case 4:
            self.dayName = "Cetvrtak"
        case 5:
            self.dayName = "Petak"
        case 6:
            self.dayName = "Subota"
        case 7:
            self.dayName = "Nedelja"
        default:
             return
        }
    }
    
    func getRewards(){
        
        AF.request("https://shisha-time.herokuapp.com/public/giveaways/\(self.dayName)").responseJSON { (response) in
            let data = response.data
            let usersdecoder  = JSONDecoder()
            
            do {
                self.rewards = try usersdecoder.decode([Giveaway].self, from : data!)
                self.tableView?.reloadData()
                
            } catch {
                print("Error decoding Bars : \(error.localizedDescription)")
            }
            
        }
    }
    
    func getBar(barName: String){

        let url = "https://shisha-time.herokuapp.com/public/bar/\(barName)"
        AF.request(url).responseJSON { (response) in
            let data = response.data
            let usersdecoder  = JSONDecoder()
            
            do {
                let bars = try usersdecoder.decode([Bar].self, from : data!)
                let vc = BarDetailsViewController()
                vc.setup(bar: bars.first!)
                self.navigationController?.pushViewController(vc, animated: true)
                
            } catch {
                print("Error decoding Bar : \(error.localizedDescription)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rewards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath)
        let mycell = cell as! RewardCell
        if rewards.count > 0 {
            let reward = rewards[indexPath.row]
            mycell.setup(reward: reward)
            return mycell

        }

        return mycell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let bar_name = rewards[indexPath.row].bar_name {
            getBar(barName: bar_name)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
