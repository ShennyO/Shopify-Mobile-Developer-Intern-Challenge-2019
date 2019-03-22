//
//  ViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var collections: [Collection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getCollections()
        
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

