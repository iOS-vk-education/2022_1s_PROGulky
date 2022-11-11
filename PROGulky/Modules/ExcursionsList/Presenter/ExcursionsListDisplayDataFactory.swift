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
}

// MARK: - ExcursionsListDisplayDataFactory

final class ExcursionsListDisplayDataFactory: ExcursionsListDisplayDataFactoryProtocol {
    func setExcursionsListDisplayData() -> [Excursion] {
        let e1 = Excursion(image: nil, title: "Интересная Москва", rating: 5.0, parameters: "2 часа | 3 км | 6 точек")
        let e2 = Excursion(image: nil, title: "Театры Москвы", rating: 4.99, parameters: "2 часа | 3 км | 6 точек")
        let e3 = Excursion(image: nil, title: "Парки", rating: 3.3, parameters: "2 часа | 3 км | 6 точек")
        let e4 = Excursion(image: nil, title: "Пешеходная тропа", rating: 4.5, parameters: "2 часа | 3 км | 6 точек")
        let e5 = Excursion(image: nil, title: "Обзорная", rating: 4.8, parameters: "2 часа | 3 км | 6 точек")

        return [e1, e2, e3, e4, e5]
    }
}
