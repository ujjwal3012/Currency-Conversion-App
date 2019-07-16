//
//  ConversionModel.swift
//  Ujjwal_bhasin_Currency_Conversion
//
//  Created by Ujjwal Bhasin on 2019-07-16.
//  Copyright © 2019 Ujjwal Bhasin. All rights reserved.
//

import Foundation

class ConversionModel {
    var listOfCurrencies = ["CAD", "INR", "BRL", "USD",
    "EUR", "AUD", "GBP", "TRY"].sorted()
    
    var currencyName : [String : String] = [ "CAD" : "Canadian Dollar", "INR" : "Indian Rupee", "BRL" : "Brazillian Real", "USD" : "US Dollar", "EUR" : "Euro", "AUD" : "Australian Dollar", "GBP" : "British Pound", "TRY" : "Turkish Lira"]
    
    var API_BASED_URL = "https://api.exchangeratesapi.io/latest?"
    
    var fromCurrency = ""
    var toCurrency = ""
    
    func updateExchangeRate (viewController: ViewController, from: Int, to: Int){
        fromCurrency = listOfCurrencies[from]
        toCurrency = listOfCurrencies[to]
        
        let api_url = API_BASED_URL + "base=" +
        fromCurrency + "&symbols=" + toCurrency
        
        print(api_url)
        
    
    if let url = URL(string: api_url){
        let dataTask =
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                
                if let dataReceived = data {
                    let jsonString = String(data: dataReceived, encoding: .utf8)
                    print(jsonString)
         
        do{
            let json = try JSON(data:
            dataReceived)
            
            let exchangeRate =
            json["rates"][self.toCurrency].double!
            
            viewController.updateConvertedAmount(exchangeRate: exchangeRate)
            
            print("1 \(self.fromCurrency) is \(exchangeRate) \(self.toCurrency)")
        } catch let err{
            print ("error reading JSON: \(err)")
                    }
                }
            }
    dataTask.resume()
        }
    }
}
