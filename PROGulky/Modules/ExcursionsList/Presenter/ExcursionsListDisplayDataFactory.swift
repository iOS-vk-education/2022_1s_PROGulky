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
                latitude: 55.760452,
                longitude: 37.618373
            ),
            Place(
                sort: 2,
                title: "Московский Кремль",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "Москва, Ивановская площадь",
                city: "Москва",
                latitude: 55.760452,
                longitude: 37.618373
            ),
            Place(
                sort: 3,
                title: "Собор Покрова Пресвятой Богородицы на Рву",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "Красная площадь, 7",
                city: "Москва",
                latitude: 55.760452,
                longitude: 37.618373
            ),
            Place(
                sort: 4,
                title: "Кафедральный собор Храма Христа Спасителя",
                description: "Здание в центре Москвы, в котором располагается Государственный академический Большой театр.",
                image: nil,
                address: "ул. Волхонка 15",
                city: "Москва",
                latitude: 55.760452,
                longitude: 37.618373
            )
        ]

        let e1 = Excursion(
            title: "Интересная Москва",
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            ownerId: 1,
            image: nil,
            rating: nil,
            duration: 60,
            distance: 2.2,
            numberOfPoints: 1,
            ownerRoleValue: "user",
            owner: Owner(id: 1, name: "Имя", email: "email"),
            places: places
        )
        let e2 = Excursion(
            title: "Театры Москвы",
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            ownerId: 1,
            image: nil,
            rating: 4.96,
            duration: 65,
            distance: 3.2,
            numberOfPoints: 2,
            ownerRoleValue: "user",
            owner: Owner(id: 1, name: "Имя", email: "email"),
            places: places
        )
        let e3 = Excursion(
            title: "Парки",
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            ownerId: 1,
            image: nil,
            rating: 3.33,
            duration: 90,
            distance: 4.4,
            numberOfPoints: 3,
            ownerRoleValue: "user",
            owner: Owner(id: 1, name: "Имя", email: "email"),
            places: places
        )
        let e4 = Excursion(
            title: "Пешеходная тропа",
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            ownerId: 1,
            image: nil,
            rating: 3.7,
            duration: 100,
            distance: 4.4,
            numberOfPoints: 5,
            ownerRoleValue: "user",
            owner: Owner(id: 1, name: "Имя", email: "email"),
            places: places
        )
        let e5 = Excursion(
            title: "Обзорная",
            description: "Приглашаем познакомиться с одной из древнейших и красивейших столиц мира. Вы оцените эклектичную архитектуру города, увидите знаменитые улицы",
            ownerId: 1,
            image: nil,
            rating: 4.5,
            duration: 50,
            distance: 1.9,
            numberOfPoints: 6,
            ownerRoleValue: "user",
            owner: Owner(id: 1, name: "Имя", email: "email"),
            places: places
        )

        return [e1, e2, e3, e4, e5]
    }
}
