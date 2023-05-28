//
//  ProfileViewConstants.swift
//  PROGulky
//
//  Created by Сергей Киселев on 15.05.2023.
//

import UIKit

struct ProfileViewConstants {
    enum Header {
        static let topOffset: CGFloat = 20
        static let height: CGFloat = 130
        static let cornerRadius: CGFloat = 40
        static let shadowColor: UIColor = UIColor.prog.Dynamic.primary
        static let shadowOpacity: Float = 0.6
    }

    enum TableView {
        static let topOffset: CGFloat = 32
        static let rowHeight: CGFloat = 40
        static let offset: CGFloat = 0
        static let cornerRadius: CGFloat = 16
        static let heightForHeader: CGFloat = 40
        static let height: CGFloat = 490
        static let contentInsetTop: CGFloat = 0
        static let leftAnchor: CGFloat = 16

        enum Cell {
            static let height: CGFloat = 45
        }
    }

    enum Shadow {
        static let shadowRadius: CGFloat = 9 // Радиус тени
        static let shadowOpacity: Float = 0.4 // Прозрачность тени
        static let shadowColor: UIColor = UIColor.prog.Dynamic.shadow
    }

    enum DeleteBtn {
        static let offset: CGFloat = 20
        static let heightBtn: CGFloat = 20
        static let fontSize: CGFloat = 12
    }
}
