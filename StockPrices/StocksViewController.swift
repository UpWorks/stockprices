//
//  StocksViewController.swift
//  StockPrices
//
//  Created by Michael Updegraff on 1/31/15.
//

import UIKit
import CoreData
import Alamofire

class StocksViewController: UITableViewController, UITableViewDataSource {
  
  var stocks = [NSManagedObject]()
  
  var requestName = [String]()
  //
  var requestPrice = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    let managedContext = appDelegate.managedObjectContext!

    let fetchRequest = NSFetchRequest(entityName:"Stock")

    var error: NSError?
    
    let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
    
    if let results = fetchedResults {
      stocks = results
    } else {
      println("Could not fetch \(error), \(error!.userInfo)") }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stocks.count
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
      let managedContext = appDelegate.managedObjectContext!
    
      let stockToRemove = stocks[indexPath.row]
      stocks.removeAtIndex(indexPath.row)

      managedContext.deleteObject(stockToRemove)

    var error: NSError?
    if !managedContext.save(&error) {
      println("Could not save: \(error)")
    }
    
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    self.tableView.reloadData()
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("StockCell") as UITableViewCell
    
    let stock = stocks[indexPath.row]
    cell.textLabel!.text = stock.valueForKey("name") as String?
    cell.detailTextLabel!.text = stock.valueForKey("lasttradepriceonly") as String?
    
    return cell
  }
  

  @IBAction func addStock(sender: AnyObject) {
    
    var alert = UIAlertController(title: "New stock",
        message: "Add a new Stock",
        preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
  

      let textField = alert.textFields![0] as UITextField
      
      self.saveStock(textField.text)
      
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
    }
    
    alert.addTextFieldWithConfigurationHandler {
        (textField: UITextField!) -> Void in
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    presentViewController(alert,
          animated: true,
          completion: nil)
  }
  
  
  func saveStock(name: String) {
      
      let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
      
      let managedContext = appDelegate.managedObjectContext!

      let entity =  NSEntityDescription.entityForName("Stock", inManagedObjectContext: managedContext)
      
      let stock = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
      
      let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20(%22"+name+"%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
      
      Alamofire.request(.GET, url).responseJSON() {
        (_, _, data, _) in

        let quote = data?.objectForKey("query")?.objectForKey("results")?.objectForKey("quote") as? NSDictionary
        
        let name = quote?.objectForKey("Name") as? String
      
        let price = quote?.objectForKey("LastTradePriceOnly") as? String

        stock.setValue(name, forKey: "name")
      
        stock.setValue(price, forKey: "lasttradepriceonly")
      
        self.stocks.append(stock)
      
        self.tableView.reloadData()
      
        var error: NSError?
        if !managedContext.save(&error) {
          println("Could not save \(error), \(error?.userInfo)")
        }
      }
      
  }
  
  
}
