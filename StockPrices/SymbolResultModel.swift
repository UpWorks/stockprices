//
//  SymbolResultModel.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/15/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import Foundation

class SymbolResultModel: NSObject, Printable {
    
    let symbol: String
    let name: String
    let exch: String
    let type: String
    let exchDisp: String
    let typeDisp: String
    
    override var description: String {
        return "Symbol: \(symbol), Name: \(name), Exch: \(exch), Type: \(type), ExchDisp: \(exchDisp), TypeDisp: \(typeDisp)\n"
    }
    
    init(symbol: String?, name: String?, exch: String?, type: String?, exchDisp: String?, typeDisp: String?)
    {
        self.symbol = symbol ?? ""
        self.name = name ?? ""
        self.exch =  exch ?? ""
        self.type =  type ?? ""
        self.exchDisp =  exchDisp ?? ""
        self.typeDisp =  typeDisp ?? ""
        
    }
}