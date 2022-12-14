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
    func didLoadView() {
        router.embedMapModule(output: self)
        router.embedDetailModule(output: self)
    }

    func didTapBackButton() {
        moduleOutput?.mapDetailModuleWantsToClose()
    }
}

extension MapDetailPresenter: MapDetailInteractorOutput {
}

extension MapDetailPresenter: DetailExcursionModuleOutput {
}

extension MapDetailPresenter: MapModuleOutput {
}
