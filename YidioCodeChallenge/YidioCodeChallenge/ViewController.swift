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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var responseArray = []
    var isGetRequestDone:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lukesColor = UIColor(red: 59/255, green: 60/255, blue: 63/255, alpha: 1.0)
        
        self.searchBar.barTintColor = lukesColor
        self.searchBar.backgroundColor = lukesColor
        self.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        
//        let searchIconImage = UIImage(named: <#T##String#>)
//        searchBar.setImage(searchIconImage, forSearchBarIcon: .Search, state: .Normal)
        
        let searchTextField = searchBar.valueForKey("_searchField") as! UITextField
//        searchTextField.font = UIFont(name: "HelveticaNeue-Light", size: 21)
        searchTextField.textColor = UIColor.whiteColor()
        
        self.tableView.backgroundColor = lukesColor
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let searchBarEncodedText = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        NetworkHelper.getRequestFromAPIWithSearchString(searchBarEncodedText!) { (responseArray) -> Void in
            self.responseArray = responseArray
            self.tableView.reloadData()
            self.view.endEditing(true)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        NetworkHelper.getRequestFromAPIWithSearchString(searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!)
//    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("5")

        let cell:ResponseTableViewCell = tableView.dequeueReusableCellWithIdentifier("ResponseCell", forIndexPath: indexPath) as! ResponseTableViewCell
        
        var currentDict:Dictionary = responseArray.objectAtIndex(indexPath.row) as! [String:AnyObject]
        let cellString:String = currentDict["name"] as! String
        var cellSubTitleString:String = ""
        var cellType:String?
        
        cell.isItViewable = true
        
        if currentDict["type"] as! String == "show" {
            cellSubTitleString = "TV Show" + " (\(currentDict["year"] as! String))"
            cellType = "tv"
        }
        else if currentDict["type"] as! String == "movie" {
            if currentDict["year"] as! String != "" {
                cellSubTitleString = "Movie" + " (\(currentDict["year"] as! String))"

            } else {
                cellSubTitleString = "Movie"
            }
            cellType = "movie"
        }
        else if currentDict["type"] as! String == "episode" {
            cellSubTitleString = "Episode · " + "Title of the Show" + " (\(currentDict["year"] as! String))"
            cellType = "episode"
        }
        else if currentDict["type"] as! String == "clip" {
        
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