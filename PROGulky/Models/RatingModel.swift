//
//  Rating.swift
//  PROGulky
//
//  Created by Иван Тазенков on 25.05.2023.
//

import Foundation

// MARK: - RatingRequest

struct RatingRequest: Encodable {
    let excursionId: Int
    let rating: Int
    let comment: String
}

// MARK: - RatingResponse

struct RatingResponse: Decodable {
    let status: String
    let message: String
}

extension RatingResponse {
    static var error: RatingResponse {
        RatingResponse(status: "error", message: "Произошла ошибка")
    }
}
