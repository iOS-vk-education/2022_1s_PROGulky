//
//  FavouritesExcursionsPresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - FavouritesExcursionsPresenter

final class FavouritesExcursionsPresenter {
    // MARK: - Public Properties

    weak var view: FavouritesExcursionsViewInput!
    weak var moduleOutput: FavouritesExcursionsModuleOutput?

    // MARK: - Private Properties

    private let interactor: FavouritesExcursionsInteractorInput
    private let router: FavouritesExcursionsRouterInput

    private let factory = ExcursionsListDisplayDataFactory()
    private var favoritesExcursions: [Excursion] = []

    // MARK: - Lifecycle

    init(interactor: FavouritesExcursionsInteractorInput, router: FavouritesExcursionsRouterInput,
         moduleOutput: FavouritesExcursionsModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput
    }
}

// MARK: FavouritesExcursionsModuleInput

extension FavouritesExcursionsPresenter: FavouritesExcursionsModuleInput {
}

// MARK: FavouritesExcursionsViewOutput

extension FavouritesExcursionsPresenter: FavouritesExcursionsViewOutput {
    func didPullResfresh() {
        interactor.loadFavoritesExcursionsList()
    }

    func item(for index: Int) -> ExcursionViewModel {
        factory.getExcursionViewModel(for: favoritesExcursions[index])
    }

    func itemsCount() -> Int {
        favoritesExcursions.count
    }

    func didSelectCell(at indexPath: IndexPath) {
        moduleOutput?.favoritesExcursionsListModuleWantsToOpenMapDetailModule(excursion: favoritesExcursions[indexPath.row])
    }

    func didRepeatButtonTapped() {
        interactor.loadFavoritesExcursionsList()
    }

    func didLoadView() {
        interactor.loadFavoritesExcursionsList()
        view.startLoader() // Запуск анимации лоадера
    }
}

// MARK: FavouritesExcursionsInteractorOutput

extension FavouritesExcursionsPresenter: FavouritesExcursionsInteractorOutput {
    func gotEmptyFavoritesList() {
        favoritesExcursions = []
        view.stopLoader()
        view.reloadView()
        view.showEmptyListView()
    }

    func didLoadFavoritesExcursionsList(favoritesExcursions: Excursions) {
        self.favoritesExcursions = favoritesExcursions
        view.stopLoader()
        view.reloadView()
        view.hideEmptyListView()
    }

    func gotNetworkError() {
        // TODO: метод не работает :(
        view.showErrorView()
    }

    func gotAuthError() {
        view.stopLoader()
        view.showNotAuthView()
    }
}
