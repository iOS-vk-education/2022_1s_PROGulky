//
//  ExcursionsListDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 11.11.2022.
//

import UIKit

// MARK: - ExcursionsListDisplayDataFactoryProtocol

protocol ExcursionsListDisplayDataFactoryProtocol {
    func setExcursionsListDisplayData() -> [Excursion]

    func getExcursionViewModel(for: Excursion) -> ExcursionViewModel
}

// MARK: - ExcursionsListDisplayDataFactory

final class ExcursionsListDisplayDataFactory: ExcursionsListDisplayDataFactoryProtocol {
    func getExcursionViewModel(for excursion: Excursion) -> ExcursionViewModel {
        ExcursionViewModel(
            image: excursion.image,
            title: excursion.title,
            rating: excursion.rating,
            parameters: "\(excursion.numberOfPoints) точек | \(excursion.distance) км | \(excursion.duration) мин"
        )
    }

    func setExcursionsListDisplayData() -> [Excursion] {
        let e1 = Excursion(
            image: nil,
            title: "Интересная Москва",
            rating: 5.0,
            duration: 60,
            numberOfPoints: 5,
            distance: 2.2
        )
        let e2 = Excursion(
            image: nil,
            title: "Театры Москвы",
            rating: 4.96,
            duration: 65,
            numberOfPoints: 6,
            distance: 3.2
        )
        let e3 = Excursion(
            image: nil,
            title: "Парки",
            rating: 3.33,
            duration: 90,
            numberOfPoints: 9,
            distance: 4.4
        )
        let e4 = Excursion(
            image: nil,
            title: "Пешеходная тропа",
            rating: 3.7,
            duration: 100,
            numberOfPoints: 9,
            distance: 4.4
        )
        let e5 = Excursion(
            image: nil,
            title: "Обзорная",
            rating: 4.5,
            duration: 50,
            numberOfPoints: 6,
            distance: 1.9
        )

        return [e1, e2, e3, e4, e5]
    }
}
