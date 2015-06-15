//
//  StockCell.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/14/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class StockCell: UITableViewCell {

    @IBOutlet var stockNameLabel: UILabel?
    @IBOutlet var lastPriceLabel: UILabel?
    
    var stock: NSManagedObject?
    {
        didSet
        {
            println(self.stock)
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        println("in stock cell")
        
        self.stockNameLabel?.text = nil
        self.lastPriceLabel?.text = nil
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.stockNameLabel?.text = nil
        self.lastPriceLabel?.text = nil
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure()
    {
        if let constStock = stock
        {
            println(stock)
            var stockName = constStock.valueForKey("name") as! String
            var lastPrice = constStock.valueForKey("lasttradepriceonly") as! String
            self.stockNameLabel!.text = stockName
            self.lastPriceLabel!.text = lastPrice
        }
        else
        {
            // Alert user to issue
        }
    }
    
}
