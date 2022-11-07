//
//  ListItemsViewController.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import UIKit

class ListItemsViewController: UITableViewController {
    
    private let cellReuseIdendifier = "itemCellId"
    private var viewModel = ListItemsViewModel()
    private var filterButton = UIButton()
    var detailsCoordinator: DetailsItemCoordinator?
    var filterCoordinator: FilterCoordinator?

    init(viewModel: ListItemsViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .lbc_grey
        tableView.tableFooterView = UIView()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        fetchData()
        self.initNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc func fetchData()  {
        viewModel.getItemList { success in
            if success {
                DispatchQueue.main.async { [self] in
                    self.tableView.reloadData()
                }
            } else {
                ErrorHandling.handleFail(self, title: ErrorMessage.TITLE, body: ErrorMessage.BODY_ITEMS)
            }
        }
        
        viewModel.getCategories { success in
            if success {
                DispatchQueue.main.async { [self] in
                    self.tableView.reloadData() }
            } else {
                ErrorHandling.handleFail(self, title: ErrorMessage.TITLE, body: ErrorMessage.BODY_CATEGORY)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.allItems.count == 0) {
            filterButton.isEnabled = false
        } else{
            filterButton.isEnabled = true
        }
        return viewModel.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as? ItemTableViewCell {
            cell.item = viewModel.allItems[indexPath.row]
            
            if let list_category_id = viewModel.allItems[indexPath.row].category_id {
                if viewModel.categorys.count != 0 {
                    cell.category = viewModel.categorys[list_category_id - 1]
                } else {
                    ErrorHandling.handleFail(self, title: ErrorMessage.TITLE, body: ErrorMessage.BODY_GENERIC)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8
        let horizentalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.white.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: horizentalPadding/2, dy: verticalPadding/2)
        maskLayer.cornerRadius = 15
        cell.layer.mask = maskLayer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigationController = self.navigationController {
            detailsCoordinator = DetailsItemCoordinator(navigationController: navigationController , item: self.viewModel.allItems[indexPath.row], category: self.viewModel.categorys[self.viewModel.allItems[indexPath.row].category_id - 1])
            detailsCoordinator?.start()
        }
    }
    
    @objc func didSelectFilter() {
        if let navigationController = self.navigationController {
            filterCoordinator = FilterCoordinator(navigationController: navigationController, items: viewModel.allItems, categorys: self.viewModel.categorys)
            filterCoordinator?.filterViewController.viewModel.delegate =  self.viewModel
            filterCoordinator?.start()
        }
    }
}


extension ListItemsViewController{
    func initNavigationBar() {
        self.title = "Annonces"
        filterButton = UIButton(type: UIButton.ButtonType.custom)
        filterButton.setImage(UIImage(named: "filter"), for: .normal)
        filterButton.imageView?.clipsToBounds = true
        filterButton.imageView?.contentMode = .scaleAspectFit
        filterButton.addTarget(self, action:  #selector(didSelectFilter), for: UIControl.Event.touchUpInside)
        filterButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        filterButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        filterButton.tintColor = .lbc_orange
        let barButton = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
}
