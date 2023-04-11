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
                UserDefaultsManager.shared.saveUserData(user: user)
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

    // Получение токенов
    func login(dto: LoginDTO, completion: @escaping (Result<Auth, Error>) -> Void) {
        ApiManager.shared.login(dto) { result in
            switch result {
            case let .success(authData):
                UserDefaultsManager.shared.saveUserAuthData(authData: authData)
                DispatchQueue.main.async {
                    completion(.success(authData))
                }
            case let .failure(failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }

    func getMeInfo(completion: @escaping (Result<User, Error>) -> Void, token: String) {
        ApiManager.shared.getMeInfo(
            completion: { result in
                switch result {
                case let .success(user):
                    UserDefaultsManager.shared.saveUserData(user: user)
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

    func updateTokens() {
        guard let refreshToken = UserDefaults.standard.string(forKey: UserKeys.refreshToken.rawValue) else {
            return
        }

        ApiManager.shared.updateAccessTokenByRefresh(
            completion: { result in
                switch result {
                case let .success(authData):
                    UserDefaultsManager.shared.saveUserAuthData(authData: authData)
                case let .failure(error):
                    switch error.code {
                    case 401:
                        // TODO: чистить локальное хранилище. т к истек рефреш
                        print("[Debug]: resresh is expired")
                        UserDefaultsManager.shared.removeUserAuthData()
                    default:
                        break
                    }
                }
            },
            refreshToken: refreshToken
        )
    }

    func logout() {
        UserDefaultsManager.shared.removeUserAuthData()
    }
}
