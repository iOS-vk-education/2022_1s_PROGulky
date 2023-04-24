//
//  PreviewPPlaceViewModel.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 18.11.2022.
//

import Foundation

// MARK: - PreviewPlaceViewModel

// Данные в ячейки таблицы с местами
struct PreviewPlaceViewModel {
    var sort: Int
    var title: String
    var subtitle: String

    static var empty: PreviewPlaceViewModel {
        .init(sort: -1, title: "", subtitle: "")
    }
}

// MARK: Identifiable

extension PreviewPlaceViewModel: Identifiable {
    var id: Int {
        sort
    }
}
