//
//  Constants.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/13/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import Foundation

struct Constants {
    
    struct YQL {
        
        static let SymbolLookUpURL = "http://d.yimg.com/autoc.finance.yahoo.com/autoc"
        
        static let Format = "json"
        
        static let Callback = "YAHOO.Finance.SymbolSuggest.ssCallback"
        
        static let Env = "store://datatables.org/alltableswithkeys"
        
        static let PriceLookUpURL = "https://query.yahooapis.com/v1/public/yql"
        
    }
    
}