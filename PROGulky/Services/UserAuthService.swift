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
                UserDefaultsManager.shared.setUserData(user: user)
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

    func login(dto: LoginDTO, completion: @escaping (Result<Auth, Error>) -> Void) {
        ApiManager.shared.login(dto) { result in
            switch result {
            case let .success(token):
                UserDefaultsManager.shared.setUserAuthData(token: token)
                DispatchQueue.main.async {
                    completion(.success(token))
                }
            case let .failure(failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }

    func setUserInfo(completion: @escaping (Result<User, Error>) -> Void) {
        let token = UserService.shared.userToken
        ApiManager.shared.getUserInfo(
            completion: { result in
                switch result {
                case let .success(user):
                    UserDefaultsManager.shared.setUserData(user: user)
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                case let .failure(failure):
                    DispatchQueue.main.async {
                        completion(.failure(failure))
                    }
                }
            },
            token: token
        )
    }

    func logout() {
        UserDefaultsManager.shared.removeUserAuthData()
    }
}
