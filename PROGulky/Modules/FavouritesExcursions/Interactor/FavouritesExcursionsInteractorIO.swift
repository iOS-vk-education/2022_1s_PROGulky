//
//  FavouritesExcursionsInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - FavouritesExcursionsInteractorOutput

protocol FavouritesExcursionsInteractorOutput: AnyObject {
    func gotAuthError()

    func gotEmptyFavoritesList()

    func didLoadFavoritesExcursionsList(favoritesExcursions: PreviewExcursions)

    func gotNetworkError()
}

// MARK: - FavouritesExcursionsInteractorInput

protocol FavouritesExcursionsInteractorInput: AnyObject {
    func loadFavoritesExcursionsList()
}
