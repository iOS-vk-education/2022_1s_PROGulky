//
//  LoginPresenter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import Foundation

// MARK: - LoginPresenter

final class LoginPresenter {
    // MARK: - Public Properties

    weak var view: LoginViewInput!

    // MARK: - Private Properties

    private let interactor: LoginInteractorInput
    private let router: LoginRouterInput
    private weak var moduleOutput: LoginModuleOutput?

    // MARK: - Lifecycle

    init(interactor: LoginInteractorInput,
         router: LoginRouterInput,
         moduleOutput: LoginModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput
    }
}

extension LoginPresenter: LoginModuleInput {
}

// MARK: LoginViewOutput

extension LoginPresenter: LoginViewOutput {
    func didTapSignInButton(loginDTO: LoginDTO) {
        interactor.login(loginDTO)
    }

    func didSelectSignUpBtn() {
        moduleOutput?.loginModuleWantsToOpenRegistrationModule()
    }
}

// MARK: LoginInteractorOutput

extension LoginPresenter: LoginInteractorOutput {
    func didSuccessLogin(with token: User) {
        moduleOutput?.loginModuleWantsToOpenProfile()
    }

    func didHandleError(with error: Error) {
        let text = error.localizedDescription
        view.showAlert(message: text)
    }
}
