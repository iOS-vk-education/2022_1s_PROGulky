//
//  DetailExcursionSettingsSection.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 23.11.2022.
//

import Foundation

enum DetailExcursionSettingsSections: Int, CaseIterable {
    case Places
    case Description

    var description: String {
        switch self {
        case .Places:
            return DetailExcursionConstants.TableView.Sections.PlacesCells.title
        case .Description:
            return DetailExcursionConstants.TableView.Sections.DescriptionCell.title
        }
    }

    enum DescriptionOptions: CaseIterable {
        case DescriptionText
    }
}
