//
//  RewardCell.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 11/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RewardCell: UITableViewCell {
    
    @IBOutlet weak var barLabel: UILabel!
    @IBOutlet weak var usersCount: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var fade: UIImageView!
    
    var reward: Giveaway?
    var userEmail = ""
    
    func setup(reward : Giveaway){
        self.reward = reward
        barLabel.text = reward.bar_name
        usersCount.text = "\(reward.competitors?.count ?? 0) / 20"
        
        
        enterButton.layer.cornerRadius = 17
        enterButton.layer.borderColor = UIColor.white.cgColor
        enterButton.layer.borderWidth = 1
        
        let defaults = UserDefaults()
        if let email = defaults.object(forKey: "email"){
            self.userEmail = email as! String
        }
        
        fade.contentMode = .scaleToFill
        fade.layer.cornerRadius = 10
        fade.layer.borderColor = UIColor.white.cgColor
        fade.layer.borderWidth = 1
        
        if reward.status == "done" {
            setupGiveawayDone()
        }
        setupRegistered()
    }
    
    func setupRegistered(){
        
        if self.reward?.competitors?.contains(userEmail) ?? false{
            
            self.bgView.backgroundColor = .systemGray5
            self.enterButton.isEnabled = false
            self.enterButton.setTitle("ALREADY ENTERED", for: .normal)
        }
        
    }
    
    func setupGiveawayDone(){
        self.usersCount.isHidden = true
        self.enterButton.isHidden = true
        self.winnerLabel.isHidden = false
        
        if let winner = self.reward?.winner {
            self.winnerLabel.text = "WINNER: \(winner)"
        }
        
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        registerUserForGiveaway()
    }
    
    func registerUserForGiveaway() {
        guard let giveawayId = self.reward?._id else { return }
        
        let path = "https://shisha-time.herokuapp.com/public/giveaway/\(giveawayId)/register/\(self.userEmail)"
        guard let url = URL(string: path) else { return }
        
        
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard response.data != nil else {
                return
            }
            
            if response.response?.statusCode == 200{
                self.newUserRegistered()
                print("Entered sucessfully")
            }
        }
    }
    
    func newUserRegistered(){
        self.usersCount.text = "\((self.reward?.competitors!.count)! + 1) / 20"
        self.enterButton.isEnabled = false
        self.enterButton.setTitle("ALREADY ENTERED", for: .normal)
        self.reward?.competitors?.append(self.userEmail)
        
        if self.reward?.competitors?.count == 20 {
            closeReward()
        }
    }
    
    func closeReward(){
        guard let giveawayId = self.reward?._id else { return }
        
        let randomNumber = Int.random(in: 0 ..< 20)
        guard let email = self.reward?.competitors?[randomNumber] else {return}
        
        let path = "https://shisha-time.herokuapp.com/public/addwinner/\(giveawayId)/\(email)"
        guard let url = URL(string: path) else { return }
        
        
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard response.data != nil else {
                return
            }
            
            if response.response?.statusCode == 200{
                self.usersCount.isHidden = true
                self.enterButton.isHidden = true
                self.winnerLabel.isHidden = false
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }

}
