//
//  LoginBuilder.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit

// MARK: - LoginModuleBuilder

final class LoginModuleBuilder {
    func build(moduleOutput: LoginModuleOutput) -> UIViewController {
        let viewController = LoginViewController()
        let router = LoginRouter()
        let service = UserDefaultsLoginService.shared
        let interactor = LoginInteractor(userDefaultsLoginService: service)

        let presenter = LoginPresenter(interactor: interactor, router: router, moduleOutput: moduleOutput)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
