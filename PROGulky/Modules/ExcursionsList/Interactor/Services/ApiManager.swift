//
//  ApiManager.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.11.2022.
//

import Foundation

// MARK: - ApiType

enum ApiType {
    case getExcursions

    var baseURL: String {
        "http://37.140.195.167:5000"
    }

    var path: String {
        switch self {
        case .getExcursions: return "/excursions"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)

        switch self {
        case .getExcursions:
            request.httpMethod = "GET"
            return request
        }
    }
}

// MARK: - ApiManager

final class ApiManager {
    static let shared = ApiManager()

    func getExcursions(completion: @escaping (Result<Excursions, Error>) -> Void) {
        let request = ApiType.getExcursions.request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let excursions = try JSONDecoder().decode(Excursions.self, from: data)
                // completion(.success(excursions))
                DispatchQueue.main.async {
                    completion(.success(excursions))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}
