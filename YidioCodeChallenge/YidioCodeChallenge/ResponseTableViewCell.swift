//
//  ResponseTableViewCell.swift
//  YidioCodeChallenge
//
//  Created by Luke Solomon on 11/2/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var viewableIcon: UIImageView!
    
    
    
    
    var title:String! {
        didSet{
            titleLabel.text = title
        }
    }
    
    var subTitle:String!{
        didSet{
            subTitleLabel.text = subTitle
        }
    }
    
    var posterImageData:NSData!{
        didSet{
            
        }
    }
    
}
