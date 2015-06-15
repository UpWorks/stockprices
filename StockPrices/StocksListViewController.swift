//
//  StocksListViewController.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/14/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class StocksListViewController: UIViewController, UITableViewDataSource {

    var stocks = [NSManagedObject]()
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Stock")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        if let results = fetchedResults
        {
            stocks = results
        }
        else
        {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        var nib = UINib(nibName: "StockCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "StockCellIdentifier")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stocks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StockCellIdentifier") as! StockCell
        
        var stock = stocks[indexPath.row] as NSManagedObject
        
        cell.stock = stock
        
        return cell
    }

}
