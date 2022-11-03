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

    // MARK: - Lifecycle

    init(interactor: AddExcursionInteractorInput, router: AddExcursionRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension AddExcursionPresenter: AddExcursionModuleInput {
}

extension AddExcursionPresenter: AddExcursionViewOutput {
}

extension AddExcursionPresenter: AddExcursionInteractorOutput {
}
