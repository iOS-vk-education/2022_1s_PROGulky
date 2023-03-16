//
//  ExcursionsRepository.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.12.2022.
//

import Foundation

final class ExcursionsRepository {
    static let shared = ExcursionsRepository()

    func getExcursionsList(completion: @escaping (Result<PreviewExcursions, Error>) -> Void, params: [[String: String]]?) {
        var resParameters: [URLQueryItem] = []

        if params != nil {
            params?.forEach { e in
                if let key = e.keys.first {
                    if let value = e.values.first {
                        resParameters.append(URLQueryItem(name: key, value: value))
                    }
                }
            }
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
            params: resParameters
        )
    }

    func getFavoritesExcursionsList(completion: @escaping (Result<PreviewExcursions, Error>) -> Void, token: String) {
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
