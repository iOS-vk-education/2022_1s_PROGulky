//
//  Excursion.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 13.11.2022.
//

import Foundation

// MARK: - Excursion

struct Excursion: Codable {
    let title, description: String
    let ownerId: Int
    var image: String?
    var rating: Double?
    var duration: Int // Продолжительность в минутах
    var distance: Double // Дистанция в километрах
    var numberOfPoints: Int // Количество точек на маршруте
    let ownerRoleValue: String
    let owner: Owner
    var places: [Place]
}

typealias Excursions = [Excursion]
