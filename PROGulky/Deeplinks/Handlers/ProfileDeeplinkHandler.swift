//
//  ProfileDeeplinkHandler.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//

import Foundation
import UIKit

final class ProfileDeeplinkHandler: DeeplinkHandlerProtocol {
    weak var profileCoordinator: ProfileCoordinator? {
        AppCoordinator.shared.getCoordinatorForPage(.profile) as? ProfileCoordinator
    }

    func openDeeplink(_ deeplink: DeeplinkType) -> Bool {
        switch deeplink {
        case .profile:
            guard let profileCoordinator,
                  let tabBarController = AppCoordinator.shared.tabBarController,
                  AppCoordinator.shared.tabBarController(tabBarController,
                                                         shouldSelect: profileCoordinator.navigationController)
            else { return false }
            AppCoordinator.shared.selectedPage = .profile
            return true
        default: return false
        }
    }
}
