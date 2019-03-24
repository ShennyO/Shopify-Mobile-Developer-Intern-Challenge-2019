//
//  CollectionCollectionViewCell.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/24/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class CollectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: VARIABLES
    
    var collection: Collection? {
        didSet {
            setUp()
        }
    }
    
    
    //MARK: OUTLETS
    var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 15
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.07
        containerView.layer.shadowRadius = 5
        return containerView
    }()
    
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.09240043908, green: 0.0924237594, blue: 0.09239736944, alpha: 1)
        return label
    }()
    
    var collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    
    //MARK: FUNCTIONS
    
    private func setUp() {
        addViews()
        setConstraints()
        titleLabel.text = self.collection?.title
        let collectionImageURL = URL(string: (collection?.imageURL)!)
        collectionImageView.kf.setImage(with: collectionImageURL)
        self.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }
    
    private func addViews(){
        self.addSubview(containerView)
        self.containerView.addSubview(collectionImageView)
        self.containerView.addSubview(titleLabel)
        
        
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            
        }
        
        collectionImageView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    
}
