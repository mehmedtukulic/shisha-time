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
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: EliHeaderView!
    
    private var scrollingTimer: Timer? = nil
    var imagesArray : [String]?
    var imageIndex = 0
    var adds = [Add]()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        self.headerView.title = "Home"
        self.headerView.setCenteredTitle()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        getAdds()
        setupCollectionView()
        scrollingTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: (#selector(startTimer)), userInfo: nil, repeats: true)
    }
    
    
    func setupCollectionView(){
        let xib = UINib(nibName: "MarketingCellView", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "MarketingCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func getAdds(){
        //Fetching and Decoding JSON
       // https://jsonplaceholder.typicode.com/users
        
        AF.request("https://shisha-time.herokuapp.com/public/adds").responseJSON { (response) in
            let data = response.data
            let usersdecoder  = JSONDecoder()
            
            do {
                self.adds = try usersdecoder.decode([Add].self, from : data!)
                let homeAdd = Add(bar_name: "", Image_url: "shishaHome")
                self.adds.insert(homeAdd, at: 0)
                self.collectionView.reloadData()
                
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        adds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketingCell", for: indexPath) as! MarketingCell
        
        cell.setImage(for: adds[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            if let bar_name = adds[indexPath.row].bar_name {
                getBar(barName: bar_name)
            }
        }
       
    }
    
    @objc func startTimer() {
        UIView.animate(withDuration: 1.0 , delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.scrollToItem(at: IndexPath(row: self.imageIndex, section: 0), at: .centeredHorizontally, animated: false)
        }, completion: nil)
        
        if imageIndex == adds.count {
            self.imageIndex = 0
        } else {
            self.imageIndex = imageIndex + 1
        }
    }
    
    
}
