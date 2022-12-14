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
    private let viewModel: DetailExcursionViewModel
    private weak var moduleOutput: DetailExcursionModuleOutput?

    // MARK: - Lifecycle

    init(interactor: DetailExcursionInteractorInput,
         router: DetailExcursionRouterInput,
         excursion: Excursion,
         moduleOutput: DetailExcursionModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.excursion = excursion
        self.moduleOutput = moduleOutput
        viewModel = factory.setupViewModel(excursion: excursion)
    }
}

extension DetailExcursionPresenter: DetailExcursionModuleInput {
}

// MARK: DetailExcursionViewOutput

extension DetailExcursionPresenter: DetailExcursionViewOutput {
    func didLoadView() {
        view.configure(viewModel: viewModel)
    }

    func place(for indexPath: IndexPath) -> PlaceViewModel {
        factory.getPlaceViewModel(for: excursion.places[indexPath.row])
    }

    var placesCount: Int {
        excursion.places.count
    }

    var description: String {
        excursion.description
    }
}

extension DetailExcursionPresenter: DetailExcursionInteractorOutput {
}
