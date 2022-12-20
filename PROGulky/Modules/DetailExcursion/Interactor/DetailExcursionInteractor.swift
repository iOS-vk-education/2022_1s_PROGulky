//
//  DetailExcursionInteractor.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - DetailExcursionInteractor

final class DetailExcursionInteractor {
    weak var output: DetailExcursionInteractorOutput?
}

// MARK: DetailExcursionInteractorInput

extension DetailExcursionInteractor: DetailExcursionInteractorInput {
    func didLikeButtonTapped(with excursionId: Int, isLiked: Bool) {
        let token = UserProvider.provider.userToken()
        if UserProvider.provider.userIsAuth() {
            if isLiked {
                // Удалить из избранного
                ApiManager.shared.removeFavorites(
                    completion: { result in
                        switch result {
                        case .success:
                            self.output?.userRemoveFromFavoritesExcursions(for: excursionId)
                        case .failure:
                            self.output?.userIsNotAuth() // TODO: Надо сделать вьюху для показа этой ошибки
                        }
                    },
                    token: token!,
                    id: excursionId
                )
            } else {
                // Добавить в избранное
                ApiManager.shared.addFavorites(
                    completion: { result in
                        switch result {
                        case .success:
                            self.output?.userAddToFavoritesExcursions(for: excursionId)
                        case .failure:
                            self.output?.userIsNotAuth() // TODO: Надо сделать вьюху для показа этой ошибки
                        }
                    },
                    token: token!,
                    id: excursionId
                )
            }
        } else {
            output?.userIsNotAuth() // Пользователь не авторизован. Показать ошибку
        }
    }
}
