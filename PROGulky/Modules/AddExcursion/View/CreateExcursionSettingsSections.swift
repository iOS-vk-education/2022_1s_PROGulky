//
//  CreateExcursionSettingsSections.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 09.12.2022.
//

import Foundation

enum CreateExcursionSettingsSections: Int, CaseIterable {
    case SelectedPlaces
    case AddButton

    var description: String {
        switch self {
        case .SelectedPlaces:
            return DetailExcursionConstants.TableView.Sections.PlacesCells.title
        case .AddButton:
            return DetailExcursionConstants.TableView.Sections.DescriptionCell.title
        }
    }
}
