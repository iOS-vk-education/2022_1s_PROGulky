//
//  SelectedPlacesManager.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import Foundation

// MARK: - SelectedPlacesManagerProtocol

protocol SelectedPlacesManagerProtocol {
    var selectedPlaces: [Place] { get }
    func addOrRemovePlace(_ place: Place)
    func removeAll()

    func remove(at index: Int)
    func swap(from: Int, to: Int)
}

// MARK: - SelectedPlacesManager

final class SelectedPlacesManager {
    private var userSelectedPlaces = [Place]()
    static var sharedInstance: SelectedPlacesManagerProtocol = SelectedPlacesManager()
}

// MARK: SelectedPlacesManagerProtocol

extension SelectedPlacesManager: SelectedPlacesManagerProtocol {
    var selectedPlaces: [Place] {
        userSelectedPlaces
    }

    func addOrRemovePlace(_ place: Place) {
        if userSelectedPlaces.contains(where: { $0.id == place.id }) {
            userSelectedPlaces = userSelectedPlaces.filter { pl in
                pl.id != place.id
            }
        } else {
            var newPlace = place
            newPlace.sort = userSelectedPlaces.count + 1
            userSelectedPlaces.append(newPlace)
        }
    }

    func removeAll() {
        userSelectedPlaces.removeAll()
    }

    func remove(at index: Int) {
        userSelectedPlaces.remove(at: index)
        userSelectedPlaces = userSelectedPlaces.enumerated().map { el in
            var newElement = el.element
            newElement.sort = el.offset + 1
            return newElement
        }
    }

    func swap(from: Int, to: Int) {
        userSelectedPlaces.swapAt(from, to)
        userSelectedPlaces = userSelectedPlaces.enumerated().map { el in
            var newElement = el.element
            newElement.sort = el.offset + 1
            return newElement
        }
    }
}
