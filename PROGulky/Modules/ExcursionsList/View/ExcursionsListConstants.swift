//
//  Constants.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 11.11.2022.
//

import UIKit

struct ExcursionsListConstants {
    // Константы для всего экрана (падинги, цвет фотна и т. д.)
    enum Screen {
        static let padding: CGFloat = 12
        static let backgroundColor = UIColor.white
    }

    enum ExcursionsListNavBar {
        static let title: String = "Экскурсии" // Название экрана
    }

    enum ExcursionsFilterBar {
        static let height: CGFloat = 45 // Высота бара с фильтрами
    }

    enum SelectedCityButton {
        static let title: String = "Москва"
        static let icon: String = "location.circle"
        static let padding: CGFloat = 6
    }

    enum FilterButton {
        static let title: String = "Фильтр"
        static let icon: String = "slider.horizontal.3"
        static let padding: CGFloat = 6
    }

    enum ExcursionCell {
        static let reuseId = "ExcursionCell" // Идентификатор ячейки

        static let height: CGFloat = 120 // Высота ячейки
        static let contentIndent: CGFloat = 20 // Отступ контента от картинки

        static let imageCornerRadius: CGFloat = 10 // Радиус скургления картинки экскурсии
        static let imageHeight: CGFloat = 92 // Высота картинки
        static let imageAspectRatio: CGFloat = 16 / 9 // Соотношение сторон картинки

        static let titleFontSize: CGFloat = 17 // Размер заголовка
        static let titleFontWeight = UIFont.Weight.semibold // Толщина заголовка
        static let heightTitleFrame: CGFloat = 40 // Высота фрейма в котором размещен заголовок

        static let raitingImageIndentFromTitle: CGFloat = 5 // Отступ картинки от заголовка
        static let ratingImage: String = "star" // Иконка рейтинга
        static let ratingFontSize: CGFloat = 13 // Размер текста рейтинга
        static let ratingFontWeight = UIFont.Weight.medium // Толщина текста рейтинга
        static let ratingTextColor: UIColor = .gray // Цвет текста рейтинга

        static let parametersFontSize: CGFloat = 13 // Размер текста параметров
        static let parametersFontWeight = UIFont.Weight.medium // Толщина текста параметров
        static let parametersTextColor: UIColor = .gray // Цвет текста параметров
    }
}
