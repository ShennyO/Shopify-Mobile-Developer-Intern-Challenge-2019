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
                    self.setUpTableHeaderView()
                }
                
            })
        }
    }
}



extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: TABLEVIEW SETUP
    
    private func setUpTableHeaderView() {
        
        let headerFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        let headerView = UIView(frame: headerFrame)
        
        //MARK: HEADERVIEW OUTLETS
        
        let collectionTitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
            label.numberOfLines = 0
            label.textColor = #colorLiteral(red: 0.09240043908, green: 0.0924237594, blue: 0.09239736944, alpha: 1)
            return label
        }()
        
        let collectionBodyLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
            label.numberOfLines = 0
            label.textColor = #colorLiteral(red: 0.09240043908, green: 0.0924237594, blue: 0.09239736944, alpha: 1)
            label.textAlignment = .center
            return label
        }()
        
        let collectionImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 40
            return imageView
        }()
        
        
        headerView.addSubview(collectionTitleLabel)
        headerView.addSubview(collectionBodyLabel)
        headerView.addSubview(collectionImageView)
     
        
        collectionTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        collectionBodyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(collectionTitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        collectionImageView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionBodyLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        
        
        headerView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionTitleLabel.text = self.collection.title
        collectionBodyLabel.text = self.collection.body
        let collectionImageURL = URL(string: self.collection.imageURL)
        collectionImageView.kf.setImage(with: collectionImageURL)
        self.productsTableView.tableHeaderView = headerView
        
    }
    
    
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
        return 150
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
