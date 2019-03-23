//
//  CollectionTableViewCell.swift
//  ShopifyProj
//
//  Created by Sunny Ouyang on 3/22/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    //MARK: VARIABLES
    var collection: Collection?
    
    //MARK: OUTLETS
    var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 5
        containerView.layer.borderColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return containerView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.09240043908, green: 0.0924237594, blue: 0.09239736944, alpha: 1)
        return label
    }()
    
    var collectionImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = self.collection?.title
        addViews()
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

}
