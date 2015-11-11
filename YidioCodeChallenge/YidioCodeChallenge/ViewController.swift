//
//  ViewController.swift
//  YidioCodeChallenge
//
//  Created by Luke Solomon on 10/31/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchIconImage: UIImageView!
    
    var responseArray = []
    var isGetRequestDone:Bool = true
    let DynamicView = CoachMarkView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let darkColor = UIColor(red: 31/255, green: 35/255, blue: 38/255, alpha: 1.0)
        let textFieldInteriorColor = UIColor(red: 78/255, green: 82/255, blue: 83/255, alpha: 1.0)
        
        self.tableView.backgroundColor = darkColor
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
//        let clearButton  = self.textField.valueForKey("clearButton")
//        clearButton!.setImage(UIImage(named: "ico-cancel"), forState: UIControlState.Normal)
//        clearButton!.setImage(UIImage(named: "ico-cancel"), forState: UIControlState.Highlighted)
//        
        self.textField.attributedPlaceholder = NSAttributedString(string: self.textField.placeholder!, attributes: [NSForegroundColorAttributeName: textFieldInteriorColor])
        
        self.clearButton.hidden = true
        
        DynamicView.backgroundColor = UIColor(red: 0/255, green: 123/255, blue: 255/255, alpha: 1)
        DynamicView.layer.cornerRadius = 20
        self.DynamicView.frame = CGRectMake(8, topBar.frame.height*1.3, 200, 120)
        self.view.addSubview(DynamicView)
        self.DynamicView.alpha = 0
        UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.DynamicView.alpha = 1
            self.DynamicView.frame = CGRectMake(8, self.topBar.frame.height*1.15, 200, 120)
        }, completion: { finished in
        })
    }
    
    func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func reupdateTableView () {
        self.textField.placeholder = "What do you want to watch?"
        self.responseArray = []
        self.tableView.reloadData()
        self.dismissKeyboard()
        self.activityIndicatorView.stopAnimating()
        self.clearButton.hidden = true
    }
    
    @IBAction func clearButtonPushed(sender: AnyObject) {
        self.textField.text = ""
        reupdateTableView()
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        self.DynamicView.removeFromSuperview()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.clearButton.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if self.activityIndicatorView.isAnimating() == false {
            self.activityIndicatorView.startAnimating()
            self.clearButton.hidden = true
        }

        if (textField.text == "") {
            reupdateTableView()
        }
        
        let searchBarEncodedText = textField.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        NetworkHelper.getRequestFromAPIWithSearchString(searchBarEncodedText!) { (responseArray) -> Void in
            self.responseArray = responseArray
            self.tableView.reloadData()
            self.activityIndicatorView.stopAnimating()
            self.clearButton.hidden = false
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.activityIndicatorView.stopAnimating()
        self.clearButton.hidden = false
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ResponseTableViewCell = tableView.dequeueReusableCellWithIdentifier("ResponseCell", forIndexPath: indexPath) as! ResponseTableViewCell
        
        var currentDict:Dictionary = responseArray.objectAtIndex(indexPath.row) as! [String:AnyObject]
        let cellString:String = currentDict["name"] as! String
        var cellSubTitleString:String = ""
        var cellType:String?
        
        cell.isItViewable = true
        
        if currentDict["type"] as! String == "show" {
            cellSubTitleString = "TV Show" + " (\(currentDict["year"] as! String))"
            cellType = "tv"
        } else if currentDict["type"] as! String == "movie" {
            if currentDict["year"] as! String != "" {
                cellSubTitleString = "Movie" + " (\(currentDict["year"] as! String))"
            } else {
                cellSubTitleString = "Movie"
            }
            cellType = "movie"
        } else if currentDict["type"] as! String == "episode" {
            cellSubTitleString = "Episode · " + "Title of the Show" + " (\(currentDict["year"] as! String))"
            cellType = "episode"
        } else if currentDict["type"] as! String == "clip" {
            //literally haven't even seen one yet. Am I using the API incorrectly?
        }
        
        if currentDict["available_on_device"] as! String == "1" {
            cell.isItViewable = false
        }

        cell.title = cellString
        cell.subTitle = cellSubTitleString
        
        let idString = responseArray.objectAtIndex(indexPath.row).objectForKey("id") as! String
        
        cell.cellImageURL = NSURL(string: "http://cf.yidio.com/images/" + cellType! + "/" + idString + "/poster-193x290.jpg")
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (1/8) * self.view.frame.height
    }
}

