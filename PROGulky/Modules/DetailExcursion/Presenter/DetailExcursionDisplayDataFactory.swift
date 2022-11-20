//
//  DetailExcursionDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.11.2022.
//

import Foundation

// MARK: - DetailExcursionDisplayDataFactoryProtocol

protocol DetailExcursionDisplayDataFactoryProtocol {
    func getPlaceViewModel(for index: Place) -> PlaceViewModel

    func getDetailExcursionInfoViewModel(for excursion: Excursion) -> DetailExcursionInfoViewModel

    func getDetailExcursionViewModel(for excursion: Excursion) -> DetailExcursionViewModel
}

// MARK: - DetailExcursionDisplayDataFactory

class DetailExcursionDisplayDataFactory: DetailExcursionDisplayDataFactoryProtocol {
    func getDetailExcursionViewModel(for excursion: Excursion) -> DetailExcursionViewModel {
        DetailExcursionViewModel(
            image: excursion.image ?? "picture",
            description: excursion.description
        )
    }

    func getDetailExcursionInfoViewModel(for excursion: Excursion) -> DetailExcursionInfoViewModel {
        DetailExcursionInfoViewModel(
            title: excursion.title,
            rating: String(excursion.rating),
            numberOfPlaces: (excursion.numberOfPoints).places(),
            duration: "\(excursion.duration) мин",
            distance: "\(excursion.distance) км"
        )
    }

    func getPlaceViewModel(for place: Place) -> PlaceViewModel {
        PlaceViewModel(sort: String(place.sort), title: place.title, subtitle: place.address)
    }
}
