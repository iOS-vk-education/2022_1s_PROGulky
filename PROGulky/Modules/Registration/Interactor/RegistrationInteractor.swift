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
    // Для регистрации необходимо:
    // 1. Отправить DTO пользователя на ручку /auth/registration
    // 2. Получить токены пользователя
    // 3. Получить персональные данные пользователя ручка /auth/me
    func registration(_ registrationDTO: RegistrationDTO) {
        UserAuthService.shared.registration(dto: registrationDTO) { [weak self] result in
            switch result {
            case let .success(authData): // Токены успешно получены
                // Запрос за личными данными на ручку /auth/me
                print("[DEBUG] auth data: \(authData)")
                guard let token = authData.accessToken else { return }
                UserAuthService.shared.getMeInfo(completion: { [weak self] result in
                    switch result {
                    case let .success(userData):
                        print("[DEBUG] userData: \(userData)")
                        self?.output?.successRegistration(user: userData)
                    case let .failure(error):
                        self?.output?.handleError(error: error)
                    }
                }, token: token)
            case let .failure(error):
                self?.output?.handleError(error: error)
            }
        }
    }
}
