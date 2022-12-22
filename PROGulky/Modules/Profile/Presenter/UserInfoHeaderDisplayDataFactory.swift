//
//  UserInfoHeaderDisplayDataFactory.swift
//  PROGulky
//
//  Created by Сергей Киселев on 22.12.2022.
//

import Foundation

// MARK: - UserInfoHeaderDisplayDataFactoryProtocol

protocol UserInfoHeaderDisplayDataFactoryProtocol {
    func getDisplayData() -> UserInfoHeader.DisplayData
}

// MARK: - UserInfoHeaderDisplayDataFactory

final class UserInfoHeaderDisplayDataFactory: UserInfoHeaderDisplayDataFactoryProtocol {
    func getDisplayData() -> UserInfoHeader.DisplayData {
        let service: UserDefaultsUserInfoProtocol = UserDefaultsLoginService()
        guard let data = service.getUserInfo() else {
            return UserInfoHeader.DisplayData(username: "", status: "")
        }

        let displayData = UserInfoHeader.DisplayData(username: data.username, status: "статус - " + data.status)
        return displayData
    }
}
