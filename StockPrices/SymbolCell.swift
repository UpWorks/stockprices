//
//  SymbolCell.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/15/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import CoreData
import Alamofire
import SwiftyJSON
import UIKit

class SymbolCell: UITableViewCell {

    @IBOutlet var stockNameLabel: UILabel?
    @IBOutlet var stockSymbolLabel: UILabel?
    
    var symbol: SymbolResultModel?
    {
        didSet
        {
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.stockNameLabel?.text = nil
        self.stockSymbolLabel?.text = nil
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.stockNameLabel?.text = nil
        self.stockSymbolLabel?.text = nil
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure()
    {
        if let constSymbol = symbol
        {
            //println(symbol)
            //var stockName = constStock.valueForKey("name") as! String
            //var lastPrice = constStock.valueForKey("lasttradepriceonly") as! String
            self.stockNameLabel!.text = symbol?.name
            self.stockSymbolLabel!.text = symbol?.symbol
        }
        else
        {
            // Alert user to issue
        }
    }
}
