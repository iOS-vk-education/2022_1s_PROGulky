//
//  Place.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 19.11.2022.
//

import Foundation

// MARK: - Place

struct Place: Codable {
    let sort: Int?
    let title: String
    let description: String
    let image: String?
    let address: String
    let city: String
    let latitude, longitude: Double
}
