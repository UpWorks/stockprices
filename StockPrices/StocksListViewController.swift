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
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        var nib = UINib(nibName: "StockCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "StockCellIdentifier")
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Stock")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        if let results = fetchedResults
        {
            self.stocks = results
            self.tableView?.reloadData()
        }
        else
        {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stocks.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext!
            
            let stockToRemove = stocks[indexPath.row]
            stocks.removeAtIndex(indexPath.row)
            
            managedContext.deleteObject(stockToRemove)
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save: \(error)")
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView?.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StockCellIdentifier") as! StockCell
        
        var stock = stocks[indexPath.row] as NSManagedObject
        
        cell.stock = stock
        
        return cell
    }

}
