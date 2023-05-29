//
//  DeeplinkHandlerProtocol.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//

import Foundation

// MARK: - DeeplinkCoordinator

final class DeeplinkCoordinator {
    private func parseURL(_ url: URL) -> DeeplinkType? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let host = components.host else {
            return nil
        }
        var pathComponents = components.path.components(separatedBy: "/")
        pathComponents.removeFirst()
        switch host {
        case "excursions": return .excursions
        case "detailed-excursion":
            if let id = pathComponents.first {
                return .details(id: id)
            } else {
                return nil
            }
        case "favourite": return .favourite
        case "profile": return .profile
        case "add": return .add
        default: return nil
        }
    }

    func handleURL(_ url: URL) -> Bool {
        guard let deeplink = parseURL(url) else {
            return false
        }
        return deeplink.handler.openDeeplink(deeplink)
    }
}
