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
}

// MARK: RegistrationInteractorInput

extension RegistrationInteractor: RegistrationInteractorInput {
    func registration(_ registrationDTO: RegistrationDTO) {
        UserAuthService.shared.registration(dto: registrationDTO) { [weak self] result in
            switch result {
            case let .success(user):
                self?.output?.successRegistration(user: user)
            case let .failure(error):
                self?.output?.handleError(error: error)
            }
        }
    }
}
