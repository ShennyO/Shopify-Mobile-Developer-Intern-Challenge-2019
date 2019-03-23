//
//  CollectionTableViewCell.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionTableViewCell: UITableViewCell {
    
    //MARK: VARIABLES
    var collection: Collection? {
        didSet {
            titleLabel.text = self.collection?.title
            let collectionImageURL = URL(string: (collection?.imageURL)!)
            collectionImageView.kf.setImage(with: collectionImageURL)
            addViews()
            setConstraints()
            self.backgroundColor = #colorLiteral(red: 0.9402160048, green: 0.9403734803, blue: 0.9401952624, alpha: 1)
        }
    }
    
    //MARK: OUTLETS
    var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 5
        containerView.layer.borderColor = UIColor.white.cgColor
        return containerView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        label.textColor = #colorLiteral(red: 0.09240043908, green: 0.0924237594, blue: 0.09239736944, alpha: 1)
        return label
    }()
    
    var collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: FUNCTIONS
    private func addViews(){
        self.addSubview(containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(collectionImageView)
        
    }

    private func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            
        }
        
        collectionImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(collectionImageView.snp.top).offset(25)
            make.left.equalTo(collectionImageView.snp.right).offset(15)
        }
        
    }
    
}
