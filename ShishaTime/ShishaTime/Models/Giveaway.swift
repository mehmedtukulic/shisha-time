//
//  Giveaway.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 11/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation

struct Giveaway : Decodable{
    var _id : String?
    var day : String?
    var bar_name : String?
    var status : String?
    var competitors : [String]?
    var winner : String?
}

