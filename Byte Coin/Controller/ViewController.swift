//
//  ViewController.swift
//  ByteCoin

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinMenager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinMenager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self // we need to set the ViewController.swift as the datasource for the picker.
    }
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension ViewController: UIPickerViewDataSource , UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // to determine how many columns we want in our picker.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //we need to tell Xcode how many rows this picker should have
        return coinMenager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //The String is the title for a given row.
        return coinMenager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinMenager.currencyArray[row]
        coinMenager.getCoinPrice(for: selectedCurrency)
    }
}
