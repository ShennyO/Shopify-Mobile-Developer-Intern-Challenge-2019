//
//  Collect.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/23/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation

struct Collect: Decodable {
    let product_id: Int
}

struct collectList: Decodable {
    let collects: [Collect]
}
