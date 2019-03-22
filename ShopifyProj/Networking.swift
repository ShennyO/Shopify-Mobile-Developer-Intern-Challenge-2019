//
//  Networking.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation


enum Route {
    
    case collections
    case products(id: String)
    
    func url() -> String {
        switch self {
        case .collections:
            return "https://shopicruit.myshopify.com/admin/custom_collections.json"
        
        case .products:
            return "https://shopicruit.myshopify.com/admin/products.json"
        }
    }
    
    func parameters() -> [String: String] {
        switch self {
            case .collections:
                return ["access_token": "c32313df0d0ef512ca64d5b336a0d7c6"]
            case let .products(id):
                return ["access_token": "c32313df0d0ef512ca64d5b336a0d7c6",
                        "ids": id
            ]
            
        }
    }
}

class Network {
    
    static let instance = Network()
    let session = URLSession.shared
    
    
    func fetch(route: Route, completion: @escaping (Data, HTTPURLResponse) -> Void) {
        
        let urlString = route.url()
        let url = URL(string: urlString)
        let fullURL = url?.appendingQueryParameters(route.parameters())
        let request = URLRequest(url: fullURL!)
        
        session.dataTask(with: request) { (data, resp, err) in
            
            if let data = data, let resp = resp {
                completion(data,resp as! HTTPURLResponse)
            }
        
        }.resume()
        
        
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        //
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}
