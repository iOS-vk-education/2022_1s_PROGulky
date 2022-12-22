//
//  LoginInteractor.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import Foundation

// MARK: - LoginInteractor

final class LoginInteractor {
    weak var output: LoginInteractorOutput?
    private let userDefaultsLoginService: UserDefaultsLoginServiceProtocol

    init(userDefaultsLoginService: UserDefaultsLoginServiceProtocol) {
        self.userDefaultsLoginService = userDefaultsLoginService
    }
}

// MARK: LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
    func login(_ loginDTO: LoginDTO) {
        ApiManagerLogin.shared.login(loginDTO) { [weak self] result in
            switch result {
            case let .success(user):
                self?.userDefaultsLoginService.setUserAuthData(user: user)
                self?.output?.successLogin(user: user)
            case let .failure(failure):
                self?.output?.handleError(error: failure)
            }
        }
    }
}
