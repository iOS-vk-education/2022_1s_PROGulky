//
//  ProfileSettingsSection.swift
//  PROGulky
//
//  Created by Сергей Киселев on 19.11.2022.
//

import UIKit

// MARK: - SectionType

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
    var image: String { get }
}

// MARK: - SettingsSection

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Account
    case Other

    var description: String {
        switch self {
        case .Account:
            return TextConstants.titleAccount
        case .Other:
            return TextConstants.titleOthers
        }
    }
}

// MARK: - AccountOptions

enum AccountOptions: Int, CaseIterable, SectionType {
    case personalDataSettings
    case achievements
    case history
    case beGuide

    var containsSwitch: Bool {
        false
    }

    var description: String {
        switch self {
        case .personalDataSettings:
            return TextConstants.titlePersonalData
        case .achievements:
            return TextConstants.titleAchievements
        case .history:
            return TextConstants.titleHistory
        case .beGuide:
            return TextConstants.titleBeGuide
        }
    }

    var image: String {
        switch self {
        case .personalDataSettings:
            return "person"
        case .achievements:
            return "character.book.closed"
        case .history:
            return "chart.bar.doc.horizontal"
        case .beGuide:
            return "person.badge.shield.checkmark"
        }
    }
}

// MARK: - OtherOptions

enum OtherOptions: Int, CaseIterable, SectionType {
    case contactUs
    case privacyPolicy
    case signOut

    var containsSwitch: Bool {
        false
    }

    var description: String {
        switch self {
        case .contactUs:
            return TextConstants.titleContactUs
        case .privacyPolicy:
            return TextConstants.titlePrivacyPolicy
        case .signOut:
            return TextConstants.titleSignOut
        }
    }

    var image: String {
        switch self {
        case .contactUs:
            return "square.and.pencil"
        case .privacyPolicy:
            return "checkmark.shield"
        case .signOut:
            return "multiply.circle"
        }
    }
}
