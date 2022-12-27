//
//  FavouriteCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import UIKit

// MARK: - FavouriteCoordinator

final class FavouriteCoordinator: CoordinatorProtocol {
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
        let builder = FavouritesExcursionsModuleBuilder()
        let favouriteViewController = builder.build(moduleOutput: self)
        rootNavigationController.setViewControllers([favouriteViewController], animated: false)

        rootNavigationController.tabBarItem = tabBarItemFactory.getTabBarItem(from: TabBarPage.favourite)

        var controllers = rootTabBarController?.viewControllers
        if controllers == nil {
            controllers = [rootNavigationController]
        } else {
            controllers?.append(rootNavigationController)
        }
        rootTabBarController?.setViewControllers(controllers, animated: true)
    }
}

// MARK: FavouritesExcursionsModuleOutput

extension FavouriteCoordinator: FavouritesExcursionsModuleOutput {
    func favoritesExcursionsListModuleWantsToOpenMapDetailModule(excursion: Excursion) {
        let mapDetailBuilder = MapDetailModuleBuilder()
        let mapDetailViewController = mapDetailBuilder.build(moduleOutput: self, excursion: excursion)
        rootNavigationController.pushViewController(mapDetailViewController, animated: true)
    }
}

// MARK: MapDetailModuleOutput

extension FavouriteCoordinator: MapDetailModuleOutput {
    func mapDetailModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
        rootNavigationController.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: DetailExcursionModuleOutput

extension FavouriteCoordinator: DetailExcursionModuleOutput {
    func detailExcursionModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
        rootNavigationController.tabBarController?.tabBar.isHidden = false
    }
}
