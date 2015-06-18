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
    @IBOutlet var addButton: UIButton?
    
    var priceResult: StockPriceModel?
    
    var symbol: SymbolResultModel?
    {
        didSet
        {
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addButton?.hidden = true
        self.stockNameLabel?.text = nil
        self.stockSymbolLabel?.text = nil
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.addButton?.hidden = true
        self.stockNameLabel?.text = nil
        self.stockSymbolLabel?.text = nil
        self.symbol = nil
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure()
    {
        if let constSymbol = symbol
        {
            self.stockNameLabel?.text = symbol!.name
            self.stockSymbolLabel?.text = "Symbol: " + symbol!.symbol
            
            self.addButton?.hidden = false
        }
        else
        {
            // Alert user to issue
        }
    }
    
    @IBAction func didTapAdd(sender: UIButton)
    {
       
        // Get Pricing
        // Add Stock to Core Data

        self.addButton?.enabled = false
        
        let thisSymbol = symbol!.symbol
        
        NetworkManager.sharedInstance.getPricing(thisSymbol)

        self.addButton?.enabled = true
        

    }
}
