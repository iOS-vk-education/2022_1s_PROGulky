//
//  TabBarItemFactory.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit

// MARK: - TabBarPage

enum TabBarPage: CaseIterable {
    case excursionList
    case favourite
    case profile

    var image: UIImage? {
        switch self {
        case .excursionList:
            return UIImage(named: "Home")
        case .favourite:
            return UIImage(named: "Likes")
        case .profile:
            return UIImage(named: "Profile")
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .excursionList:
            return UIImage(named: "Home-Active")
        case .favourite:
            return UIImage(named: "Likes-Active")
        case .profile:
            return UIImage(named: "Profile-Active")
        }
    }
}

// MARK: - TabBarItemFactoryProtocol

protocol TabBarItemFactoryProtocol {
    func getTabBarItem(from page: TabBarPage) -> UITabBarItem
}

// MARK: - TabBarItemFactory

final class TabBarItemFactory: TabBarItemFactoryProtocol {
    func getTabBarItem(from page: TabBarPage) -> UITabBarItem {
        UITabBarItem(title: nil, image: page.image, selectedImage: page.selectedImage)
    }
}
