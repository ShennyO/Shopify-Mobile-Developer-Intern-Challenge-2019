//
//  ProductsViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ProductsViewController: UIViewController {

    //MARK: VARIABLES
    var collection: Collection!
    var products: [Product] = []
    
    
    //MARK: OUTLETS
    var productsTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        getCollects { (id) in
            self.getProducts(productId: id, completion: {
                DispatchQueue.main.async {
                    self.setUpProductsTableView()
                }
                
            })
        }
    }
}



extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: TABLEVIEW SETUP
    
    
    private func setUpProductsTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.separatorStyle = .none
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        self.view.addSubview(productsTableView)
        
        self.productsTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableViewCell
        cell.product = self.products[indexPath.row]
        return cell
    }
    
    
}


extension ProductsViewController {
    //MARK: NETWORKING FUNCTIONS
    
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
