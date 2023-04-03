//
//  ExcursionsListDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 11.11.2022.
//

import UIKit

// MARK: - ExcursionsListDisplayDataFactoryProtocol

protocol ExcursionsListDisplayDataFactoryProtocol {
    func getExcursionViewModel(for: PreviewExcursion) -> ExcursionViewModel

    func getDistanceFilterParameters() -> [Int: ChipsButton]
}

// MARK: - ExcursionsListDisplayDataFactory

final class ExcursionsListDisplayDataFactory: ExcursionsListDisplayDataFactoryProtocol {
    func getDistanceFilterParameters() -> [Int: ChipsButton] {
        let buttons: [Int: ChipsButton] = [
            1: ChipsButton(title: "Все", apiParameters: ["l_f_p": "0", "l_s_p": "100"]),
            2: ChipsButton(title: "1 - 3 км", apiParameters: ["l_f_p": "1", "l_s_p": "3"]),
            3: ChipsButton(title: "3 - 6 км", apiParameters: ["l_f_p": "3", "l_s_p": "6"]),
            4: ChipsButton(title: "6 - 10 км", apiParameters: ["l_f_p": "6", "l_s_p": "10"])
        ]
        return buttons
    }

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
            parameters: "\(excursion.numberOfPoints.wordEnding(for: "мест")) | \(excursion.distance) км | \(excursion.duration) мин"
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
