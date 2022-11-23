//
//  LoginPresenter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - LoginPresenter

final class LoginPresenter {
    // MARK: - Public Properties

    weak var view: LoginViewInput!

    // MARK: - Private Properties

    private let interactor: LoginInteractorInput
    private let router: LoginRouterInput

    // MARK: - Lifecycle

    init(interactor: LoginInteractorInput, router: LoginRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension LoginPresenter: LoginModuleInput {
}

extension LoginPresenter: LoginViewOutput {
}

extension LoginPresenter: LoginInteractorOutput {
}
