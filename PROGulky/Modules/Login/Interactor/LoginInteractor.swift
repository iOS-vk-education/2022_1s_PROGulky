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
    // Для логина необходимо
    // 1. Получить токены пользователя (ручка /login)
    // 2. Получить персональные данные пользователя (ручка /me)
    // Тут это происходит во такой нетривиальной вложенности
    func login(_ loginDTO: LoginDTO) {
        UserAuthService.shared.login(dto: loginDTO) { [weak self] result in
            switch result {
            case let .success(authData):
                guard let token = authData.accessToken else { return }
                UserAuthService.shared.getMeInfo(completion: { [weak self] result in
                    switch result {
                    case let .success(userData):
                        print("[DEBUG] \(userData)")
                        self?.output?.didSuccessLogin(with: userData)
                    case let .failure(error):
                        print("[DEBUG] \(error)")
                        self?.output?.didHandleError(with: error)
                    }
                }, token: token)
            case let .failure(error):
                print("[DEBUG] \(error)")
                self?.output?.didHandleError(with: error)
            }
        }
    }
}
