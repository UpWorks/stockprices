//
//  StockPriceModel.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/15/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import Foundation

class StockPriceModel: NSObject, Printable {
    
    let symbol: String
    let averageDailyVolume: String
    let change: String
    let daysLow: String
    let daysHigh: String
    let yearLow: String
    let yearHigh: String
    let marketCapitalization: String
    let lastTradePriceOnly: String
    let daysRange: String
    let name: String
    let symbolb: String
    let volume: String
    let stockExchange: String
    
    override var description: String {
        return "Symbol: \(symbol), AverageDailyVolume: \(averageDailyVolume), Change: \(change), DaysLow: \(daysLow), DaysHigh: \(daysHigh), YearLow: \(yearLow), YearHigh: \(yearHigh), MarketCapitalization: \(marketCapitalization), LastTradePriceOnly: \(lastTradePriceOnly), DaysRange: \(daysRange), Name: \(name), Symbol: \(symbol), Volume: \(volume), StockExchange: \(stockExchange),\n"
    }
    
    init(symbol: String?, averageDailyVolume: String?, change: String?, daysLow: String?, daysHigh: String?, yearLow: String?, yearHigh: String?, marketCapitalization: String?, lastTradePriceOnly: String?, daysRange: String?, name: String?, symbolb: String?, volume: String?, stockExchange: String?)
    {
        self.symbol = symbol ?? ""
        self.averageDailyVolume = averageDailyVolume ?? ""
        self.change = change ?? ""
        self.daysLow = daysLow ?? ""
        self.daysHigh = daysHigh ?? ""
        self.yearLow = yearLow ?? ""
        self.yearHigh = yearHigh ?? ""
        self.marketCapitalization = marketCapitalization ?? ""
        self.lastTradePriceOnly = lastTradePriceOnly ?? ""
        self.daysRange = daysRange ?? ""
        self.name = name ?? ""
        self.symbolb = symbolb ?? ""
        self.volume = volume ?? ""
        self.stockExchange = stockExchange ?? ""
    }
}
