//
//  ExcursionsListBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - ExcursionsListModuleBuilder

final class ExcursionsListModuleBuilder {
    func build(moduleOutput: ExcursionsListModuleOutput) -> UIViewController {
        let viewController = ExcursionsListViewController()
        let router = ExcursionsListRouter()
        let searchHelper = ExcursionsSearchHelper()
        let interactor = ExcursionsListInteractor(helper: searchHelper)

        let presenter = ExcursionsListPresenter(
            interactor: interactor,
            router: router,
            moduleOutput: moduleOutput
        )
        presenter.view = viewController

        interactor.output = presenter
        searchHelper.output = interactor
        viewController.output = presenter

        return viewController
    }
}
