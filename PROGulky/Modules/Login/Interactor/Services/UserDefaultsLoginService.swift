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
}

// MARK: - UserDefaultsUserInfoProtocol

protocol UserDefaultsUserInfoProtocol {
    func getUserInfo() -> UserInfoHeader.DisplayData?
}

// MARK: - UserDefaultsLoginService

final class UserDefaultsLoginService: UserDefaultsLoginServiceProtocol {
    static let shared = UserDefaultsLoginService()
    private let defaults = UserDefaults.standard
    var isLogin = false

    func setUserAuthData(user: User) {
        defaults.set(user.token, forKey: UserKeys.token.rawValue)
        defaults.set(user.id, forKey: UserKeys.id.rawValue)
        defaults.set(user.email, forKey: UserKeys.email.rawValue)
        defaults.set(user.name, forKey: UserKeys.name.rawValue)
        defaults.set(user.role.description, forKey: UserKeys.role.rawValue)
        defaults.set(true, forKey: UserKeys.isLogin.rawValue)
        defaults.synchronize()
        isLogin = true // подумать как по другому
    }

    func removeUserAuthData() {
        UserKeys.AllCases().forEach { key in
            defaults.removeObject(forKey: key.rawValue)
        }
        defaults.set(false, forKey: UserKeys.isLogin.rawValue)
        defaults.synchronize()
        isLogin = false // подумать как по другому
    }
}

// MARK: UserDefaultsUserInfoProtocol

extension UserDefaultsLoginService: UserDefaultsUserInfoProtocol {
    func getUserInfo() -> UserInfoHeader.DisplayData? {
        guard let status = defaults.string(forKey: UserKeys.role.rawValue),
              let username = defaults.string(forKey: UserKeys.name.rawValue) else { return nil }

        return UserInfoHeader.DisplayData(username: username, status: status)
    }
}
