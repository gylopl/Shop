//
//  WebService.swift
//  ShopMultipleCurrency
//
//  Created by Grzegorz Makowski on 19.07.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum Result<A> {
    case success(A)
    case failure(Error)
}

struct Resources<A> {
    let url:   URL
    let parse: (Data) -> A?
}

extension Resources {
    init?(url: URL?, parseJSON: @escaping (Any) -> A?) {
        guard let url = url else {
            return nil
        }
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

final class WebService {
    let session = URLSession.shared

    func load<A>(resource: Resources<A>?, completion: @escaping (Result<A?>) -> ()) -> URLSessionDataTask? {
        guard let resource = resource else {
            return nil
        }
        let dataTask = session.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    let result = resource.parse(data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
            }

        }
        dataTask.resume()
        return dataTask
    }

}
