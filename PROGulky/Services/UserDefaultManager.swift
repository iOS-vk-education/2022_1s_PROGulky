//
//  UserAuthService.swift
//  PROGulky
//
//  Created by Сергей Киселев on 22.12.2022.
//

import Foundation

// MARK: - UserDefaultsLoginServiceProtocol

protocol UserDefaultsLoginServiceProtocol {
    func setUserData(user: User)
    func setUserAuthData(token: Auth)
    func removeUserAuthData()
    func getUserData() -> UserData
}

// MARK: - UserDefaultsManager

final class UserDefaultsManager: UserDefaultsLoginServiceProtocol {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    func setUserAuthData(token: Auth) {
        defaults.set(token.accessToken, forKey: UserKeys.accessToken.rawValue)
        defaults.set(token.refreshToken, forKey: UserKeys.refreshToken.rawValue)
        defaults.set(true, forKey: UserKeys.isLogin.rawValue)
    }

    func setUserData(user: User) {
//        defaults.set(user.token, forKey: UserKeys.token.rawValue)
        defaults.set(user.id, forKey: UserKeys.id.rawValue)
        defaults.set(user.email, forKey: UserKeys.email.rawValue)
        defaults.set(user.name, forKey: UserKeys.name.rawValue)
        defaults.set(user.role?.description, forKey: UserKeys.role.rawValue)
//        defaults.set(true, forKey: UserKeys.isLogin.rawValue)
        defaults.synchronize()
    }

    func removeUserAuthData() {
        UserKeys.AllCases().forEach { key in
            defaults.removeObject(forKey: key.rawValue)
        }
        defaults.set(false, forKey: UserKeys.isLogin.rawValue)
        defaults.synchronize()
    }

    var isLogged: Bool {
        guard
            defaults.string(forKey: UserKeys.isLogin.rawValue) != nil,
            let isAuth = defaults.string(forKey: UserKeys.isLogin.rawValue)
        else {
            return false
        }
        return isAuth == "1"
    }

//    // метод мне не нравится
//    func isLogged() -> Bool {
//        guard defaults.string(forKey: UserKeys.isLogin.rawValue) != nil else {
//            return false
//        }
//        if let isAuth = defaults.string(forKey: UserKeys.isLogin.rawValue) {
//            if isAuth == "1" { // не знаю как избавиться от этого сравнения строк.
//                return true
//            }
//        }
//        return false
//    }

    func getUserData() -> UserData {
        let token = defaults.string(forKey: UserKeys.token.rawValue)
        let email = defaults.string(forKey: UserKeys.email.rawValue)
        let name = defaults.string(forKey: UserKeys.name.rawValue)
        let displayRole = defaults.string(forKey: UserKeys.role.rawValue)

        let userData = UserData(
            name: name ?? "",
            email: email ?? "",
            token: token ?? "",
            role: displayRole ?? ""
        )
        return userData
    }

    func getToken() -> Auth {
        let accessToken = defaults.string(forKey: UserKeys.accessToken.rawValue)
        let refreshToken = defaults.string(forKey: UserKeys.refreshToken.rawValue)
        let refreshExpiresAt = defaults.string(forKey: UserKeys.refreshExpiresAt.rawValue)

        let token = Auth(
            accessToken: accessToken ?? "",
            refreshToken: refreshToken ?? "",
            refreshExpiresAt: refreshExpiresAt ?? "",
            message: "",
            statusCode: 0
        )
        return token
    }
}
