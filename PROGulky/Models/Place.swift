//
//  Place.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 19.11.2022.
//

import Foundation

// MARK: - Place

struct Place: Codable {
    var id: Int?
    var sort: Int?
    let title: String
    let description: String
    let image: String?
    let address: String
    let city: String
    let latitude: Double
    let longitude: Double
}

// MARK: Identifiable

extension Place: Identifiable {
//    var id: Int {
//        get {
//            sort ?? 0
//        }
//        set(newVal) {
//            sort = newVal
//        }
//    }
}

// MARK: - PlaceWithImageData

struct PlaceWithImageData: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let image: String
    let address: String
    let city: String
    let latitude: Double
    let longitude: Double
}
