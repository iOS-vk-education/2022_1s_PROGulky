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
    static let shared = AppCoordinator()

    // MARK: Public Properties

    var childCoordinators = [CoordinatorProtocol]()
    var tabBarController: UITabBarController?
    var selectedPage: TabBarPage {
        get {
            guard let navigationController = tabBarController?.selectedViewController as? UINavigationController else {
                return .excursionList
            }
            return TabBarPage.fromNavigationController(navigationController)
        }
        set {
            if selectedPage != newValue {
                tabBarController?.selectedIndex = newValue.rawValue
            }
        }
    }

    var navigationController: UINavigationController {
        tabBarController?.navigationController ?? UINavigationController()
    }

    private var futurePage: TabBarPage?


    // MARK: Public

    // TODO: - PROG-17 добавить динамический цвет у таббара
    func start(animated: Bool) {
        tabBarController?.delegate = self
        tabBarController?.tabBar.tintColor = .prog.Dynamic.text
        tabBarController?.tabBar.backgroundColor = .prog.Dynamic.background

        TabBarPage.allCases.forEach {
            getTabController($0)
        }
    }

    // MARK: Private

    private func getTabController(_ page: TabBarPage) {
        guard let tabBarController else { return }
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
        if page == .excursionList { return true }

        let isLogin = UserDefaults.standard.bool(forKey: UserKeys.isLogin.rawValue)

        // Если пользователь не заголинен, то показываем ему экран логина
        guard !isLogin else { return true }

        let builder = LoginModuleBuilder()
        let loginViewController = builder.build(moduleOutput: self)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        tabBarController.present(navigationController, animated: true)
        futurePage = page
        return false
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navVC = viewController as? UINavigationController,
              let page = TabBarPage(rawValue: navVC.tabBarItem.tag)
        else {
            return
        }
        selectedPage = page
    }
}

// MARK: LoginModuleOutput

extension AppCoordinator: LoginModuleOutput {
    func loginModuleWantsToOpenSelectedScreen() {
        selectedPage = futurePage ?? .excursionList
        futurePage = nil
        tabBarController?.dismiss(animated: true)
    }

    func loginModuleWantsToOpenRegistrationModule() {
        let builder = RegistrationModuleBuilder()
        let regView = builder.build(moduleOutput: self)
        guard let navVC = tabBarController?.presentedViewController as? UINavigationController else { return }
        navVC.pushViewController(regView, animated: true)
    }
}

// MARK: RegistrationModuleOutput

extension AppCoordinator: RegistrationModuleOutput {
    func registrationModuleWantsToOpenProfile() {
        selectedPage = futurePage ?? .excursionList
        futurePage = nil
        tabBarController?.dismiss(animated: true)
    }
}

extension AppCoordinator {
    func getCoordinatorForPage(_ page: TabBarPage) -> CoordinatorProtocol {
        childCoordinators[page.rawValue]
    }
}
