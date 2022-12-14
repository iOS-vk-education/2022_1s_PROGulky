//
//  ExcursionListCoordinator.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit
import SwiftUI

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
    func excursionsListModuleWantsToOpenMapDetailModule(excursion: Excursion) {
        let mapDetailBuilder = MapDetailModuleBuilder()
        let mapDetailViewController = mapDetailBuilder.build(moduleOutput: self, excursion: excursion)
        rootNavigationController.pushViewController(mapDetailViewController, animated: true)
    }
}

// MARK: MapDetailModuleOutput

extension ExcursionListCoordinator: MapDetailModuleOutput {
    func mapDetailModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
        rootNavigationController.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: DetailExcursionModuleOutput

extension ExcursionListCoordinator: DetailExcursionModuleOutput {
    func detailExcursionModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
        rootNavigationController.tabBarController?.tabBar.isHidden = false
    }

    func excursionsListModuleWantsToOpenAddExcursion() {
        let builder = AddExcursionModuleBuilder()
        let addView = builder.build(moduleOutput: self)
        rootNavigationController.pushViewController(addView, animated: true)
    }
}

// MARK: AddExcursionModuleOutput

extension ExcursionListCoordinator: AddExcursionModuleOutput {
    func addExcursionModuleWantsToClose() {
        rootNavigationController.popViewController(animated: true)
    }

    func addExcursionModuleWantsToOpenAddPlaceModule() {
        let addPlaceViewModel = AddPlaceViewModel(moduleOutput: self)
        let addPlaceView = AddPlaceView(viewModel: addPlaceViewModel)
        let hosting = UIHostingController(rootView: addPlaceView)
        rootNavigationController.present(hosting, animated: true)
    }
}

// MARK: AppPlaceViewModuleOutput

extension ExcursionListCoordinator: AppPlaceViewModuleOutput {
    func addPlaceViewModuleWantsToClose() {
        guard let addExcursionViewController: AddExcursionViewInput = rootNavigationController.topViewController
            as? AddExcursionViewController else { return }
        addExcursionViewController.reload()
    }
}
