//
//  DetailExcursionDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.11.2022.
//

import Foundation

// MARK: - DetailExcursionDisplayDataFactoryProtocol

protocol DetailExcursionDisplayDataFactoryProtocol {
    func setupViewModel(excursion: Excursion) -> DetailExcursionViewModel

    func getPlaceViewModel(for index: Place) -> PlaceViewModel
}

// MARK: - DetailExcursionDisplayDataFactory

class DetailExcursionDisplayDataFactory: DetailExcursionDisplayDataFactoryProtocol {
    func getPlaceViewModel(for place: Place) -> PlaceViewModel {
        var sort = ""
        if let s = place.sort {
            sort = "\(s)"
        }
        return PlaceViewModel(sort: sort, title: place.title, subtitle: place.address)
    }

    func setupViewModel(excursion: Excursion) -> DetailExcursionViewModel {
        var displayRating: String
        if let rating = excursion.rating {
            displayRating = "\(rating)"
        } else {
            displayRating = "Без рейтинга"
        }

        return DetailExcursionViewModel(
            id: excursion.id,
            image: excursion.image ?? "placeholderImage",
            description: excursion.description,
            infoViewModel: DetailExcursionInfoViewModel(
                title: excursion.title,
                rating: displayRating,
                numberOfPlaces: excursion.numberOfPoints.wordEnding(for: "мест"),
                duration: "\(excursion.duration) мин",
                distance: "\(excursion.distance) км"
            ),
            isLiked: excursion.isFavorite
        )
    }
}
