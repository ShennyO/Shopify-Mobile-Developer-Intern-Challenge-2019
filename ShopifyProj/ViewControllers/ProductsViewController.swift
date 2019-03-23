//
//  ProductsViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    //MARK: VARIABLES
    var collection: Collection!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        getCollects { (id) in
            self.getProducts(productId: id, completion: {
                print(self.products)
            })
        }
        // Do any additional setup after loading the view.
    }
    

}

extension ProductsViewController {
    //MARK: FUNCTIONS
    
    private func getCollects(completion: @escaping (String)->()) {
        var collectionID = String(describing: collection.collectionID)
        Network.instance.fetch(route: .collects(id: collectionID)) { (data, response) in
            let jsonCollectList = try? JSONDecoder().decode(collectList.self, from: data)
            guard let collects = jsonCollectList?.collects else {return}
            var collectIDs = ""
            for x in collects {
                let productID = String(describing: x.product_id)
                collectIDs += productID + ","
            }
            collectionID = String(collectIDs.dropLast())
            completion(collectionID)
            
        }
    }
    
    
    private func getProducts(productId: String, completion: @escaping ()->()) {
        
        Network.instance.fetch(route: .products(id: productId)) { (data, response) in

            let jsonProducts = try? JSONDecoder().decode(productList.self, from: data)
            guard let products = jsonProducts?.products else {return}
            self.products = products
            completion()
        }
    }
}
