//
//  CollectionsViewController.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/24/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {

    //MARK: VARIABLES
    var collections: [Collection] = []
    var collectionToPass: Collection!
    
    
    //MARK: OUTLETS
    var collectionsCollectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        setUpNavBar()
        getCollections {
            DispatchQueue.main.async {
                self.setUpCollectionView()
            }
        }

        // Do any additional setup after loading the view.
    }
    
}

extension CollectionsViewController {
    //MARK: FUNCTIONS
    private func setUpNavBar() {
        self.title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func toNext() {
        let nextVC = ProductsViewController()
        nextVC.collection = self.collectionToPass
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    private func setUpCollectionView() {
        

        let collectionViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        collectionsCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: flowLayout)
        collectionsCollectionView.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
        collectionsCollectionView.backgroundColor = UIColor.white
        self.collectionsCollectionView.delegate = self
        self.collectionsCollectionView.dataSource = self
        self.collectionsCollectionView.register(CollectionCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionsCollectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.collectionsCollectionView)
        
        
        collectionsCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
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
    
}

extension CollectionsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let cellWidth = screenWidth / 2.2
        let cellHeight = screenHeight / (screenHeight/160)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCollectionViewCell
        cell.collection = self.collections[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionToPass = self.collections[indexPath.row]
        toNext()
    }
    
    
}

