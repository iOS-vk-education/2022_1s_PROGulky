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
        let searchViewModel = ExcursionsSearchViewModel()
        let interactor = ExcursionsListInteractor(searchVM: searchViewModel)

        let presenter = ExcursionsListPresenter(
            interactor: interactor,
            router: router,
            moduleOutput: moduleOutput
        )
        presenter.view = viewController

        interactor.output = presenter
        searchViewModel.output = interactor
        viewController.output = presenter

        return viewController
    }
}
