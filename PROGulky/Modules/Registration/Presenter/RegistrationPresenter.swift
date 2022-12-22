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
    func didTapSignUpButton(registrationDTO: RegistrationDTO) {
        interactor.registration(registrationDTO)
    }
}

// MARK: RegistrationInteractorOutput

extension RegistrationPresenter: RegistrationInteractorOutput {
    func successRegistration(user: User) {
        moduleOutput?.registrationModuleWantsToOpenProfile()
    }

    func handleError(error: Error) {
        let text = error.localizedDescription
        view.showAlert(message: text)
    }
}
