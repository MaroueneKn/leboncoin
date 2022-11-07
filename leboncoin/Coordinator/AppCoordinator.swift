//
//  AppCoordinator.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

class Coordinator { }

final class AppCoordinator {
    
    fileprivate let navigationController: UINavigationController
    fileprivate var childCoordinators = [Coordinator]()
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
    }
    
    func start() {
        let listItemsCoordinator = ListItemsCoordinator(navigationController: navigationController)
        listItemsCoordinator.start()
        childCoordinators.append(listItemsCoordinator)
    }
}
