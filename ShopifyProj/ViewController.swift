//
//  ViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: VARIABLES
    var collections: [Collection] = []
    
    //MARK: OUTLETS
    var collectionTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getCollections()
        
    }
    
    //MARK: FUNCTIONS
    private func setUpTableView() {
        self.collectionTableView.delegate = self
        self.collectionTableView.dataSource = self
        self.collectionTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "CollectionCell")
        self.view.addSubview(collectionTableView)
    }
    
}

extension ViewController {
    private func getCollections() {
        Network.instance.fetch(route: Route.collections) { (data, response) in
            let jsonCollections = try? JSONDecoder().decode(collectionList.self, from: data)
            guard let collections = jsonCollections?.custom_collections else {return}
            self.collections = collections
            
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! CollectionTableViewCell
        return cell
    }
    
    
}

