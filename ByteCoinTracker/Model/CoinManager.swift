//
//  CoinManager.swift
//  ByteCoinTracker
//
//  Created by Atakan Çavuşlu on 28.06.2020.
//  Copyright © 2020 Atakan Çavuşlu. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DA5D619C-1DC7-4E71-8F68-FDCFCDA22446"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        
    }
    
}