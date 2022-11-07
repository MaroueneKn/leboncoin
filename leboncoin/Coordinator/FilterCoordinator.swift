//
//  FilterCoordinator.swift
//  leboncoin
//
//  Created by Kandara Marouene on 06/11/2022.
//

import UIKit

final class FilterCoordinator: Coordinator {

    fileprivate let navigationController: UINavigationController
    let filterViewController: FilterCollectionViewController

    init(navigationController: UINavigationController,items: [Item], categorys: [Category]) {
        self.navigationController = navigationController
        let viewModel = FilterViewModel(items: items, categorys: categorys)
        self.filterViewController = FilterCollectionViewController(viewModel)
    }

    deinit {
    }

    func start() {
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: self.filterViewController)
        navBarOnModal.modalPresentationStyle = .fullScreen

        self.navigationController.present(navBarOnModal, animated: true, completion: nil)
    }

}

