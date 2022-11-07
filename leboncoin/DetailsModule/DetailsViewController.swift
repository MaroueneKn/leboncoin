//
//  DetailsViewController.swift
//  leboncoin
//
//  Created by Kandara Marouene on 06/11/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel : DetailsViewModel
    var scrollView = UIScrollView()
    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let itemDateLabel = UILabel()
    let itemDescriptionLabel = UILabel()
    let itemPriceButton = UIButton()
    var urgentImageView = UIImageView()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = viewModel.categoryName.name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.tintColor = .black
        setupUI()
    }
    
    private func setupUI() {
        setupScrollView()
        if let thumbImageUrl = viewModel.thumbImageUrl {
            setupImageItem(imageUrl: thumbImageUrl)
        }
        setupItemNameLabel(name: viewModel.title)
        if let creation_date = viewModel.creation_date {
            setupItemDateLabel(date: DateHandler.dateToString(creation_date) )
        }
        setupItemDiscriptionLabel(description: viewModel.description)
        setupItemPriceView(price: "  \(String(viewModel.price)) €")
        setupUrgentIndicator(urgent: viewModel.is_urgent)
    }
    
    private func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        ConstaintHanlder.setConstraint(scrollView,top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, enableInsets: true)
    }
    
    private func setupImageItem(imageUrl: String) {
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        Downloader.downloadImage(itemImageView, link: imageUrl)
        scrollView.addSubview(itemImageView)
        ConstaintHanlder.setConstraint(itemImageView, top: scrollView.topAnchor, left: scrollView.leftAnchor, right: view.rightAnchor,height: 300, enableInsets: true)

    }
    
    private func setupItemNameLabel(name: String){
        itemNameLabel.textColor = .black
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        itemNameLabel.textAlignment = .left
        itemNameLabel.numberOfLines = 0
        itemNameLabel.clipsToBounds = true
        itemNameLabel.text = name
        scrollView.addSubview(itemNameLabel)
        ConstaintHanlder.setConstraint(itemNameLabel, top: itemImageView.bottomAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, enableInsets: true)
    }
    
    private func setupItemDateLabel(date: String) {
        itemDateLabel.textColor = .darkGray
        itemDateLabel.font = UIFont.systemFont(ofSize: 13)
        itemDateLabel.textAlignment = .left
        itemDateLabel.numberOfLines = 10
        itemDateLabel.text = date
        scrollView.addSubview(itemDateLabel)
        ConstaintHanlder.setConstraint(itemDateLabel, top: itemNameLabel.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 10, enableInsets: true)
    }
    
    private func setupItemDiscriptionLabel(description: String) {
        itemDescriptionLabel.textColor = .black
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 17)
        itemDescriptionLabel.numberOfLines = 0
        itemDescriptionLabel.textAlignment = .left
        itemDescriptionLabel.text = description
        scrollView.addSubview(itemDescriptionLabel)
        ConstaintHanlder.setConstraint(itemDescriptionLabel, top: itemDateLabel.bottomAnchor, left: itemImageView.leftAnchor, bottom: scrollView.bottomAnchor, right:  view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom:80, paddingRight: 10, enableInsets: true)
    }
    
    private func setupItemPriceView(price: String) {
        itemPriceButton.setTitle(price, for: .normal)
        itemPriceButton.backgroundColor = .lbc_orange
        itemPriceButton.setImage(UIImage(systemName: "cart") , for: .normal)
        itemPriceButton.tintColor = .white
        self.view.addSubview(itemPriceButton)
        ConstaintHanlder.setConstraint(itemPriceButton, left: view.leftAnchor, bottom: view.bottomAnchor, right:  view.rightAnchor, height: 70, enableInsets: true)
    }
    
    func setupUrgentIndicator(urgent: Bool) {
        urgentImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        urgentImageView.image = UIImage(named: "alert")?.withRenderingMode(.alwaysTemplate)
        urgentImageView.tintColor = .lbc_urgent
        urgentImageView.contentMode = UIView.ContentMode.scaleAspectFit
        let rightBarButton = UIBarButtonItem(customView: urgentImageView)
        if urgent { self.navigationItem.rightBarButtonItem = rightBarButton }
    }
    
}
