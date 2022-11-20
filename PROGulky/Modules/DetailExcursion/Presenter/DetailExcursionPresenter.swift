//
//  DetailExcursionPresenter.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 31/10/2022.
//

import Foundation

// MARK: - DetailExcursionPresenter

final class DetailExcursionPresenter {
    // MARK: - Public Properties

    weak var view: DetailExcursionViewInput!

    // MARK: - Private Properties

    private let interactor: DetailExcursionInteractorInput
    private let router: DetailExcursionRouterInput
    private let factory = DetailExcursionDisplayDataFactory()
    private let excursion: Excursion

    // MARK: - Lifecycle

    init(interactor: DetailExcursionInteractorInput, router: DetailExcursionRouterInput, excursion: Excursion) {
        self.interactor = interactor
        self.router = router
        self.excursion = excursion
    }
}

extension DetailExcursionPresenter: DetailExcursionModuleInput {
}

// MARK: DetailExcursionViewOutput

extension DetailExcursionPresenter: DetailExcursionViewOutput {
    func place(for indexPath: IndexPath) -> PlaceViewModel {
        factory.getPlaceViewModel(for: excursion.places[indexPath.row])
    }

    var placesCount: Int {
        excursion.places.count
    }

    var detailExcursionInfoViewModel: DetailExcursionInfoViewModel {
        factory.getDetailExcursionInfoViewModel(for: excursion)
    }

    var detailExcursionViewModel: DetailExcursionViewModel {
        factory.getDetailExcursionViewModel(for: excursion)
    }
}

extension DetailExcursionPresenter: DetailExcursionInteractorOutput {
}
