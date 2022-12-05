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
        static let paddingTop: CGFloat = 0
        static let paddingBottom: CGFloat = 0
        static let backgroundColor = UIColor.prog.Dynamic.background
    }

    enum NavBar {
        static let title: String = "Экскурсии" // Название экрана
        static let backgroundColor = UIColor.prog.Dynamic.lightBackground
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

        static let height: CGFloat = 130 // Высота ячейки
        static let contentIndent: CGFloat = 20 // Отступ контента от картинки
        static let cornerRadius: CGFloat = 12 // Скругление у ячейки

        enum ContentView {
            static let marginTop: CGFloat = 5
            static let marginBottom: CGFloat = 5
            static let marginLeft: CGFloat = 0
            static let marginRight: CGFloat = 0
        }

        enum Image {
            static let cornerRadius: CGFloat = 10 // Радиус скургления картинки экскурсии
            static let height: CGFloat = 92 // Высота картинки
            static let aspectRatio: CGFloat = 16 / 9 // Соотношение сторон картинки
        }

        enum Title {
            static let fontSize: CGFloat = 17 // Размер заголовка
            static let fontWeight = UIFont.Weight.semibold // Толщина заголовка
            static let heightFrame: CGFloat = 40 // Высота фрейма в котором размещен заголовок
        }

        enum RatingImage {
            static let marginTop: CGFloat = 5 // Отступ от заголовка
            static let name: String = "star.fill" // Иконка рейтинга
            static let height: CGFloat = 15
            static let aspectRatio: CGFloat = 1.1 // отношение высоты к ширине
        }

        enum RatingLabel {
            static let marginTop: CGFloat = 5 // Отступ от заголовка
            static let marginLeft: CGFloat = 3
            static let fontSize: CGFloat = 13 // Размер текста рейтинга
            static let fontWeight = UIFont.Weight.medium // Толщина текста рейтинга
            static let textColor: UIColor = .gray // Цвет текста рейтинга
        }

        enum Parameters {
            static let marginTop: CGFloat = 5
            static let fontSize: CGFloat = 13 // Размер текста параметров
            static let fontWeight = UIFont.Weight.medium // Толщина текста параметров
            static let textColor: UIColor = .gray // Цвет текста параметров
        }
    }

    enum Api {
        static let baseURL: String = "http://37.140.195.167:5000"
        static let imageURL: String = "\(baseURL)/images/excursions"
    }
}
