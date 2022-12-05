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

    // MARK: - Lifecycle

    init(interactor: MapDetailInteractorInput,
         router: MapDetailRouterInput,
         output: MapDetailModuleOutput) {
        self.interactor = interactor
        self.router = router
        moduleOutput = output
    }
}

extension MapDetailPresenter: MapDetailModuleInput {
}

// MARK: MapDetailViewOutput

extension MapDetailPresenter: MapDetailViewOutput {
    func viewDidLoad() {
        router.embedDetailModule(output: self)
        router.embedMapModule(output: self)
    }
}

extension MapDetailPresenter: MapDetailInteractorOutput {
}

extension MapDetailPresenter: DetailExcursionModuleOutput {
}

extension MapDetailPresenter: MapModuleOutput {
}
