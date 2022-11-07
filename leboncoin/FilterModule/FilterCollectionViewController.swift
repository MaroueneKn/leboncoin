//
//  FilterCollectionViewController.swift
//  leboncoin
//
//  Created by Kandara Marouene on 06/11/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FilterCollectionViewController: UICollectionViewController {

    var viewModel : FilterViewModel
    private let applyFilterButton = UIButton()
    private var resettBarButtonItem = UIBarButtonItem()
    private let layout = FilterFlowLayout()
    
    init(_ viewModel: FilterViewModel ) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: FilterFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "Filtre"
        setupNavBar()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width, height: 30)
        collectionView.allowsMultipleSelection = false
    }
    
    func setupNavBar(){
        setupApplyFilterButton()
        let cancelBarButtonItem = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(closeFilter))
        cancelBarButtonItem.tintColor = .black
        self.navigationItem.rightBarButtonItem  = cancelBarButtonItem
        resettBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetFilter))
        resettBarButtonItem.tintColor = .black
        resettBarButtonItem.isEnabled = false
        self.navigationItem.leftBarButtonItem  = resettBarButtonItem
        self.applyFilterButton.isEnabled = false
        self.applyFilterButton.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        DispatchQueue.main.async { [self] in
            if viewModel.getCategory() != Int() {
                let indexPath = NSIndexPath(row: viewModel.getCategory() - 1 , section: 0)
                self.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
            }
            resettBarButtonItem.isEnabled = true
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categorys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as? FilterCollectionViewCell {
            cell.itemTitleLabel.text = self.viewModel.categorys[indexPath.row].name
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.applyFilterButton.isEnabled = true
        if indexPath.section == 0 {
        self.applyFilterButton.backgroundColor = .lbc_green
        } else { self.applyFilterButton.backgroundColor = .black }
        resettBarButtonItem.isEnabled = true
        viewModel.currentIndexPath = indexPath
    }
    
    func setupApplyFilterButton() {
        applyFilterButton.setTitle("Appliquer", for: .normal)
        applyFilterButton.setTitleColor(.white, for: .normal)
        applyFilterButton.backgroundColor = .lbc_green
        applyFilterButton.addTarget(self, action:  #selector(applyFilter), for: .touchUpInside)
        applyFilterButton.tintColor = .white
        self.view.addSubview(applyFilterButton)
        
        ConstaintHanlder.setConstraint(applyFilterButton, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 70, enableInsets: true)

    }
    
    @objc func closeFilter() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func resetFilter() {
        self.applyFilterButton.isEnabled = false
        self.applyFilterButton.backgroundColor = .lightGray
        resettBarButtonItem.isEnabled = false
        self.collectionView.deselectAllItems(animated: true)
        self.viewModel.resetFilter()
        self.viewModel.filter(controller: self, category_id: nil)
    }
    
    @objc func applyFilter(sender:UIButton){
        guard let indexPath = viewModel.currentIndexPath else { return }
        viewModel.category_id = viewModel.categorys[indexPath.row].id
        viewModel.saveCategory(viewModel.category_id)
        
        self.viewModel.filter(controller: self, category_id: viewModel.category_id)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}
