//
//  ProductCell.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import Foundation
import UIKit

final class ProductCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
        self.isHighlighted = false
    }

    func configure(with product: Product) {
        selectionStyle = .none
        textLabel?.text = product.name
        detailTextLabel?.text = "\(product.price) \(product.currency.rawValue)"
    }
}
