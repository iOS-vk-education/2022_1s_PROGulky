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
    let excursion: Excursion

    // MARK: - Private Properties

    private let interactor: DetailExcursionInteractorInput
    private let router: DetailExcursionRouterInput
    private let factory = DetailExcursionDisplayDataFactory()
    private var places: [Place] = []

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
    func didLoadView() {
        places = factory.getPlaces(for: excursion)
    }

    func place(for indexPath: IndexPath) -> PlaceViewModel {
        factory.getPlaceViewModel(for: places[indexPath.row])
    }

    var placesCount: Int {
        places.count
    }

    var detailExcursionInfoViewModel: DetailExcursionInfoViewModel {
        factory.getDetailExcursionInfoViewModel(for: excursion)
    }

    var image: String {
        excursion.image ?? "picture"
    }

    var description: String {
        excursion.description
    }
}

extension DetailExcursionPresenter: DetailExcursionInteractorOutput {
}
