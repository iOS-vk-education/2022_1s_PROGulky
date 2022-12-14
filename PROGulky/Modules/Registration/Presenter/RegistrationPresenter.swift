//
//  RegistrationPresenter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import Foundation

// MARK: - RegistrationPresenter

final class RegistrationPresenter {
    // MARK: - Public Properties

    weak var view: RegistrationViewInput!
    weak var moduleOutput: RegistrationModuleOutput?

    // MARK: - Private Properties

    private let interactor: RegistrationInteractorInput
    private let router: RegistrationRouterInput

    // MARK: - Lifecycle

    init(interactor: RegistrationInteractorInput, router: RegistrationRouterInput,
         moduleOutput: RegistrationModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput
    }
}

extension RegistrationPresenter: RegistrationModuleInput {
}

// MARK: RegistrationViewOutput

extension RegistrationPresenter: RegistrationViewOutput {
    func didSelectSignUpBtn(token: String, id: Int, email: String, name: String, role: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(token, forKey: UserKeys().token)
        defaults.set(id, forKey: UserKeys().id)
        defaults.set(email, forKey: UserKeys().email)
        defaults.set(name, forKey: UserKeys().name)
        defaults.set(role, forKey: UserKeys().role)
        defaults.set(false, forKey: "isLoggedOut")
        defaults.synchronize()
        moduleOutput?.registrationModuleWantsToOpenProfile()
    }
}

extension RegistrationPresenter: RegistrationInteractorOutput {
}
