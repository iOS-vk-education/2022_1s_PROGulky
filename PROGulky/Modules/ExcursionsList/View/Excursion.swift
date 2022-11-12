//
//  Excursion.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 06.11.2022.
//

import Foundation

// MARK: - Excursion

struct Excursion {
    var image: String?
    var title: String
    var rating: Double
    var duration: Int // Продолжительность в минутах
    var numberOfPoints: Int // Количество точек на маршруте
    var distance: Double // Дистанция в километрах
}

// MARK: - ExcursionViewModel

struct ExcursionViewModel {
    var image: String?
    var title: String
    var rating: Double
    var parameters: String
}
