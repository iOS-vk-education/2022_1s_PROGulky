//
//  ProfileCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit
final class ProfileCoordinator: CoordinatorProtocol {
    // MARK: Private Properties

    private weak var rootTabBarController: UITabBarController?
    private var rootNavigationController: UINavigationController
    private let tabBarItemFactory: TabBarItemFactoryProtocol

    // MARK: Lifecycle

    init(rootTabBarController: UITabBarController) {
        self.rootTabBarController = rootTabBarController
        rootNavigationController = UINavigationController()
        tabBarItemFactory = TabBarItemFactory()
    }

    // MARK: Public Methods

    func start(animated: Bool) {
//        let temp = 
        if (UserDefaults.standard.string(forKey: "isLoggedIn") != nil) == true {
            print("ok")
            let builder = ProfileModuleBuilder()
            let profileViewController = builder.build()
            rootNavigationController.setViewControllers([profileViewController], animated: false)

            rootNavigationController.tabBarItem = tabBarItemFactory.getTabBarItem(from: TabBarPage.profile)

            var controllers = rootTabBarController?.viewControllers
            if controllers == nil {
                controllers = [rootNavigationController]
            } else {
                controllers?.append(rootNavigationController)
            }
            rootTabBarController?.setViewControllers(controllers, animated: true)
        } else {
            print("sorry")
            let builder = LoginModuleBuilder()
            let loginViewController = builder.build()
            rootNavigationController.setViewControllers([loginViewController], animated: false)

//            rootNavigationController.tabBarItem = tabBarItemFactory.getTabBarItem(from: TabBarPage.profile)

//            var controllers = rootTabBarController?.viewControllers
//            if controllers == nil {
//                controllers = [rootNavigationController]
//            } else {
//                controllers?.append(rootNavigationController)
//            }
//            rootTabBarController?.setViewControllers(controllers, animated: true)
        }
    }
}
