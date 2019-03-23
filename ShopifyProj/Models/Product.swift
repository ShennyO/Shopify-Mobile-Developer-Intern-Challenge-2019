//
//  Product.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation

struct Variant {
    let inventory_quantity: Int
}

extension Variant: Decodable {
    enum variantContainerKeys: String, CodingKey {
        case inventory_quantity
    }

    init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: variantContainerKeys.self)
        let inventoryQuantity = try topContainer.decodeIfPresent(Int.self, forKey: .inventory_quantity)
        self.init(inventory_quantity: inventoryQuantity!)

    }

}

struct Product {
    let title: String
    let imageURL: String
    let totalInv: Int
    let vendor: String
    
    init(title: String, imageURL: String, totalInv: Int, vendor: String) {
        self.title = title
        self.imageURL = imageURL
        self.totalInv = totalInv
        self.vendor = vendor
    }
    
}

extension Product: Decodable {
    
    enum productCodingKeys: String, CodingKey {
        case title
        case image
        case variants
        case vendor
    }
    
    enum imageCodingKey: String, CodingKey {
        case src
    }
    
    
    init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: productCodingKeys.self)
        let imageContainer = try topContainer.nestedContainer(keyedBy: imageCodingKey.self, forKey: .image)
        let title = try topContainer.decodeIfPresent(String.self, forKey: .title)
        let image = try imageContainer.decodeIfPresent(String.self, forKey: .src)
        let variants = try topContainer.decodeIfPresent([Variant].self, forKey: .variants)
        let vendor = try topContainer.decodeIfPresent(String.self, forKey: .vendor)
        
        
        var total = 0
        for variant in variants! {
            total += variant.inventory_quantity
        }
                
        self.init(title: title!, imageURL: image!, totalInv: total, vendor: vendor!)
        
    }
    
}


struct productList: Decodable {
    let products: [Product]
}
    

