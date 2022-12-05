//
//  MapDetailPresenter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

// MARK: - MapDetailPresenter

final class MapDetailPresenter {
    // MARK: - Public Properties

    weak var view: MapDetailViewInput!

    // MARK: - Private Properties

    private let interactor: MapDetailInteractorInput
    private let router: MapDetailRouterInput
    private weak var moduleOutput: MapDetailModuleOutput?
    private let detailExcursionDisplayDataFactory = DetailExcursionDisplayDataFactory()
    private let excursion: Excursion

    // MARK: - Lifecycle

    init(interactor: MapDetailInteractorInput,
         router: MapDetailRouterInput,
         output: MapDetailModuleOutput,
         excursion: Excursion) {
        self.interactor = interactor
        self.router = router
        moduleOutput = output
        self.excursion = excursion
    }
}

extension MapDetailPresenter: MapDetailModuleInput {
}

// MARK: MapDetailViewOutput

extension MapDetailPresenter: MapDetailViewOutput {
    var viewModel: DetailExcursionInfoViewModel {
        detailExcursionDisplayDataFactory
            .setupViewModel(excursion: excursion)
            .infoViewModel
    }

    func viewDidLoad() {
        router.embedDetailModule(output: self)
        router.embedMapModule(output: self)
    }

    func backButtonTapped() {
        moduleOutput?.mapDetailModuleWantsToClose()
    }
}

extension MapDetailPresenter: MapDetailInteractorOutput {
}

extension MapDetailPresenter: DetailExcursionModuleOutput {
}

extension MapDetailPresenter: MapModuleOutput {
}
