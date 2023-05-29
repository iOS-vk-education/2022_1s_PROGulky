//
//  ExcursionsDeeplinkHandler.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//

import UIKit

final class ExcursionsDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var excursionListCoordinator: ExcursionListCoordinator?

    init() {
        guard let coordinator = AppCoordinator.shared
            .getCoordinatorForPage(.excursionList) as? ExcursionListCoordinator else {
            return
        }
        excursionListCoordinator = coordinator
    }

    func openDeeplink(_ deeplink: DeeplinkType) -> Bool {
        switch deeplink {
        case .excursions:
            AppCoordinator.shared.selectedPage = .excursionList
            excursionListCoordinator?.restart()
        case let .details(id):
            guard let excursionsCoordinator = AppCoordinator.shared.getCoordinatorForPage(.excursionList) as? ExcursionListCoordinator,
                  AppCoordinator.shared.tabBarController(
                      AppCoordinator.shared.tabBarController ?? UITabBarController(),
                      shouldSelect: excursionsCoordinator.navigationController
                  )
            else { return false }
            AppCoordinator.shared.selectedPage = .excursionList
            excursionListCoordinator?.excursionsListModuleWantsToOpenDetailModule(excursionId: Int(id) ?? 0)
            return true
        case .add:
            AppCoordinator.shared.selectedPage = .excursionList
            excursionListCoordinator?.excursionsListModuleWantsToOpenAddExcursion()
        default: return false
        }
        return true
    }
}
