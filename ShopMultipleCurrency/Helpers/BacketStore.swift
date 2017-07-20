//
//  BacketStore.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import Foundation

enum BasketStoreError: Error {
    case RateNotFound(String)
}

final class BasketStore {

    fileprivate var products:      [Product] = []
    fileprivate var currencyRates: CurrencyRates?

    init() {
        _ = WebService().load(resource: CurrencyRates.all) { result in
            switch result {
            case let .success(currencyRates):
                self.currencyRates = currencyRates
            case let .failure(error):
                print(error)
            }
        }
    }

    func add(product: Product) {
        products.append(product)
    }

    func remove(product: Product) {
        guard let productIndex = products.index(of: product) else {
            return
        }
        products.remove(at: productIndex)
    }

    func contains(product: Product) -> Bool {
        return products.contains(product)
    }

    func calculateTotalAmount(with currency: Currency) throws -> Float {
        guard let rate = currencyRates?.rates[currency] else {
            throw BasketStoreError.RateNotFound(currency.rawValue)
        }
        return products.reduce(0, { $0 + ($1.price * rate) })
    }
}

