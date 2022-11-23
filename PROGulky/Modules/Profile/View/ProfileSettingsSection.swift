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
            return TextConstantsProfile.titleAccount
        case .Other:
            return TextConstantsProfile.titleOthers
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
            return TextConstantsProfile.titlePersonalData
        case .achievements:
            return TextConstantsProfile.titleAchievements
        case .history:
            return TextConstantsProfile.titleHistory
        case .beGuide:
            return TextConstantsProfile.titleBeGuide
        }
    }

    var image: String {
        switch self {
        case .personalDataSettings:
            return ImagesProfile.personalDataSettingsImage
        case .achievements:
            return ImagesProfile.achievementsImage
        case .history:
            return ImagesProfile.historyImage
        case .beGuide:
            return ImagesProfile.beGuideImage
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
            return TextConstantsProfile.titleContactUs
        case .privacyPolicy:
            return TextConstantsProfile.titlePrivacyPolicy
        case .signOut:
            return TextConstantsProfile.titleSignOut
        }
    }

    var image: String {
        switch self {
        case .contactUs:
            return ImagesProfile.contactUsImage
        case .privacyPolicy:
            return ImagesProfile.privacyPolicyImage
        case .signOut:
            return ImagesProfile.signOutImage
        }
    }
}
