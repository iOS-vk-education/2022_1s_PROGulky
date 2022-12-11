//
//  ExcursionListCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit

// MARK: - ExcursionListCoordinator

final class ExcursionListCoordinator: CoordinatorProtocol {
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
        let builder = ExcursionsListModuleBuilder()
        let excursionListViewController = builder.build(moduleOutput: self)
        rootNavigationController.setViewControllers([excursionListViewController], animated: false)

        rootNavigationController.tabBarItem = tabBarItemFactory.getTabBarItem(from: TabBarPage.excursionList)

        var controllers = rootTabBarController?.viewControllers
        if controllers == nil {
            controllers = [rootNavigationController]
        } else {
            controllers?.append(rootNavigationController)
        }
        rootTabBarController?.setViewControllers(controllers, animated: true)
    }
}

// MARK: ExcursionsListModuleOutput

extension ExcursionListCoordinator: ExcursionsListModuleOutput {
    func excursionsListModuleWantsToOpenDetailExcursion(excursion: Excursion) {
        let builder = DetailExcursionModuleBuilder()
        let detailView = builder.build(for: excursion)
        rootNavigationController.pushViewController(detailView, animated: true)
    }

    func detailExcursionModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
    }

    func excursionsListModuleWantsToOpenAddExcursion() {
        let builder = AddExcursionModuleBuilder()
        let addView = builder.build()
        rootNavigationController.pushViewController(addView, animated: true)
    }

    func addExcursionModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
    }
}
