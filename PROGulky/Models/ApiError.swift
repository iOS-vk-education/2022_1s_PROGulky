//
//  ApiError.swift
//  PROGulky
//
//  Created by Сергей Киселев on 03.04.2023.
//

import Foundation

struct ApiError: Codable {
    let message: String
    let statusCode: Int
}
