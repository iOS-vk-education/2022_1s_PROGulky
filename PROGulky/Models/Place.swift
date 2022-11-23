//
//  Place.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 19.11.2022.
//

import Foundation

// MARK: - Place

struct Place {
    var sort: Int // Номер на маршруте
    var title: String
    var description: String
    var image: String?
    var address: String
    var city: String
    var latitude: String // Широта
    var longitude: String // Долгота
}
