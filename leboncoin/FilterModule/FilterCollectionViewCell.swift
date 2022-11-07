//
//  FilterCollectionViewCell.swift
//  leboncoin
//
//  Created by Kandara Marouene on 06/11/2022.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    let itemTitleLabel = UILabel()
    let iconImageView = UIImageView()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .black : .white
            itemTitleLabel.textColor =  isSelected ? .white : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        iconImageView.tintColor = .lbc_orange
        addSubview(itemTitleLabel)
        addSubview(iconImageView)
        
        ConstaintHanlder.setConstraint(itemTitleLabel, top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, enableInsets: true)
        
        ConstaintHanlder.setConstraint(iconImageView, top: topAnchor, right: rightAnchor, paddingTop:6, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

