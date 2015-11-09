//
//  CoachMarkView.swift
//  YidioCodeChallenge
//
//  Created by Luke Solomon on 11/6/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

import UIKit


@IBDesignable
class CoachMarkView: UIView {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var view: UIView!
//    @IBOutlet weak var boxView: UIView!
//    @IBOutlet weak var barView: UIView!
    
    
//    class func instanceFromNib() -> UIView {
//        
//        return UINib(nibName: "CustomDialogueView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
//    }
    
    @IBAction func okButtonTapped(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.alpha = 0
            }, completion: { finished in
            self.removeFromSuperview()

        })
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
//        setup()
        xibSetup()
    }
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
//        setup()
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomDialogueView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        
        
        return view
    }

    
}
