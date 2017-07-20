//
//  Product.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import Foundation

struct Product: Equatable {
    let name:     String
    let price:    Float
    let currency: Currency

    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name
    }
}
