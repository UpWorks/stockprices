//
//  SearchViewController.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/15/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    @IBOutlet var searchBar: UISearchBar?
    @IBOutlet var tableView: UITableView?
    
    var searchResults = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        var nib = UINib(nibName: "SymbolCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: "SymbolCellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchBar.text = ""
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        var searchTerm = searchBar.text
        
        NetworkManager.sharedInstance.findSymbol(searchTerm, completionHandler: {
            (object, error) -> () in
            
            if let constResults = object
            {
                self.searchResults = constResults
                self.tableView?.reloadData()
                
            }
            else if let constError = error
            {
                //alert the user
            }
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("SymbolCellIdentifier") as! SymbolCell
        var symbol = searchResults[indexPath.row] as! SymbolResultModel
        
        cell.symbol = symbol
        
        return cell
    }
}
