
//
//  NetworkHelper.swift
//  YidioCodeChallenge
//
//  Created by Luke Solomon on 11/5/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelper {
    
    class func getRequestFromAPIWithSearchString (searchString:String, onComplete: NSArray -> Void) {
        
        if searchString == "" {
            return
        }
        
        let URLString = NSURL(string:"http://api.yidio.com/search/complete/" + searchString + "/0/10?device=iphone&api_key=8482068393681760")
        
        Alamofire.request(.GET, URLString! , parameters: nil).responseJSON { response in
            if let JSON = response.result.value {
                
//                print (JSON.objectForKey("response")!)
                
                if let responseArray = JSON.objectForKey("response") as? NSArray {
                    onComplete(responseArray)
                }
            }
        }
    }
}