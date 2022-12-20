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
    func didSelectSignUpBtn(user: User) {
        let defaults = UserDefaults.standard
        defaults.setValue(user.token, forKey: UserKeys.token)
        defaults.set(user.id, forKey: UserKeys.id)
        defaults.set(user.email, forKey: UserKeys.email)
        defaults.set(user.name, forKey: UserKeys.name)
        defaults.set(user.role.description, forKey: UserKeys.role)
        defaults.set(false, forKey: "isLoggedOut")
        defaults.synchronize()
        moduleOutput?.registrationModuleWantsToOpenProfile()
    }
}

extension RegistrationPresenter: RegistrationInteractorOutput {
}
