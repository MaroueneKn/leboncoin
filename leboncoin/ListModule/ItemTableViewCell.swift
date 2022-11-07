//
//  ItemTableViewCell.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

class ItemTableViewCell: UITableViewCell {
    
    var urgentImageView = UIImageView()
    var itemTitleLabel = UILabel()
    var itemCreatedDateLabel = UILabel()
    var itemPriceLabel = UILabel()
    var itemImage = UIImageView()
    var categoryView = UIView()
    let Screen = UIScreen.main.bounds.size

    var category : Category?
    
    var item : Item? {
        didSet {
            if let itm = item {
                setupUrgentIcon(urgent: itm.is_urgent)
                if let image = itm.images_url?.thumb {
                    setupItemImage(imageUrl: image)
                }
                setupItemTitleLabel(title: itm.title)
                setupItemPriceLabel(price:  String(itm.price) + " €")
                if let date = DateHandler.stringToDate(itm.creation_date) {  setupItemCreatedDateLabel(date: date)}
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isAccessibilityElement = true
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUrgentIcon(urgent: Bool){
        urgentImageView.image = UIImage(named: "alert")
        urgentImageView.tintColor = .lbc_urgent
        urgentImageView.contentMode = UIView.ContentMode.scaleAspectFit
        urgentImageView.layer.masksToBounds = true
        urgentImageView.isHidden = !urgent
        addSubview(urgentImageView)
        ConstaintHanlder.setConstraint(urgentImageView,top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10, width: 30, height: 30, enableInsets: false)
    }
    
    
    func setupItemImage(imageUrl: String){
        itemImage.removeFromSuperview()
        itemImage = UIImageView(image:UIImage())
        itemImage.contentMode = .scaleToFill
        Downloader.downloadImage(itemImage, link: imageUrl)
        addSubview(itemImage)
        
        ConstaintHanlder.setConstraint(itemImage,top: topAnchor, left: leftAnchor, paddingTop: 10, width: Screen.width , height: 220, enableInsets: true)

    }
    
    func setupItemTitleLabel(title: String){
        itemTitleLabel.textColor = .black
        itemTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        itemTitleLabel.textAlignment = .left
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.text = title
        addSubview(itemTitleLabel)
        
        ConstaintHanlder.setConstraint(itemTitleLabel, left: leftAnchor, bottom: bottomAnchor , right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 30, enableInsets: false)

    }
    
    func setupItemCreatedDateLabel(date: Date){
        itemCreatedDateLabel.textColor = .lightGray
        itemCreatedDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        itemCreatedDateLabel.textAlignment = .left
        itemCreatedDateLabel.text = DateHandler.dateToString(date)
        addSubview(itemCreatedDateLabel)
        
        ConstaintHanlder.setConstraint(itemCreatedDateLabel, top: itemTitleLabel.bottomAnchor, left: leftAnchor , right: itemPriceLabel.leftAnchor, paddingTop: 5, paddingLeft: 20, enableInsets: false)

    }
    
    func setupItemPriceLabel(price: String){
        itemPriceLabel.textColor = .lightGray
        itemPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        itemPriceLabel.textAlignment = .center
        itemPriceLabel.numberOfLines = 0
        itemPriceLabel.text = price
        addSubview(itemPriceLabel)
        
        ConstaintHanlder.setConstraint(itemPriceLabel, bottom: bottomAnchor, right: rightAnchor, width: 80, height: 35, enableInsets: false)
    }
}
