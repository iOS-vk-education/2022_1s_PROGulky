//
//  AddPlacePresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - AddPlacePresenter

final class AddPlacePresenter {
    // MARK: - Public Properties

    weak var view: AddPlaceViewInput!

    // MARK: - Private Properties

    private let interactor: AddPlaceInteractorInput
    private let router: AddPlaceRouterInput


    //MARK: - Lifecycle

    init(interactor: AddPlaceInteractorInput, router: AddPlaceRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension AddPlacePresenter: AddPlaceModuleInput {
}

extension AddPlacePresenter: AddPlaceViewOutput {
}

extension AddPlacePresenter: AddPlaceInteractorOutput {
}