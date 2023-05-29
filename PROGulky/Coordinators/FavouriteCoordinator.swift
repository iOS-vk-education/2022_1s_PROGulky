//
//  FavouriteCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import UIKit
import SwiftUI

// MARK: - FavouriteCoordinator

final class FavouriteCoordinator: CoordinatorProtocol {
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
        let builder = FavouritesExcursionsModuleBuilder()
        let favouriteViewController = builder.build(moduleOutput: self)
        rootNavigationController.setViewControllers([favouriteViewController], animated: animated)

        rootNavigationController.tabBarItem = tabBarItemFactory.getTabBarItem(from: TabBarPage.favourite)

        var controllers = rootTabBarController?.viewControllers
        if controllers == nil {
            controllers = [rootNavigationController]
        } else {
            controllers?.append(rootNavigationController)
        }
        rootTabBarController?.setViewControllers(controllers, animated: animated)
    }

    func restart() {
        let builder = FavouritesExcursionsModuleBuilder()
        let favouriteViewController = builder.build(moduleOutput: self)
        rootNavigationController.setViewControllers([favouriteViewController], animated: false)
    }
}

// MARK: FavouritesExcursionsModuleOutput

extension FavouriteCoordinator: FavouritesExcursionsModuleOutput {
    func favoritesExcursionsListModuleWantsToOpenMapDetailModule(excursion: PreviewExcursion) {
        let detailExcursionViewModel = DetailExcursionViewModel(excursionId: excursion.id)
        let detailExcursionView = DetailExcursionView(viewModel: detailExcursionViewModel)
        let hostingViewController = UIHostingController(rootView: detailExcursionView)
        rootNavigationController.navigationBar.standardAppearance.configureWithTransparentBackground()
        rootNavigationController.navigationBar.standardAppearance.backgroundColor = .clear
        rootNavigationController.pushViewController(hostingViewController, animated: true)
    }
}

// MARK: MapDetailModuleOutput

extension FavouriteCoordinator: MapDetailModuleOutput {
    func mapDetailModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
        rootNavigationController.tabBarController?.tabBar.isHidden = false
    }
}
