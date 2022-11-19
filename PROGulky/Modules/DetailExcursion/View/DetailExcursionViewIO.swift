//
//  DetailExcursionViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - DetailExcursionViewOutput

protocol DetailExcursionViewOutput: AnyObject {
    func didLoadView()

    func place(for indexPath: IndexPath) -> PlaceViewModel

    var placesCount: Int { get }

    var description: String { get }

    var image: String { get }

    var detailExcursionInfoViewModel: DetailExcursionInfoViewModel { get }
}

// MARK: - DetailExcursionViewInput

protocol DetailExcursionViewInput: AnyObject {
}
