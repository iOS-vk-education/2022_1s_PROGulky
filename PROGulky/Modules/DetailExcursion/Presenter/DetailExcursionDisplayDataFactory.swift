//
//  DetailExcursionDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.11.2022.
//

import Foundation

// MARK: - DetailExcursionDisplayDataFactoryProtocol

protocol DetailExcursionDisplayDataFactoryProtocol {
    func getPlaces(for excursion: Excursion) -> [Place]

    func getPlaceViewModel(for index: Place) -> PlaceViewModel

    func getDetailExcursionInfoViewModel(for excursion: Excursion) -> DetailExcursionInfoViewModel
}

// MARK: - DetailExcursionDisplayDataFactory

class DetailExcursionDisplayDataFactory: DetailExcursionDisplayDataFactoryProtocol {
    func getDetailExcursionInfoViewModel(for excursion: Excursion) -> DetailExcursionInfoViewModel {
        DetailExcursionInfoViewModel(
            title: excursion.title,
            rating: excursion.rating,
            numberOfPlaces: "\(excursion.numberOfPoints) мест",
            duration: "\(excursion.duration) мин",
            distance: "\(excursion.distance) км"
        )
    }

    func getPlaceViewModel(for place: Place) -> PlaceViewModel {
        PlaceViewModel(sort: String(place.sort), title: place.title, subtitle: place.address)
    }

    func getPlaces(for excursion: Excursion) -> [Place] {
        excursion.places
    }
}
