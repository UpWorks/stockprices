//
//  NetworkManager.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/13/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias JsonCompletionHandler = (JSON: JSON?, error: NSError?) -> ()

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
    
    func findSymbol(searchTerm: String!, completionHandler: JsonCompletionHandler!)
    {
        
        Alamofire.request(.GET, Constants.YQL.SymbolLookUpURL, parameters: ["query" : searchTerm, "callback" : "YAHOO.Finance.SymbolSuggest.ssCallback"]).responseString
            {
                (request,response,data,error) in
                
                var quote = data!
                
                var quoteB = quote[advance(quote.startIndex, 39)..<quote.endIndex]
                
                let range = advance(quoteB.endIndex, -1)..<quoteB.endIndex
                
                quoteB.removeRange(range)
                
                if let dataFromString = quoteB.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                    
                    let json = JSON(data: dataFromString)
                    completionHandler(JSON: json, error: nil)
                }
                
            }
    }

    func getPricing(symbol: String!, completionHandler: JsonCompletionHandler!)
    {
        
        let query = "select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20(%22"+symbol+"%22)"
        
        let format = "json"
        
        let env = "store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    
        
        Alamofire.request(.GET, Constants.YQL.PriceLookUpURL, parameters: ["query" : query, "format" : "json", "env" : env]).responseJSON
            {
                (request,response,data,error) in
                
                if data != nil
                {
                    let json = JSON(data!)
                    completionHandler(JSON: json, error: nil)
                }
                else
                {
                   // Let user know error in price data retrieval
                }
                
        }
    }
}
