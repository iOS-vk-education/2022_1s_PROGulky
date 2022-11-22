//
//  LoginBuilder.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit

// MARK: - LoginModuleBuilder

final class LoginModuleBuilder {
    func build() -> UIViewController {
        let viewController = LoginViewController()
        let router = LoginRouter()
        let interactor = LoginInteractor()

        let presenter = LoginPresenter(interactor: interactor, router: router)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
