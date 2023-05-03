//
//  ExcursionsListDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 11.11.2022.
//

import UIKit

// MARK: - FilterButtonViewModel

struct FilterButtonViewModel {
    let title: String
    let isSelected: Bool

    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

// MARK: - ExcursionsListDisplayDataFactoryProtocol

protocol ExcursionsListDisplayDataFactoryProtocol {
    func getExcursionViewModel(for: PreviewExcursion) -> ExcursionViewModel
}

// MARK: - ExcursionsListDisplayDataFactory

final class ExcursionsListDisplayDataFactory: ExcursionsListDisplayDataFactoryProtocol {
    func getExcursionViewModel(for excursion: PreviewExcursion) -> ExcursionViewModel {
        var displayRating: String
        if let rating = excursion.rating {
            displayRating = "\(rating)"
        } else {
            displayRating = "Без рейтинга"
        }

        return ExcursionViewModel(
            image: excursion.image,
            title: excursion.title,
            rating: displayRating,
            parameters: "\(excursion.numberOfPoints.wordEnding(for: "мест")) | \(excursion.distance) км | \(excursion.duration) мин",
            owner: excursion.owner.name
        )
    }

    func getGreetingViewModel(for user: UserData?) -> GreetingViewModel {
        guard let user = user else {
            return GreetingViewModel(
                labelText: ExcursionsListConstants.GreetingMessage.labelTextIsNotLoggedUser,
                buttonText: ExcursionsListConstants.GreetingMessage.buttonTextIsNotLoggedUser
            )
        }

        return GreetingViewModel(
            labelText: ExcursionsListConstants.GreetingMessage.labelTextIsLoggedUser,
            buttonText: "\(user.name)!"
        )
    }
}
