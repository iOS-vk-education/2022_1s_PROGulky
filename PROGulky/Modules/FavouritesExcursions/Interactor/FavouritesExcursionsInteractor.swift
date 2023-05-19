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
//        let token = UserService.shared.userToken
//
//        guard UserAuthService.shared.isLogged else {
//            output?.gotAuthError() // Пользователь не авторизован. Показать сообщение об этом
//            return
//        }
//
//        ExcursionsRepository.shared.getFavoritesExcursionsList(completion: { excursions in
//            switch excursions {
//            case let .success(excursions):
//                if excursions.isEmpty {
//                    self.output?.gotEmptyFavoritesList()
//                } else {
//                    self.output?.didLoadFavoritesExcursionsList(favoritesExcursions: excursions)
//                }
//            case .failure:
//                self.output?.gotNetworkError()
//            }
//        }, token: token)

        // Избранные экскурсии берутся из CoreData
        let favoritesExcursions = ExcursionsRepository.shared.getFavouritesExcursions()

        if favoritesExcursions.isEmpty {
            output?.gotEmptyFavoritesList()
        } else {
            output?.didLoadFavoritesExcursionsList(favoritesExcursions: favoritesExcursions)
        }
    }
}
