//
//  ExcursionsRepository.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.12.2022.
//

import Foundation

final class ExcursionsRepository {
    static let shared = ExcursionsRepository()

    func getExcursionsList(completion: @escaping (Result<Excursions, Error>) -> Void) {
        var token: String?

        if UserAuthService.shared.isLogged {
            token = UserService.shared.getUserToken()
        }

        ApiManager.shared.getExcursions(
            completion: { excursions in
                switch excursions {
                case let .success(excursions):
                    DispatchQueue.main.async {
                        completion(.success(excursions))
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            },
            token: token
        )
    }

    func getFavoritesExcursionsList(completion: @escaping (Result<Excursions, Error>) -> Void, token: String) {
        ApiManager.shared.getFavoritesExcursions(
            completion: { excursions in
                switch excursions {
                case let .success(excursions):
                    DispatchQueue.main.async {
                        completion(.success(excursions))
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            },
            token: token
        )
    }
}
