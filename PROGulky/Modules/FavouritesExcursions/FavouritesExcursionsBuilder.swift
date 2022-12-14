//
//  FavouritesExcursionsBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - FavouritesExcursionsModuleBuilder

final class FavouritesExcursionsModuleBuilder {
    func build(moduleOutput: FavouritesExcursionsModuleOutput) -> UIViewController {
        let viewController = FavouritesExcursionsViewController()
        let router = FavouritesExcursionsRouter()
        let interactor = FavouritesExcursionsInteractor()

        let presenter = FavouritesExcursionsPresenter(
            interactor: interactor,
            router: router,
            moduleOutput: moduleOutput
        )
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
