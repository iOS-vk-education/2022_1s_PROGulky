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
    weak var moduleOutput: LoginModuleOutput?

    // MARK: - Private Properties

    private let interactor: LoginInteractorInput
    private let router: LoginRouterInput

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
    func didSelectSignUpBtn() {
        moduleOutput?.loginModuleWantsToOpenSingUp()
    }

    func didSelectSignInBtn(token: String, id: Int, email: String, name: String, role: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: UserKeys().token)
        defaults.set(id, forKey: UserKeys().id)
        defaults.set(email, forKey: UserKeys().email)
        defaults.set(name, forKey: UserKeys().name)
        defaults.set(role, forKey: UserKeys().role)
        defaults.set(false, forKey: "isLoggedOut")
        defaults.synchronize()
        moduleOutput?.loginModuleWantsToOpenProfile()
    }
}

extension LoginPresenter: LoginInteractorOutput {
}
