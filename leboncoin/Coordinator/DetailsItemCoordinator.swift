//
//  DetailsItemCoordinator.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

final class DetailsItemCoordinator: Coordinator {

    fileprivate let navigationController: UINavigationController
    fileprivate let detailsViewController: DetailsViewController

    init(navigationController: UINavigationController, item: Item, category: Category) {
        self.navigationController = navigationController
        let viewModel = DetailsViewModel(item: item, categoryName: category)
        self.detailsViewController = DetailsViewController(viewModel: viewModel)
    }

    deinit {
    }

    func start() {
        self.navigationController.show(self.detailsViewController, sender: nil)
    }

}
