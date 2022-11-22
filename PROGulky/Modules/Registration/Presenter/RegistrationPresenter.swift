//
//  RegistrationPresenter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - RegistrationPresenter

final class RegistrationPresenter {
    // MARK: - Public Properties

    weak var view: RegistrationViewInput!

    // MARK: - Private Properties

    private let interactor: RegistrationInteractorInput
    private let router: RegistrationRouterInput

    // MARK: - Lifecycle

    init(interactor: RegistrationInteractorInput, router: RegistrationRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension RegistrationPresenter: RegistrationModuleInput {
}

extension RegistrationPresenter: RegistrationViewOutput {
}

extension RegistrationPresenter: RegistrationInteractorOutput {
}
