//
//  UserLoginService.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 24.12.2022.
//

import Foundation

// MARK: - UserAuthService

// Сервис, который может
// 1. проверять наличие логина
// 2. логинить
// 3. регистрировать
// 4. выходить из аккаунта
final class UserAuthService {
    static let shared = UserAuthService()

    var isLogged: Bool {
        UserDefaultsManager.shared.isLogged
    }

    func registration(dto: RegistrationDTO, completion: @escaping (Result<User, Error>) -> Void) {
        ApiManager.shared.registration(dto) { result in
            switch result {
            case let .success(user):
                UserDefaultsManager.shared.setUserAuthData(user: user)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            case let .failure(failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }

    func login(dto: LoginDTO, completion: @escaping (Result<User, Error>) -> Void) {
        ApiManager.shared.login(dto) { result in
            switch result {
            case let .success(user):
                UserDefaultsManager.shared.setUserAuthData(user: user)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            case let .failure(failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }

    func logout() {
        UserDefaultsManager.shared.removeUserAuthData()
    }
}
