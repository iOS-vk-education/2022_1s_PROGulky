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
    func didSelectSignInBtn(user: User) {
        let defaults = UserDefaults.standard
        defaults.set(user.token, forKey: UserKeys.token)
        defaults.set(user.id, forKey: UserKeys.id)
        defaults.set(user.email, forKey: UserKeys.email)
        defaults.set(user.name, forKey: UserKeys.name)
        defaults.set(user.role.description, forKey: UserKeys.role)
        defaults.set(false, forKey: "isLoggedOut")
        defaults.synchronize()
        moduleOutput?.loginModuleWantsToOpenProfile()
    }

    func didSelectSignUpBtn() {
        moduleOutput?.loginModuleWantsToOpenRegistrationModule()
    }
}

extension LoginPresenter: LoginInteractorOutput {
}
