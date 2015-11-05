//
//  Media.swift
//  YidioCodeChallenge
//
//  Created by Luke Solomon on 11/4/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

import Foundation
import JSONHelper

class Media: Deserializable {
    
    var type:String?
    var posterImageURL:NSURL?
    var id:String?
    var name:String?
    var year:String?
    var available_on_device:String?

    
    required init(data: [String: AnyObject]) {
        type <-- data["type"]
        posterImageURL <-- data["posterImageURL"]
        id <-- data["id"]
        name <-- data["name"]
        year <-- data["year"]
        available_on_device <-- data["available_on_device"]
    }

}