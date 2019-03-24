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
        containerView.layer.cornerRadius = 15
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.07
        containerView.layer.shadowRadius = 5
        return containerView
    }()
    
    var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        return label
    }()
    
    var collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
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
        self.backgroundColor = UIColor.white
    }
    
    private func addViews(){
        self.addSubview(containerView)
        self.containerView.addSubview(collectionImageView)
        self.containerView.addSubview(darkView)
        self.containerView.addSubview(titleLabel)
        
        
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(5)
            
        }
        
        darkView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset
            make.left.equalToSuperview().offset
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    
}
