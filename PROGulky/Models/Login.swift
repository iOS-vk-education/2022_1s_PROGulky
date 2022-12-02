//
//  Login.swift
//  PROGulky
//
//  Created by Сергей Киселев on 02.12.2022.
//

// MARK: - Login

struct Login: Codable {
    let token: String
    let id: Int
    let name: String
    let email: String
    let role: Role

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        token = try values.decode(String.self, forKey: .token)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        role = try values.decode(Role.self, forKey: .role)
    }
}

// MARK: - Role

struct Role: Codable {
    let id: Int
    let value: String
    let description: String
}
