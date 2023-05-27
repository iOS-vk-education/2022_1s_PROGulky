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
    let title: String
    let description: String
    var image: String?
    var rating: Double?
    var duration: Int // Продолжительность в минутах
    var distance: Double // Дистанция в километрах
    var numberOfPoints: Int // Количество точек на маршруте
    let owner: OwnerInstance
    var places: [PreviewPlace]
    var isFavorite: Bool
}

extension Excursion {
    static var empty: Excursion = .init(
        id: 0,
        title: "",
        description: "",
        duration: 0,
        distance: 0,
        numberOfPoints: 0,
        owner: OwnerInstance(
            id: 0,
            name: "",
            email: "",
            image: "",
            role: Role(
                id: 0,
                value: "",
                description: ""
            )
        ),
        places: [],
        isFavorite: false
    )
}

typealias Excursions = [Excursion]

// MARK: - PreviewExcursion

struct PreviewExcursion: Codable {
    let id: Int
    let title: String
    var image: String?
    var rating: Double?
    var duration: Int // Продолжительность в минутах
    var distance: Double // Дистанция в километрах
    var numberOfPoints: Int // Количество точек на маршруте
    let owner: OwnerInstance
}

typealias PreviewExcursions = [PreviewExcursion]

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
