//
//  DeeplinkType.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//

import Foundation

// MARK: - DeeplinkType

enum DeeplinkType {
    case excursions
    case details(id: String)
    case favourite
    case profile
    case add

    var handler: DeeplinkHandlerProtocol {
        switch self {
        case .excursions, .details, .add:
            return ExcursionsDeeplinkHandler()
        case .favourite:
            return FavouriteDeeplinkHandler()
        case .profile:
            return ProfileDeeplinkHandler()
        }
    }
}
