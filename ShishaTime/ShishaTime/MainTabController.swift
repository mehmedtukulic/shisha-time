//
//  MainTabController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

class MainTabController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }
    
    
    func setupTabBar(){
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(named: "homeIcon")
        
        let rewardsVC = UINavigationController(rootViewController: RewardsViewController())
        rewardsVC.tabBarItem.image = UIImage(named: "rewardsIcon")
        
        let barsVC = UINavigationController(rootViewController: BarsViewController())
        barsVC.tabBarItem.image = UIImage(named: "spotsIcon")
        
        viewControllers = [homeVC, rewardsVC , barsVC]
        
        guard let items = tabBar.items else {return}
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4,left: 0,bottom: -4,right: 0)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    }
    
   func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("klikno")
        if let vc = viewController as? UINavigationController {
            vc.popViewController(animated: true)
        }
    }
    
}
