//
//  LoginViewController.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 27/05/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController , GIDSignInDelegate{
    
    @IBOutlet weak var gButton: GIDSignInButton!
    
    
    override func viewDidLoad() {

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Automatically sign in the user.
       // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        
        
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        let vc = MainTabController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
        
        GoogleSignInManager().saveUser(user: user)
        
        let vc = MainTabController()
        self.navigationController?.pushViewController(vc, animated: true)
     
    }
    
 
}
