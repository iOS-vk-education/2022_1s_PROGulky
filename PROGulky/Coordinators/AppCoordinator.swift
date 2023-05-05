//
//  AppCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit

// MARK: - AppCoordinator

final class AppCoordinator: NSObject, CoordinatorProtocol {
    // MARK: Public Properties

    var childCoordinators = [CoordinatorProtocol]()
    let tabBarController: UITabBarController

    // MARK: Lifecycle

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    // MARK: Public

    // TODO: - PROG-17 добавить динамический цвет у таббара
    func start(animated: Bool) {
        tabBarController.delegate = self
        tabBarController.tabBar.tintColor = .prog.Dynamic.text
        tabBarController.tabBar.backgroundColor = .prog.Dynamic.background

        TabBarPage.allCases.forEach {
            getTabController($0)
        }
    }

    // MARK: Private

    private func getTabController(_ page: TabBarPage) {
        switch page {
        case .excursionList:
            let excursionListCoordinator = ExcursionListCoordinator(rootTabBarController: tabBarController)
            excursionListCoordinator.start(animated: false)
            childCoordinators.append(excursionListCoordinator)
        case .favourite:
            let favouriteCoordinator = FavouriteCoordinator(rootTabBarController: tabBarController)
            favouriteCoordinator.start(animated: false)
            childCoordinators.append(favouriteCoordinator)
        case .profile:
            let profileCoordinator = ProfileCoordinator(rootTabBarController: tabBarController)
            profileCoordinator.start(animated: false)
            childCoordinators.append(profileCoordinator)
        }
    }
}

// MARK: UITabBarControllerDelegate

extension AppCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let navVC = viewController as? UINavigationController else { return false }
        let page = TabBarPage(rawValue: navVC.tabBarItem.tag)

        switch page {
        case .excursionList:
            return true
        case .favourite:
            return true
        case .profile:
            let isLogin = UserDefaults.standard.bool(forKey: UserKeys.isLogin.rawValue)
            print("[DEBUG] .prof")
            if !isLogin {
                let builder = LoginModuleBuilder()
                let loginViewController = builder.build(moduleOutput: self)
                print("[DEBUG] \(loginViewController)")

                let navigationController = UINavigationController(rootViewController: loginViewController)
                tabBarController.present(navigationController, animated: true)

                return false
            } else {
                return true
            }
        case .none:
            return true
        }
    }
}

// MARK: LoginModuleOutput

extension AppCoordinator: LoginModuleOutput {
    func loginModuleWantsToOpenProfile() {
        // TODO: тут надо как то открыть экран профиля
        let rootNavigationController = UINavigationController()
        let builder = ProfileModuleBuilder()
        let profileView = builder.build(self)
        rootNavigationController.setViewControllers([profileView], animated: true)
    }

    func loginModuleWantsToOpenRegistrationModule() {
        print("ueueueueu")
    }
}

// MARK: ProfileModuleOutput

extension AppCoordinator: ProfileModuleOutput {
    func profileModuleWantsToOpenLoginModule() {
        print("ВЫХОД")
    }
}

//        let profileCoordinator = ProfileCoordinator(rootTabBarController: tabBarController)
//        profileCoordinator.start(animated: false)
