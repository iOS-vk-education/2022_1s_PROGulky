//
//  CreateExcursionConstants.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 09.12.2022.
//

import UIKit

struct AddExcursionConstants {
    enum Screen {
        static let padding: CGFloat = 12
    }

    enum NavBar {
        static let title: String = "Создать экскурсию"
        static let backgroundColor: UIColor = .prog.Dynamic.lightBackground
        static let rightBarButtonItemText: String = "Сохранить"
    }

    enum Image {
        static let marginTop: CGFloat = 10
        static let height: CGFloat = 100
        static let width: CGFloat = 120
        static let placeholderName = "photo"
    }

    enum TitleField {
        static let marginTop: CGFloat = 20
        static let placeholder: String = "Название"
        static let cornerRadius: Double = 12.0
        static let height: CGFloat = 50
    }

    enum DescriptionField {
        static let marginTop: CGFloat = 10
        static let textColor: UIColor = .gray
        static let cornerRadius: Double = 12.0
        static let minHeight: CGFloat = 60
        static let placeholder = "Описание"
    }

    enum TableView {
        static let marginTop: CGFloat = 10

        enum SelectedPlaceCell {
            static let reuseId = "selectedPlacesCell"
            static let backgroundColor = UIColor.prog.Dynamic.lightBackground

            enum Sort {
                static let marginLeft: CGFloat = 20
                static let width: CGFloat = 20
            }

            enum Title {
                static let marginLeft: CGFloat = 10
                static let font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
                static let YOffset: CGFloat = -10
                static let numberOfLines = 1
            }

            enum Subtitle {
                static let marginLeft: CGFloat = 10
                static let marginTop: CGFloat = 3
                static let font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
                static let textColor = UIColor.gray
                static let numberOfLines = 1
            }
        }

        enum AddPlaceButtonCell {
            static let reuseId = "addButtonCell"
            static let backgroundColor = UIColor.prog.Dynamic.lightBackground

            enum Image {
                static let marginLeft: CGFloat = 12
                static let width: CGFloat = 30
            }

            enum Title {
                static let text: String = "Выбрать места"
                static let font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
            }
        }
    }
}
