//
//  ListItemsCoordinator.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

final class ListItemsCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let listItemController: ListItemsViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let viewModel = ListItemsViewModel()
        self.listItemController = ListItemsViewController(viewModel: viewModel)
    }
    
    deinit {
    }
    
    func start() {
        navigationController.show(listItemController, sender: self)
    }
    
}
