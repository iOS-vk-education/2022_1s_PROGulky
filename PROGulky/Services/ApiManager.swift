//
//  ApiManager.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.11.2022.
//

import Foundation

// MARK: - ApiType

enum ApiType {
    case getExcursions(token: String?) // Получить список всех экскурсий
    case addFavorites(token: String, excursionId: String) // Добавление экскурсии в избранное
    case removeFavorites(token: String, excursionId: String) // Удалить экскурсию из избранного
    case login // Логин
    case registration // Регистрация

    var baseURL: String {
        "http://37.140.195.167:5000"
    }

    var headers: [String: String] {
        switch self {
        case let .getExcursions(token):
            if let token = token {
                return ["Authorization": "Bearer \(token)"]
            }
            return ["Authorization": "Bearer "]
        case let .addFavorites(token, _):
            return ["Authorization": "Bearer \(token)"]
        case let .removeFavorites(token, _):
            return ["Authorization": "Bearer \(token)"]
        default:
            return [:]
        }
    }

    var path: String {
        switch self {
        case .getExcursions: return "/excursions"
        case .addFavorites: return "/excursions/add_favorite"
        case .removeFavorites: return "/excursions/delete_favorite"
        case .login: return "/auth/login"
        case .registration: return "/auth/registration"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        switch self {
        case .getExcursions:
            request.httpMethod = "GET"
            return request
        case .addFavorites:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        case .removeFavorites:
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        case .login, .registration:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}

// MARK: - ApiManager

final class ApiManager {
    static let shared = ApiManager()

    func getExcursions(completion: @escaping (Result<Excursions, Error>) -> Void, token: String?) {
        let request = ApiType.getExcursions(token: token).request

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let excursions = try JSONDecoder().decode(Excursions.self, from: data)
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

    func addFavorites(completion: @escaping (Result<Void, Error>) -> Void, token: String, id: Int) {
        let json: [String: Any] = [
            "excursionId": id
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.addFavorites(token: token, excursionId: "\(id)").request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            }

            do {
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }

    func removeFavorites(completion: @escaping (Result<Void, Error>) -> Void, token: String, id: Int) {
        let json: [String: Any] = [
            "excursionId": id
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.removeFavorites(token: token, excursionId: "\(id)").request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            }

            do {
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }

    func login(_ loginDTO: LoginDTO, completion: @escaping (Result<User, Error>) -> Void) {
        let json: [String: Any] = [
            "email": loginDTO.email,
            "password": loginDTO.password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.login.request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            guard let data = data else { return }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }
        task.resume()
    }

    func registration(_ registrtionDTO: RegistrationDTO, completion: @escaping (Result<User, Error>) -> Void) {
        let json: [String: Any] = [
            "name": registrtionDTO.nickname,
            "email": registrtionDTO.email,
            "password": registrtionDTO.password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.registration.request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            guard let data = data else { return }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }
        task.resume()
    }
}
