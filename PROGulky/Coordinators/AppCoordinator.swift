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
    private var selectedPage = TabBarPage.excursionList

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
        guard let navVC = viewController as? UINavigationController,
              let page = TabBarPage(rawValue: navVC.tabBarItem.tag)
        else {
            return false
        }
        selectedPage = page
        if page == .excursionList { return true }

        let isLogin = UserDefaults.standard.bool(forKey: UserKeys.isLogin.rawValue)

        // Если пользователь не заголинен, то показываем ему экран логина
        guard !isLogin else { return true }

        let builder = LoginModuleBuilder()
        let loginViewController = builder.build(moduleOutput: self)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        tabBarController.present(navigationController, animated: true)
        return false
    }
}

// MARK: LoginModuleOutput

extension AppCoordinator: LoginModuleOutput {
    func loginModuleWantsToOpenSelectedScreen() {
        // В переменной selectedPage сохраняется таб по которому нажал пользователь,
        tabBarController.selectedIndex = selectedPage.rawValue // тут устанавлявается выбранным табом тот таб, по которому пользователь нажимал перед логином
        tabBarController.dismiss(animated: true)
    }

    func loginModuleWantsToOpenRegistrationModule() {
        let builder = RegistrationModuleBuilder()
        let regView = builder.build(moduleOutput: self)
        guard let navVC = tabBarController.presentedViewController as? UINavigationController else { return }
        navVC.pushViewController(regView, animated: true)
    }
}

// MARK: RegistrationModuleOutput

extension AppCoordinator: RegistrationModuleOutput {
    func registrationModuleWantsToOpenProfile() {
        tabBarController.dismiss(animated: true)
        tabBarController.selectedIndex = selectedPage.rawValue
    }
}
