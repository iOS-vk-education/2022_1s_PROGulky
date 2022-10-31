//
//  DetailPlacePresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - DetailPlacePresenter

final class DetailPlacePresenter {
    // MARK: - Public Properties

    weak var view: DetailPlaceViewInput!

    // MARK: - Private Properties

    private let interactor: DetailPlaceInteractorInput
    private let router: DetailPlaceRouterInput


    //MARK: - Lifecycle

    init(interactor: DetailPlaceInteractorInput, router: DetailPlaceRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPlacePresenter: DetailPlaceModuleInput {
}

extension DetailPlacePresenter: DetailPlaceViewOutput {
}

extension DetailPlacePresenter: DetailPlaceInteractorOutput {
}