//
//  FavouriteDeeplinkHandler.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//

import UIKit
final class FavouriteDeeplinkHandler: DeeplinkHandlerProtocol {
    weak var favouriteCoordinator = AppCoordinator.shared.getCoordinatorForPage(.favourite) as? FavouriteCoordinator

    func openDeeplink(_ deeplink: DeeplinkType) -> Bool {
        switch deeplink {
        case .favourite:
            guard let favouriteCoordinator,
                  AppCoordinator.shared.tabBarController(
                      AppCoordinator.shared.tabBarController ?? UITabBarController(),
                      shouldSelect: favouriteCoordinator.navigationController
                  )
            else { return false }
            AppCoordinator.shared.selectedPage = .favourite
            return true
        default: return false
        }
    }
}
