//
//  ExcursionsRepository.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.12.2022.
//

import Foundation

final class ExcursionsRepository {
    static let repository = ExcursionsRepository()

    func getExcursionsList(completion: @escaping (Result<Excursions, Error>) -> Void) {
        var token: String?

        if UserProvider.provider.userIsAuth() {
            token = UserProvider.provider.userToken()
        }

        ApiManager.shared.getExcursions(
            completion: { excursions in
                switch excursions {
                case let .success(excursions):
                    DispatchQueue.main.async {
                        completion(.success(excursions))
                    }
                case let .failure(error):
                    completion(.failure(error))
                    print("error:", error)
                }
            },
            token: token
        )
    }
}
