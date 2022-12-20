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
        let isLoggedOut = UserDefaults.standard.bool(forKey: "isLoggedOut")
        if isLoggedOut {
            let builder = LoginModuleBuilder()
            let loginViewController = builder.build(moduleOutput: self)
            viewControllers = [loginViewController]
        } else {
            let builder = ProfileModuleBuilder()
            let profileViewController = builder.build(self)
            viewControllers = [profileViewController]
        }
        rootNavigationController.setViewControllers(viewControllers, animated: false)
        rootTabBarController?.setViewControllers(controllers, animated: true)
    }
}

// MARK: ProfileModuleOutput

extension ProfileCoordinator: ProfileModuleOutput {
    func profileModuleWantsToOpenLoginModule() {
        let builder = LoginModuleBuilder()
        let loginViewController = builder.build(moduleOutput: self)
        rootNavigationController.setViewControllers([loginViewController], animated: true)
    }
}

// MARK: RegistrationModuleOutput

extension ProfileCoordinator: RegistrationModuleOutput {
    func registrationModuleWantsToOpenProfile() {
        let builder = ProfileModuleBuilder()
        let profileView = builder.build(self)
        rootNavigationController.dismiss(animated: false)
        rootNavigationController.setViewControllers([profileView], animated: true)
    }
}

// MARK: LoginModuleOutput

extension ProfileCoordinator: LoginModuleOutput {
    func loginModuleWantsToOpenRegistrationModule() {
        let builder = RegistrationModuleBuilder()
        let regView = builder.build(moduleOutput: self)
        rootNavigationController.present(regView, animated: true)
    }

    func loginModuleWantsToOpenProfile() {
        let builder = ProfileModuleBuilder()
        let profileView = builder.build(self)
        rootNavigationController.setViewControllers([profileView], animated: true)
    }
}
