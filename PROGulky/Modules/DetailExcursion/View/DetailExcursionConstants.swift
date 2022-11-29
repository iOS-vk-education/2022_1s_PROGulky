//
//  DetailExcursionConstants.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 18.11.2022.
//

import UIKit

struct DetailExcursionConstants {
    enum Screen {
        static let padding: CGFloat = 12
    }

    enum Image {
        static let marginTop: CGFloat = 10
        static let height: CGFloat = 200
    }

    enum InfoView {
        static let backgroundColor = UIColor.prog.Dynamic.lightBackground
        static let cornerRadius: CGFloat = 16
        static let height: CGFloat = 200

        static let marginLeft: CGFloat = 20
        static let marginRight: CGFloat = -20

        // Конфигурация тени
        static let shadowColor = UIColor.gray.cgColor
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 7

        static let heightInImage: CGFloat = -100 // На сколько эта вью залезает на картинку

        enum Title {
            static let marginTop: CGFloat = 15
            static let font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.semibold)
        }

        enum Rating {
            enum Image {
                static let image = UIImage(systemName: "star.fill")?
                    .withTintColor(.prog.Dynamic.shadow, renderingMode: .alwaysOriginal)
                static let XOffset: CGFloat = -20
                static let marginTop: CGFloat = 7
                static let height: CGFloat = 20
                static let aspectRatio: CGFloat = 1.1
            }

            enum Label {
                static let marginTop: CGFloat = 7
                static let marginLeft: CGFloat = 5
            }
        }

        enum HorizontalLine {
            static let marginLeft: CGFloat = 30
            static let marginRight: CGFloat = -30
            static let marginTop: CGFloat = 10
            static let height: CGFloat = 0.3
            static let color = UIColor.lightGray
        }

        enum ParameterItem {
            static let marginTop: CGFloat = 10
            static let marginLeft: CGFloat = 40
            static let marginRight: CGFloat = -40
            static let width: CGFloat = 49
            static let height: CGFloat = 45
            static let textColor = UIColor.gray
            static let numberOfLines = 2
        }

        enum Button {
            static let marginTop: CGFloat = 10
            static let marginLeft: CGFloat = 12
            static let marginRight: CGFloat = -12
            static let height: CGFloat = 40
            static let cornerRadius: CGFloat = 12
            static let text = "На карте"
            static let color = UIColor.prog.Dynamic.primary
        }
    }

    enum TableView {
        static let marginTop: CGFloat = 10

        enum Sections {
            enum PlacesCells {
                static let title = "Точки экскрусии"
            }

            enum DescriptionCell {
                static let title = "Описание"
            }
        }

        enum HeaderInSection {
            static let marginTop: CGFloat = 20
            static let textColor = UIColor.gray
            static let backgroundColor = UIColor.prog.Dynamic.background
            static let font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.semibold)
        }

        enum PlaceCell {
            static let reuseId = "PlaceCell" // Идентификатор ячейки
            static let height: CGFloat = 60
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

        enum DescriptionCell {
            static let reuseId = "DescriptionCell" // Идентификатор ячейки
            static let backgroundColor = UIColor.prog.Dynamic.lightBackground

            enum Text {
                static let marginTop: CGFloat = 10
                static let font = UIFont.systemFont(ofSize: 17)
                static let numberOfLines = 0
            }
        }
    }
}
