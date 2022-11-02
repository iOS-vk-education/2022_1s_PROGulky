//
//  AddExcursionBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - AddExcursionModuleBuilder

final class AddExcursionModuleBuilder {
    func build() -> UIViewController {
        let viewController = AddExcursionViewController()
        let router = AddExcursionRouter()
        let interactor = AddExcursionInteractor()

        let presenter = AddExcursionPresenter(interactor: interactor, router: router)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
