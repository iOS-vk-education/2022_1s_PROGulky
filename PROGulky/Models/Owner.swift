//
//  Owner.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.11.2022.
//

import Foundation

// MARK: - OwnerInstance

// Новая стурктура пользователя с его ролью
struct OwnerInstance: Codable {
    let id: Int
    let name, email: String
    let image: String?
    let role: Role
}
