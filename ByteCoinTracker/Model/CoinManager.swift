//
//  CoinManager.swift
//  ByteCoinTracker
//
//  Created by Atakan Çavuşlu on 28.06.2020.
//  Copyright © 2020 Atakan Çavuşlu. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didGetCoinRate(_ coinManager: CoinManager, rate: Double)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
    
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DA5D619C-1DC7-4E71-8F68-FDCFCDA22446"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                self.delegate?.didFailWithError(self, error: error!)
                return
            }
            
            guard let safeData = data else { return }
            guard let rate = self.parseJSON(safeData) else { return }
            
            self.delegate?.didGetCoinRate(self, rate: rate)
            
        }
        
        task.resume()
        
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            return rate
            
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
        
    }
    
}
