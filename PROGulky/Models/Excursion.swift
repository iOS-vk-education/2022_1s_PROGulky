//
//  Excursion.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 13.11.2022.
//

import Foundation
import UIKit

// MARK: - Excursion

struct Excursion: Codable {
    let id: Int
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
    var isFavorite: Bool
}

typealias Excursions = [Excursion]

// MARK: - ExcursionForPost

struct ExcursionForPost {
    let title: String
    let description: String
    let image: UIImage
    let duration: Int
    let distance: Double
    let placesIds: String
}

// MARK: - ExcursionAfterPost

struct ExcursionAfterPost: Codable {
    let id: Int?
    let title: String?
}
