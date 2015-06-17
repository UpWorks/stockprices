//
//  NetworkManager.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/13/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import Foundation
import CoreData
import Alamofire
import SwiftyJSON


typealias ObjectsCompletionHandler = (objects: [AnyObject]?, error: NSError?) -> ()

public class NetworkManager
{
    public class var sharedInstance: NetworkManager
    {
        struct Singleton
        {
            static let instance = NetworkManager()
        }
        
        return Singleton.instance
    }
    
    func findSymbol(searchTerm: String!, completionHandler: ObjectsCompletionHandler!)
    {
        
        Alamofire.request(.GET, Constants.YQL.SymbolLookUpURL, parameters: ["query" : searchTerm, "callback" : Constants.YQL.Callback]).responseString
            {
                (request,response,data,error) in
                
                var quote = data!
                
                var quoteB = quote[advance(quote.startIndex, 39)..<quote.endIndex]
                
                let range = advance(quoteB.endIndex, -1)..<quoteB.endIndex
                
                quoteB.removeRange(range)
                
                if let dataFromString = quoteB.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                {
                   
                    let json = JSON(data: dataFromString)
                    
                    if let resultsArray = json["ResultSet"]["Result"].array {
                        
                        var searchResults = [SymbolResultModel]()
                        
                        for resultsDict in resultsArray {
                            
                            var symbol: String? = resultsDict["symbol"].string
                            var name: String? = resultsDict["name"].string
                            var exch: String? = resultsDict["exch"].string
                            var type: String? = resultsDict["type"].string
                            var exchDisp: String? = resultsDict["exchDisp"].string
                            var typeDisp: String? = resultsDict["typeDisp"].string
                            
                            var result = SymbolResultModel(symbol: symbol, name: name, exch: exch, type: type, exchDisp: exchDisp, typeDisp: typeDisp)
                            
                            searchResults.append(result)
                            
                            completionHandler(objects: searchResults, error: nil)
                            
                        }
                    }
                    
                }
                
            }
    }

    func getPricing(thisSymbol: String!)
    {
        
        let query = "select * from yahoo.finance.quote where symbol in (\"" + thisSymbol + "\")"
    
        Alamofire.request(.GET, Constants.YQL.PriceLookUpURL, parameters: ["q" : query, "format" : Constants.YQL.Format, "env" : Constants.YQL.Env]).responseJSON
            {
                (request,response,data,error) in
                
                if data != nil
                {
                    let json = JSON(data!)
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    
                    let managedContext = appDelegate.managedObjectContext!
                    
                    let entity =  NSEntityDescription.entityForName("Stock", inManagedObjectContext: managedContext)
                    
                    let stock = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
                    
                    stock.setValue(json["query"]["results"]["quote"]["Name"].string, forKey: "name")
                    
                    stock.setValue(json["query"]["results"]["quote"]["LastTradePriceOnly"].string, forKey: "lasttradepriceonly")
                    
                    var error: NSError?
                    if !managedContext.save(&error) {
                        println("Could not save \(error), \(error?.userInfo)")
                    }
                }
                else
                {
                   // Let user know error in price data retrieval
                }
                
        }
    }
}
