//
//  DetailExcursionInfoViewModel.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.11.2022.
//

import Foundation

// MARK: - DetailExcursionInfoViewModel

// Даныне отображаемые в блоке с главной информацией экскрусии (блок с кнопкой в середине экрана)
struct DetailExcursionInfoModel {
    var title: String
    var rating: String
    var numberOfPlaces: String
    var duration: String
    var distance: String

    static var empty: DetailExcursionInfoModel {
        .init(title: "", rating: "", numberOfPlaces: "", duration: "", distance: "")
    }
}
