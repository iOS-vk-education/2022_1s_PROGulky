//
//  UserService.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 24.12.2022.
//

import Foundation

// MARK: - UserServiceProtocol

protocol UserServiceProtocol {
    func getUserData() -> UserData
}

// MARK: - UserService

// Сервис, который может получать данные о пользователе
final class UserService: UserServiceProtocol {
    static let shared = UserService()

    func getUserData() -> UserData {
        UserDefaultsManager.shared.getUserData()
    }

    func getUserToken() -> String {
        UserDefaultsManager.shared.getUserData().token
    }
}
