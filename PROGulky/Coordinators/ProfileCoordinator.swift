//
//  ProfileCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit

// MARK: - ProfileCoordinator

final class ProfileCoordinator: CoordinatorProtocol {
    // MARK: Private Properties

    private weak var rootTabBarController: UITabBarController?
    private var rootNavigationController: UINavigationController
    private let tabBarItemFactory: TabBarItemFactoryProtocol

    var navigationController: UINavigationController {
        rootNavigationController
    }

    // MARK: Lifecycle

    init(rootTabBarController: UITabBarController) {
        self.rootTabBarController = rootTabBarController
        rootNavigationController = UINavigationController()
        tabBarItemFactory = TabBarItemFactory()
    }

    // MARK: Public Methods

    func start(animated: Bool) {
        var controllers = rootTabBarController?.viewControllers
        if controllers == nil {
            controllers = [rootNavigationController]
        } else {
            controllers?.append(rootNavigationController)
        }
        var viewControllers = [UIViewController]()
        rootNavigationController.tabBarItem = tabBarItemFactory.getTabBarItem(from: TabBarPage.profile)

        let builder = ProfileModuleBuilder()
        let profileViewController = builder.build(self)
        viewControllers = [profileViewController]

        rootNavigationController.setViewControllers(viewControllers, animated: animated)
        rootTabBarController?.setViewControllers(controllers, animated: animated)
    }
}

// MARK: ProfileModuleOutput

extension ProfileCoordinator: ProfileModuleOutput {
    func profileModuleWantsToOpenScreen(with page: TabBarPage) {
        AppCoordinator.shared.selectedPage = page
    }
}
