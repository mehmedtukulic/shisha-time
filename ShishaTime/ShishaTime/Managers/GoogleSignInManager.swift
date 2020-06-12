//
//  GoogleSignInManager.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 06/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import GoogleSignIn
class GoogleSignInManager {
    
    func saveUser(user: GIDGoogleUser){
        let defaults = UserDefaults()
        
        let userId = user.userID
        let idToken = user.authentication.idToken
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        var imageURL = ""
        if user.profile.hasImage {
            imageURL = user.profile.imageURL(withDimension: 150).absoluteString
        }
        
        defaults.set(userId, forKey: "userID")
        defaults.set(idToken, forKey: "idToken")
        defaults.set(fullName, forKey: "fullName")
        defaults.set(givenName, forKey: "givenName")
        defaults.set(familyName, forKey: "familyName")
        defaults.set(email, forKey: "email")
        defaults.set(imageURL, forKey: "image_url")
        
    }
}
