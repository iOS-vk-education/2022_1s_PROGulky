//
//  ApiManagerLogin.swift
//  PROGulky
//
//  Created by Сергей Киселев on 08.12.2022.
//

import Foundation

// MARK: - ApiTypeLogin

enum ApiTypeLogin {
    case login

    var baseURL: String {
        "http://37.140.195.167:5000"
    }

    var path: String {
        switch self {
        case .login: return "/auth/login/"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)

        switch self {
        case .login:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}

// MARK: - ApiManagerLogin

final class ApiManagerLogin {
    static let shared = ApiManagerLogin()

    func getExcursions(completion: @escaping (Result<User, Error>) -> Void) {
        let json: [String: Any] = [
            "email": "sergeyK@mail.ru",
            "password": "password123"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiTypeLogin.login.request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}
