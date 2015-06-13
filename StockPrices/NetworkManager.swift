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
    
}
