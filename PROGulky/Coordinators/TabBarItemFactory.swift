//
//  TabBarItemFactory.swift
//  PROGulky
//
//  Created by Иван Тазенков on 02.11.2022.
//

import Foundation
import UIKit

// MARK: - TabBarPage

enum TabBarPage: Int, CaseIterable {
    case excursionList
    case favourite
    case profile

    var image: UIImage? {
        switch self {
        case .excursionList:
            return UIImage(systemName: "house")
        case .favourite:
            return UIImage(systemName: "heart")
        case .profile:
            return UIImage(systemName: "person")
        }
    }

    // TODO: PROG-17 - добавить выделение цветом
    var selectedImage: UIImage? {
        switch self {
        case .excursionList:
            return UIImage(systemName: "house")
        case .favourite:
            return UIImage(systemName: "heart")
        case .profile:
            return UIImage(systemName: "person")
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
        let item = UITabBarItem(title: nil, image: page.image, selectedImage: page.selectedImage)
        item.tag = page.rawValue
        return item
    }
}
