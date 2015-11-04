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
        
        self.tableView.backgroundColor = lukesColor
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.getRequestFromAPI()
    }
    
    
    func getRequestFromAPI (){
        
        isGetRequestDone = false
        
        Alamofire.request(.GET, "http://api.yidio.com/search/complete/Philadelphia/0/10?device=iphone&api_key=8482068393681760" , parameters: nil)
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    
                    self.responseArray = (JSON.objectForKey("response"))! as! NSArray
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.isGetRequestDone = true
                        self.tableView.reloadData()
                    })
                }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if isGetRequestDone == false {
            getRequestFromAPI()
        } else {
            
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        //
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (1/8) * self.view.frame.height
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ResponseTableViewCell = tableView.dequeueReusableCellWithIdentifier("ResponseCell", forIndexPath: indexPath) as! ResponseTableViewCell
        
        var currentDict:Dictionary = responseArray.objectAtIndex(indexPath.row) as! [String:AnyObject]
        let cellString:String = currentDict["name"] as! String
        var cellSubTitleString:String = ""
        
        cell.viewableIcon?.hidden = true
        
        if currentDict["type"] as! String == "show" {
            cellSubTitleString = "TV Show" + " (\(currentDict["year"] as! String))"

        } else if currentDict["type"] as! String == "movie" {
            cellSubTitleString = "Movie" + " (\(currentDict["year"] as! String))"
        }
        
        if currentDict["available_on_device"] as! String == "1" {
            cell.viewableIcon?.hidden = false
        }
        
        cell.title = cellString
        
        cell.subTitle = cellSubTitleString
        
        return cell
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return responseArray.count;
    }
    
}