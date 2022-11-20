//
//  ExcursionsListDisplayDataFactory.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 11.11.2022.
//

import UIKit

// MARK: - ExcursionsListDisplayDataFactoryProtocol

protocol ExcursionsListDisplayDataFactoryProtocol {
    // Заглушка, пока нет работы с сетью. Этот метод тут не нужен
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

    // Заглушка, пока нет работы с сетью. Этот метод тут не нужен
    func setExcursionsListDisplayData() -> [Excursion] {
        let places = [
            Place(
                sort: 1,
                title: "Большой театр",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "Театральная площадь, 1",
                city: "Москва",
                latitude: "55.760452",
                longitude: "37.618373"
            ),
            Place(
                sort: 2,
                title: "Московский Кремль",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "Москва, Ивановская площадь",
                city: "Москва",
                latitude: "55.760452",
                longitude: "37.618373"
            ),
            Place(
                sort: 3,
                title: "Собор Покрова Пресвятой Богородицы на Рву",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "Красная площадь, 7",
                city: "Москва",
                latitude: "55.760452",
                longitude: "37.618373"
            ),
            Place(
                sort: 4,
                title: "Кафедральный собор Храма Христа Спасителя",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "ул. Волхонка 15",
                city: "Москва",
                latitude: "55.760452",
                longitude: "37.618373"
            )
        ]

        let e1 = Excursion(
            image: nil,
            title: "Интересная Москва",
            rating: 5.0,
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            duration: 60,
            numberOfPoints: 1,
            distance: 2.2,
            places: places
        )
        let e2 = Excursion(
            image: nil,
            title: "Театры Москвы",
            rating: 4.96,
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            duration: 65,
            numberOfPoints: 2,
            distance: 3.2,
            places: places
        )
        let e3 = Excursion(
            image: nil,
            title: "Парки",
            rating: 3.33,
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            duration: 90,
            numberOfPoints: 3,
            distance: 4.4,
            places: places
        )
        let e4 = Excursion(
            image: nil,
            title: "Пешеходная тропа",
            rating: 3.7,
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            duration: 100,
            numberOfPoints: 5,
            distance: 4.4,
            places: places
        )
        let e5 = Excursion(
            image: nil,
            title: "Обзорная",
            rating: 4.5,
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            duration: 50,
            numberOfPoints: 6,
            distance: 1.9,
            places: places
        )

        return [e1, e2, e3, e4, e5]
    }
}
