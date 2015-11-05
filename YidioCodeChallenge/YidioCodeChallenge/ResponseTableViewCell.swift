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
    
    
    var isItViewable:Bool! {
        didSet{
            if isItViewable == true {
                viewableIcon.hidden = true
            } else if isItViewable == false {
                viewableIcon.hidden = false
            }
        }
    }
    
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
    
    var cellImageURL:NSURL! {
        didSet {
            posterImageView.image = nil
            
            posterImageView.setImageWithURL(cellImageURL)
        }
    }
}
