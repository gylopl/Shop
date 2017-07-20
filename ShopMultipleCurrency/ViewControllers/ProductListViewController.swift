//
//  ProductListViewController.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import UIKit

final class ProductListViewController: UIViewController {

    fileprivate let basketStore         = BasketStore()
    fileprivate let cellReuseIdentifier = "cell"
    fileprivate let products            = [
            Product(name: "Shoes", price: 55.95, currency: .usd),
            Product(name: "T-shirt", price: 22.10, currency: .usd),
            Product(name: "Jacket", price: 290.30, currency: .usd),
            Product(name: "Dress", price: 100.73, currency: .usd)
    ]

    @IBOutlet weak var productsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop"
        setupTableView()
    }
}

//MARK - TableView Support

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {

    fileprivate func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }

    //MARK - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell    = tableView.cellForRow(at: indexPath)
        let product = products[indexPath.row]
        basketStore.add(product: product)
        cell?.accessoryType = .checkmark

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell    = tableView.cellForRow(at: indexPath)
        let product = products[indexPath.row]
        if basketStore.contains(product: product) {
            cell?.accessoryType = .none
            basketStore.remove(product: product)
        }
    }

    //MARK - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ProductCell
        if cell == nil {
            cell = ProductCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        }

        let product = products[indexPath.row]
        cell?.configure(with: product)

        return cell!
    }

}
