//
//  CustomTextField.swift
//  YidioCodeChallenge
//
//  Created by Luke Solomon on 11/11/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//


import UIKit

class CustomTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    let inset: CGFloat = 10
    
    // placeholder position
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }
    
    // text position
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, insetX, insetY)
    }
}