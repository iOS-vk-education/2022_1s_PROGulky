//
//  FavouritesExcursionsInteractor.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - FavouritesExcursionsInteractor

final class FavouritesExcursionsInteractor {
    weak var output: FavouritesExcursionsInteractorOutput?
}

// MARK: FavouritesExcursionsInteractorInput

extension FavouritesExcursionsInteractor: FavouritesExcursionsInteractorInput {
    func loadFavoritesExcursionsList() {
        // Избранные экскурсии берутся из CoreData
        let favoritesExcursions = ExcursionsRepository.shared.getFavouritesExcursions()

        if favoritesExcursions.isEmpty {
            output?.gotEmptyFavoritesList()
        } else {
            output?.didLoadFavoritesExcursionsList(favoritesExcursions: favoritesExcursions)
        }
    }
}
