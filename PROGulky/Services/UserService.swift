//
//  UserService.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 24.12.2022.
//

import Foundation

// MARK: - UserService

// Сервис, который может получать данные о пользователе
final class UserService {
    static let shared = UserService()

    var userId: Int? {
        UserDefaultsManager.shared.getUserId()
    }

    var userData: UserData {
        UserDefaultsManager.shared.getUserData()
    }

    var userToken: String {
        UserDefaultsManager.shared.getToken().accessToken ?? ""
    }
}
