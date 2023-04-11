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
}

// MARK: LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
    func login(_ loginDTO: LoginDTO) {
        UserAuthService.shared.login(dto: loginDTO) { [weak self] result in
            switch result {
            case let .success(token):
                UserAuthService.shared.setUserInfo { [weak self] result in
                    switch result {
                    case let .success(token):
                        self?.output?.successLogin(id: token)
                    case let .failure(error):
                        self?.output?.handleError(error: error)
                    }
                }
            //                self?.output?.successLogin(token: token)
            case let .failure(error):
                self?.output?.handleError(error: error)
            }
        }
    }
}
