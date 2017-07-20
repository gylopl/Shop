//
//  NetworkConstants.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import Foundation

struct NetworkConstants {
    private struct Domains {
        static let Prod = "http://www.apilayer.net"
    }

    private struct Routes {
        static let Api = "/api"
    }

    private struct Method {
        static let Live = "/live"
    }

    private struct ProdSetup {
        static let AccessKey      = "dab995cfdcc85916f8ba75cc94b45bb9"
        static let Currencies     = "EUR,GBP,CAD,PLN"
        static let SourceCurrency = "USD"
        static let Format         = 1
    }

    static var LiveCurrencyRates: URL? {
        let urlString  = Domains.Prod + Routes.Api + Method.Live
        let parameters = [
                "access_key": ProdSetup.AccessKey,
                "currencies": ProdSetup.Currencies,
                "source": ProdSetup.SourceCurrency,
                "format": String(ProdSetup.Format)
        ]
        return URL.create(withString: urlString, parameters: parameters)
    }
}
