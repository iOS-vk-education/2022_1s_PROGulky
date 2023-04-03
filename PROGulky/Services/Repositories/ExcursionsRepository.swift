//
//  ExcursionsRepository.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.12.2022.
//

import Foundation

// MARK: - ExcursionsRepositoryConstants

struct ExcursionsRepositoryConstants {
    enum Search {
        static let delay: Float = 1.0
        static let queryParameterKey = "q"
    }
}

// MARK: - ExcursionsRepository

final class ExcursionsRepository {
    static let shared = ExcursionsRepository()

    // Получение (запрос) экскурсий из API. Аргументы: 1 - "text" - название экскусрии (для поиска по ILIKE по title), 2 - "params" - параметры фильтра
    func getExcursionsList(completion: @escaping (Result<PreviewExcursions, Error>) -> Void, with text: String?, filterParameters: [String: String]?) {
        var resParameters: [URLQueryItem] = []

        // Если в text не nil, то формирую массив [URLQueryItem]
        if let text = text {
            let searchQuery = [ExcursionsRepositoryConstants.Search.queryParameterKey: text]
            let params = [searchQuery]

            params.forEach { e in
                guard let key = e.keys.first, let value = e.values.first else { return }
                resParameters.append(URLQueryItem(
                    name: key,
                    value: value
                )
                )
            }
        }

        // Если в params не nil, то формирую массив [URLQueryItem]
        if let filterParameters = filterParameters {
            filterParameters.forEach { e in
                resParameters.append(URLQueryItem(
                    name: e.key,
                    value: e.value
                )
                )
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
