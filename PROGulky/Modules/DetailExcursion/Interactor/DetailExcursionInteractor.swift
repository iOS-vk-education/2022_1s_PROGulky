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

        guard let token = token else {
            return
        }

        print(UserDefaultsLoginService.shared.isLogin)

        guard UserProvider.provider.userIsAuth() else {
            output?.gotAuthError() // Пользователь не авторизован. Показать ошибку
            return
        }

        if isLiked {
            output?.userChangeStatusLikeButton(on: false) // Сначала меняем вьюху
            // Удалить из избранного
            ApiManager.shared.removeFavorites(
                completion: { result in
                    switch result {
                    case .success:
                        self.output?.userRemoveFromFavoritesExcursions(for: excursionId)
                    case .failure:
                        self.output?.gotAnotherError()
                    }
                },
                token: token,
                id: excursionId
            )
        } else {
            output?.userChangeStatusLikeButton(on: true) // Сначала меняем вьюху
            // Добавить в избранное
            ApiManager.shared.addFavorites(
                completion: { result in
                    switch result {
                    case .success:
                        self.output?.userAddToFavoritesExcursions(for: excursionId)
                    case .failure:
                        self.output?.gotAnotherError()
                    }
                },
                token: token,
                id: excursionId
            )
        }
    }
}
