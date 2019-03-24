//
//  ProductTableViewCell.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: VARIABLES
    var product: Product! {
        didSet {
            setUp()
        }
    }
    
    //MARK:OUTLETS
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
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.09240043908, green: 0.0924237594, blue: 0.09239736944, alpha: 1)
        return label
    }()
    
    var vendorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        return label
    }()
    
    var inventoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        return label
    }()
    
    var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    //MARK: FUNCTIONS
    private func addViews() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(vendorLabel)
        containerView.addSubview(inventoryLabel)
        containerView.addSubview(productImageView)
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            
        }
        
        productImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(productImageView.snp.top).offset(2)
            make.left.equalTo(productImageView.snp.right).offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        
        vendorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(productImageView.snp.right).offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        
        inventoryLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(productImageView.snp.bottom)
            make.left.equalTo(productImageView.snp.right).offset(15)
        }
        
    }
    
    private func setUp() {
        addViews()
        setConstraints()
        
        self.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        
        let productURL = URL(string: (self.product?.imageURL)!)
        productImageView.kf.setImage(with: productURL)
        
        titleLabel.text = product?.title
        vendorLabel.text = product?.vendor
        inventoryLabel.text = "x" + String(describing: product.totalInv)
    }
    
    

}
