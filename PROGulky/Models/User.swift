//
//  User.swift
//  PROGulky
//
//  Created by Сергей Киселев on 02.12.2022.
//

// MARK: - User

struct User: Codable {
    let token: String
    let id: Int
    let name: String
    let email: String
    let role: Role
}

// MARK: - Role

struct Role: Codable {
    let id: Int
    let value: String
    let description: String
}
