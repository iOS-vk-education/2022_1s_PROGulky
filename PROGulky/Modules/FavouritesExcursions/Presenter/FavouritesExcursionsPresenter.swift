//
//  FavouritesExcursionsPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - FavouritesExcursionsPresenter

final class FavouritesExcursionsPresenter {
    // MARK: - Public Properties

    weak var view: FavouritesExcursionsViewInput!

    // MARK: - Private Properties

    private let interactor: FavouritesExcursionsInteractorInput
    private let router: FavouritesExcursionsRouterInput

    // MARK: - Lifecycle

    init(interactor: FavouritesExcursionsInteractorInput, router: FavouritesExcursionsRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavouritesExcursionsPresenter: FavouritesExcursionsModuleInput {
}

extension FavouritesExcursionsPresenter: FavouritesExcursionsViewOutput {
}

extension FavouritesExcursionsPresenter: FavouritesExcursionsInteractorOutput {
}
