//
//  UserAuthService.swift
//  PROGulky
//
//  Created by Сергей Киселев on 22.12.2022.
//

import Foundation

// MARK: - UserDefaultsLoginServiceProtocol

protocol UserDefaultsLoginServiceProtocol {
    func setUserAuthData(user: User)
    func removeUserAuthData()
    func getUserData() -> UserData
}

// MARK: - UserDefaultsManager

final class UserDefaultsManager: UserDefaultsLoginServiceProtocol {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    func setUserAuthData(user: User) {
        defaults.set(user.token, forKey: UserKeys.token.rawValue)
        defaults.set(user.id, forKey: UserKeys.id.rawValue)
        defaults.set(user.email, forKey: UserKeys.email.rawValue)
        defaults.set(user.name, forKey: UserKeys.name.rawValue)
        defaults.set(user.role.description, forKey: UserKeys.role.rawValue)
        defaults.set(true, forKey: UserKeys.isLogin.rawValue)
        defaults.synchronize()
    }

    func removeUserAuthData() {
        UserKeys.AllCases().forEach { key in
            defaults.removeObject(forKey: key.rawValue)
        }
        defaults.set(false, forKey: UserKeys.isLogin.rawValue)
        defaults.synchronize()
    }

    // метод мне не нравится
    func isLogged() -> Bool {
        guard defaults.string(forKey: UserKeys.isLogin.rawValue) != nil else {
            return false
        }
        if let isAuth = defaults.string(forKey: UserKeys.isLogin.rawValue) {
            if isAuth == "1" { // не знаю как избавиться от этого сравнения строк.
                return true
            }
        }
        return false
    }

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
}
