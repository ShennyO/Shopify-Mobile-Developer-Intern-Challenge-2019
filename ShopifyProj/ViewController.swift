//
//  ViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let params = ["access_token": "c32313df0d0ef512ca64d5b336a0d7c6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Network.instance.fetch(params: params) { (data, response) in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
            let collections = json?["custom_collections"] as! [[String: Any]]
            print(collections[0])
        }
    }


}

