//
//  Rating.swift
//  PROGulky
//
//  Created by Иван Тазенков on 25.05.2023.
//

import Foundation
enum RatingState: String {
    case alreadyRated = "addition.rejected"
    case success = "successful.addition"
    case notYet = ""

    init(_ fromRawValue: String) {
        self = RatingState(rawValue: fromRawValue) ?? .notYet
    }

    var message: String {
        switch self {
        case .alreadyRated:
            return "Эта экскурсия уже была оценена. Повторная оценка невозможна"
        case .success:
            return "Экскурсия успешно оценена"
        case .notYet:
            return "Оцените экскурсию"
        }
    }
}
