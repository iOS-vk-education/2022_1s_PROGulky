//
//  RegistrationInteractor.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//
import Foundation

// MARK: - RegistrationInteractor

final class RegistrationInteractor {
    weak var output: RegistrationInteractorOutput?
    private let service = UserDefaultsLoginService.shared
}

// MARK: RegistrationInteractorInput

extension RegistrationInteractor: RegistrationInteractorInput {
    func registration(_ registrationDTO: RegistrationDTO) {
        ApiManagerLogin.shared.registration(registrationDTO) { [weak self] result in
            switch result {
            case let .success(user):
                self?.service.setUserAuthData(user: user)
                self?.output?.successRegistration(user: user)
            case let .failure(failure):
                self?.output?.handleError(error: failure)
            }
        }
    }
}
