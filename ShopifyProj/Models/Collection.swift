//
//  Collection.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation


struct Collection {
    let collectionID: Int
    let title: String
    let imageURL: String
    let body: String
    
    init(collectionID: Int, title: String, imageURL: String, body: String) {
        self.collectionID = collectionID
        self.title = title
        self.imageURL = imageURL
        self.body = body
    }
    
}

extension Collection: Decodable {
    
    enum collectionContainerKeys: String, CodingKey {
        case id
        case title
        case image
        case body_html
        
    }
    
    enum imageContainerKey: String, CodingKey {
        case src
    }
    
    init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: collectionContainerKeys.self)
        let imageContainer = try topContainer.nestedContainer(keyedBy: imageContainerKey.self, forKey: .image)
        let title = try topContainer.decodeIfPresent(String.self, forKey: .title)
        let id = try topContainer.decodeIfPresent(Int.self, forKey: .id)
        let imageURL = try imageContainer.decodeIfPresent(String.self, forKey: .src)
        let body = try topContainer.decodeIfPresent(String.self, forKey: .body_html)
        
        self.init(collectionID: id!, title: title!, imageURL: imageURL!, body: body!)
        
    }
    
}

struct collectionList: Decodable {
    let custom_collections: [Collection]
}
