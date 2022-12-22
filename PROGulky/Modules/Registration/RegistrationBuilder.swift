//
//  RegistrationBuilder.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit

// MARK: - RegistrationModuleBuilder

final class RegistrationModuleBuilder {
    func build(moduleOutput: RegistrationModuleOutput) -> UIViewController {
        let viewController = RegistrationViewController()
        let router = RegistrationRouter()
        let interactor = RegistrationInteractor()

        let presenter = RegistrationPresenter(interactor: interactor, router: router, moduleOutput: moduleOutput)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
