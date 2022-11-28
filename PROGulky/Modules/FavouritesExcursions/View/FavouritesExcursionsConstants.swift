//
//  FavouritesExcursionsConstants.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 25.11.2022.
//

import UIKit

struct FavouritesExcursionsConstants {
    // Константы для всего экрана (падинги, цвет фотна и т. д.)
    enum Screen {
        static let padding: CGFloat = 12
        static let backgroundColor = UIColor.white
    }

    enum NavBar {
        static let title: String = "Избранное" // Название экрана
    }

    enum MessageView {
        static let text: String = "Список избранного пуст"
        static let font: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
    }
}
