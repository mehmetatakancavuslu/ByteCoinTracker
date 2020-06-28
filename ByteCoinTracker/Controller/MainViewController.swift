//
//  ViewController.swift
//  ByteCoinTracker
//
//  Created by Atakan Çavuşlu on 28.06.2020.
//  Copyright © 2020 Atakan Çavuşlu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var currecyPicker: UIPickerView!
    
    var currency: String?
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currecyPicker.dataSource = self
        currecyPicker.delegate = self
        
        coinManager.delegate = self
        
    }

}

// MARK: - UIPickerViewDataSource

extension MainViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
}

// MARK: - UIPickerViewDelegate

extension MainViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        currency = selectedCurrency
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
    
}

// MARK: - CoinManagerDelegate

extension MainViewController: CoinManagerDelegate {
    
    func didGetCoinRate(_ coinManager: CoinManager, rate: Double) {
        
        let rateString = String(format: "%.2f", rate)
        let value = "\(rateString) \(currency ?? "")"
            
        DispatchQueue.main.async {
            self.valueLabel.text = value
        }
        
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }

}
