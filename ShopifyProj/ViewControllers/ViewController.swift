//
//  ViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    //MARK: VARIABLES
    var collections: [Collection] = []
    var collectionToPass: Collection!
   
    
    //MARK: OUTLETS
    var collectionTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        self.setUpNavBar()
        self.getCollections() {
            DispatchQueue.main.async {
                self.setUpTableView()
            }
        }
        
        
    }
    
   
}

extension ViewController {
    
    //MARK: FUNCTIONS
    
    private func setUpNavBar() {
        self.title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpTableView() {
        self.collectionTableView.separatorStyle = .none
        self.collectionTableView.delegate = self
        self.collectionTableView.dataSource = self
        self.collectionTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "CollectionCell")
        self.view.addSubview(collectionTableView)
        
        self.collectionTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
    private func getCollections(completion: @escaping ()->()) {
        Network.instance.fetch(route: Route.collections) { (data, response) in
            let jsonCollections = try? JSONDecoder().decode(collectionList.self, from: data)
            guard let collections = jsonCollections?.custom_collections else {return}
            self.collections = collections
            completion()
        }
    }
    
    private func toNext() {
        let nextVC = ProductsViewController()
        nextVC.collection = self.collectionToPass
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! CollectionTableViewCell
        cell.collection = self.collections[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collectionToPass = self.collections[indexPath.row]
        toNext()
    }
    
    
}

