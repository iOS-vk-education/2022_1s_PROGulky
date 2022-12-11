//
//  AddExcursionPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - AddExcursionPresenter

final class AddExcursionPresenter {
    // MARK: - Public Properties

    weak var view: AddExcursionViewInput!

    // MARK: - Private Properties

    private let interactor: AddExcursionInteractorInput
    private let router: AddExcursionRouterInput

    private let selectedPlaces: [Place] = []

    // MARK: - Lifecycle

    init(interactor: AddExcursionInteractorInput, router: AddExcursionRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension AddExcursionPresenter: AddExcursionModuleInput {
}

// MARK: AddExcursionViewOutput

extension AddExcursionPresenter: AddExcursionViewOutput {
    func selectedPlacesCount() -> Int {
        selectedPlaces.count
    }
}

extension AddExcursionPresenter: AddExcursionInteractorOutput {
}
