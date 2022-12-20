//
//  DetailExcursionViewModel.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 23.11.2022.
//

import Foundation

struct DetailExcursionViewModel {
    var id: Int
    var image: String
    var description: String
    var infoViewModel: DetailExcursionInfoViewModel
    var isLiked: Bool
}
