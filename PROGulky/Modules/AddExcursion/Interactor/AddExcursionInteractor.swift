//
//  AddExcursionInteractor.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - AddExcursionInteractor

final class AddExcursionInteractor {
    weak var output: AddExcursionInteractorOutput?
}

// MARK: AddExcursionInteractorInput

extension AddExcursionInteractor: AddExcursionInteractorInput {
    func sendExcursion(excursion: ExcursionForPost) {
        guard UserAuthService.shared.isLogged else {
            output?.gotAuthError() // Пользователь не авторизован. Показать ошибку
            return
        }

        let token = UserService.shared.userToken

        ApiManager.shared.sendExcursion(excursion: excursion, token: token) { result in
            switch result {
            case let .success(success):
                print(success.title, success.id)
                self.output?.successeded()
            case let .failure(failure):
                self.output?.gotAnotherError()
            }
        }
    }
}
