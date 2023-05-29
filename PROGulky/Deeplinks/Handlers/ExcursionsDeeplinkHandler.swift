//
//  ExcursionsDeeplinkHandler.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//

import UIKit

final class ExcursionsDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var excursionListCoordinator: ExcursionListCoordinator?
    private weak var appCoordinator: AppCoordinator?

    init() {
        appCoordinator = AppCoordinator.shared
        guard let coordinator = appCoordinator?.getCoordinatorForPage(.excursionList) as? ExcursionListCoordinator else {
            return
        }
        excursionListCoordinator = coordinator
    }

    func openDeeplink(_ deeplink: DeeplinkType) -> Bool {
        switch deeplink {
        case .excursions:
            appCoordinator?.selectedPage = .excursionList
            guard let excursionListCoordinator
            else { return false }
            excursionListCoordinator.navigationController.popToRootViewController(animated: true)
            excursionListCoordinator.navigationController.dismiss(animated: true)
        case let .details(id):
            guard let appCoordinator,
                  let excursionListCoordinator,
                  let excursionId = Int(id)
            else { return false }
            appCoordinator.selectedPage = .excursionList
            excursionListCoordinator.excursionsListModuleWantsToOpenDetailModule(excursionId: excursionId)
            return true
        case .add:
            appCoordinator?.selectedPage = .excursionList
            excursionListCoordinator?.excursionsListModuleWantsToOpenAddExcursion()
        default: return false
        }
        return true
    }
}
