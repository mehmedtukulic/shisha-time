//
//  BarDetailsViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 28/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import MessageUI
import SafariServices
import SDWebImage

class BarDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var panoramaImageView: UIImageView!
    @IBOutlet weak var barLogo: UIImageView!
    @IBOutlet weak var barOpenStatus: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeIcon: UIImageView!
    
    private var bar: Bar?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupLabels()
        setupTableView()
        setLocationOnMap()
        setImage()
        setLogo()
        setCloseButton()
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
        
        self.address.attributedText = NSAttributedString(string: (bar?.location)!, attributes:
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        
        barLogo.layer.cornerRadius = barLogo.frame.size.width / 2
        barLogo.clipsToBounds = true
        
        
        barOpenStatus.layer.cornerRadius = 4
        barOpenStatus.layer.borderColor = UIColor.white.cgColor
        barOpenStatus.layer.borderWidth = 1
    }
    
    private func setLogo(){
           DispatchQueue.global().async { [weak self] in
               
               guard let imageUrl = URL(string: (self?.bar?.bar_logo)!) else {return}
               if let data = try? Data(contentsOf: imageUrl) {
                   if let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self?.barLogo.image = image
                       }
                   }
               }
           }
       }
    
    private func setImage(){
        DispatchQueue.global().async { [weak self] in
            
            guard let imageUrl = URL(string: (self?.bar?.bar_image)!) else {return}
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.panoramaImageView.image = image
                    }
                }
            }
        }
    }
    
    private func setLocationOnMap() {
        let anottation = MKPointAnnotation()
        guard let latitude = bar?.lat else {return}
        guard let longitude = bar?.lng else {return}
        let center = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
        anottation.coordinate = center
        mapView.addAnnotation(anottation)
        mapView.centerCoordinate = center
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500), animated: false)
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openInMapApp))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func openInMapApp() {
        guard let lat1 = bar?.lat else {return}
        guard let lng1 = bar?.lng else {return}
        
        let latitude:CLLocationDegrees =  Double(lat1) ?? 0
        let longitude:CLLocationDegrees =  Double(lng1) ?? 0
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = bar?.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func sendEmail(to emailAddress: String) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailAddress])
            present(mail, animated: true)
        } else {
            print("Need actual device to send email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func call(phoneNumber: String) {
        guard let number = URL(string: "tel://\(phoneNumber)") else {return}
        UIApplication.shared.open(number)
    }
    
    private func openWebsiteUrl(url: String) {
        let prepackedUrl = url.contains("http") ? url : "https://\(url)"
        guard let websiteUrl = URL(string: prepackedUrl) else {return}
        let safariVC = SFSafariViewController(url: websiteUrl)
        present(safariVC, animated: true, completion: nil)
    }
    
    private func setCloseButton() {
        let closeImage = UIImage(named: "closeIcon2")?.withRenderingMode(.alwaysTemplate)
        self.closeIcon.image = closeImage
        self.closeIcon.tintColor = UIColor(red: 61.0 / 255.0, green: 179.0 / 255.0, blue: 195.0 / 255.0, alpha: 1.0)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Table view data source
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            guard let email = bar?.email_address else { return }
            sendEmail(to: email)
        case 1:
            guard let phoneNumber = bar?.contact else { return }
            call(phoneNumber: phoneNumber)
        case 2:
            openWebsiteUrl(url: "www.ibu.edu.ba")
        case 3:
            openWebsiteUrl(url: "www.facebook.com/ibueduba")
        case 4:
            openWebsiteUrl(url: "www.instagram.com/burchuniversity")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
