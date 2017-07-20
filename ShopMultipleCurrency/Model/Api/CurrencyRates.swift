//
//  CurrencyRates.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import Foundation

enum Currency: String {
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case cad = "CAD"
    case pln = "PLN"
}

struct CurrencyRates {
    let rates: [Currency: Float]
}

extension CurrencyRates {
    init?(dictionary: JSONDictionary) {
        guard
                let quotes = dictionary["quotes"] as? [String: Float],
                let eurRate = quotes["USDEUR"],
                let gbpRate = quotes["USDGBP"],
                let cadRate = quotes["USDCAD"],
                let plnRate = quotes["USDPLN"] else {
            return nil
        }
        rates = [
                .eur: eurRate,
                .gbp: gbpRate,
                .cad: cadRate,
                .pln: plnRate,
                .usd: 1.0
        ]
    }
}

extension CurrencyRates {
    static let all = Resources<CurrencyRates>(url: NetworkConstants.LiveCurrencyRates, parseJSON: { json in
        guard let dictionaries = json as? JSONDictionary else {
            return nil
        }
        return CurrencyRates(dictionary: dictionaries)
    })
}
