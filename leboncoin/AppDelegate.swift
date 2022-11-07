//
//  AppDelegate.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        if let viewController = window?.rootViewController as? UINavigationController {
            appCoordinator = AppCoordinator(with: viewController)
            appCoordinator?.start()
        }
        window?.makeKeyAndVisible()
        return true
    }

}

