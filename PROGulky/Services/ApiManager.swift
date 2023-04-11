//
//  ApiManager.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.11.2022.
//

import Foundation

// MARK: - ApiType

enum ApiType {
    case getExcursions(params: [URLQueryItem]) // Получить список всех экскурсий
    case addFavorites(token: String, excursionId: String) // Добавление экскурсии в избранное
    case removeFavorites(token: String, excursionId: String) // Удалить экскурсию из избранного
    case getFavoritesExcursions(token: String) // Избранные по токену для пользователя
    case getPlaces
    case postExcursion(token: String, excursion: ExcursionForPost)

    case login // Логин
    case getMeInfo(token: String) // получение информации о себе
    case registration // Регистрация
    case updateAccessTokenByRefresh

    var baseURLString: String {
        "http://37.140.195.167:5000"
    }

    var headers: [String: String] {
        switch self {
        case let .addFavorites(token, _):
            return ["Authorization": "Bearer \(token)"]
        case let .removeFavorites(token, _):
            return ["Authorization": "Bearer \(token)"]
        case let .getFavoritesExcursions(token):
            return ["Authorization": "Bearer \(token)"]
        case let .postExcursion(token, _):
            return ["Authorization": "Bearer \(token)"]
        case let .getMeInfo(token):
            return ["Authorization": "Bearer \(token)"]
        default:
            return [:]
        }
    }

    var path: String {
        switch self {
        case .getExcursions: return "api/v1/excursions"
        case .postExcursion: return "api/v1/excursions"
        case .addFavorites: return "api/v1/excursions/add_favorite"
        case .removeFavorites: return "api/v1/excursions/delete_favorite"
        case .getFavoritesExcursions: return "api/v1/excursions/favorites_excursions"
        case .getPlaces: return "api/v1/places"

        case .login: return "api/v1/auth/login"
        case .registration: return "api/v1/auth/registration"
        case .getMeInfo: return "api/v1/auth/me"
        case .updateAccessTokenByRefresh: return "api/v1/auth/token/refresh"
        }
    }

    var requestURL: URLRequest {
        guard let baseURL = URL(string: baseURLString) else {
            assertionFailure("Something has gone wrong and URL could not be constructed!")
            return URLRequest(url: URL(string: "")!)
        }

        let requestURL = baseURL.appendingPathComponent(path)
        switch self {
        case let .getExcursions(params):
            var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = params

            guard let url = urlComponents?.url else {
                assertionFailure("Something has gone wrong and URL could not be constructed!")
                return URLRequest(url: URL(string: "")!)
            }
            return URLRequest(url: url)
        default: return URLRequest(url: requestURL)
        }
    }

    var request: URLRequest {
        var request = requestURL
        request.allHTTPHeaderFields = headers

        switch self {
        case .getExcursions, .getPlaces:
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
        case .getFavoritesExcursions:
            request.httpMethod = "GET"
            return request
        case .postExcursion:
            request.httpMethod = "POST"
            return request
        case .getMeInfo:
            request.httpMethod = "GET"
            return request
        case .updateAccessTokenByRefresh:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}

// MARK: - ApiManager

final class ApiManager {
    static let shared = ApiManager()

    func getExcursions(completion: @escaping (Result<PreviewExcursions, Error>) -> Void, params: [URLQueryItem]) {
        let request = ApiType.getExcursions(params: params).request

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let excursions = try JSONDecoder().decode(PreviewExcursions.self, from: data)
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

    func getFavoritesExcursions(completion: @escaping (Result<PreviewExcursions, Error>) -> Void, token: String) {
        let request = ApiType.getFavoritesExcursions(token: token).request

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let excursions = try JSONDecoder().decode(PreviewExcursions.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(excursions))
                }
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }

    func login(_ loginDTO: LoginDTO, completion: @escaping (Result<Auth, Error>) -> Void) {
        let json: [String: Any] = [
            "email": loginDTO.email,
            "password": loginDTO.password,
            "deviceFingerprint": "iOS"
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
            print(data)
            do {
                let token = try JSONDecoder().decode(Auth.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(token))
                }
                print("accessToken", token.accessToken)
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }
        task.resume()
    }

    func getMeInfo(completion: @escaping (Result<User, NSError>) -> Void, token: String) {
        let request = ApiType.getMeInfo(token: token).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    let error = NSError(domain: "Непредвиденная ошибка", code: 0)
                    completion(.failure(error))
                }
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }

            if statusCode != 401 {
                guard let data = data else { return }

                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                } catch let jsonError {
                    print("Failed decode error:", jsonError)
                    DispatchQueue.main.async {
                        let error = NSError(domain: jsonError.localizedDescription, code: 0)
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "Протух ацесс", code: 401)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    func registration(_ registrtionDTO: RegistrationDTO, completion: @escaping (Result<User, Error>) -> Void) {
        let json: [String: Any] = [
            "name": registrtionDTO.nickname,
            "email": registrtionDTO.email,
            "password": registrtionDTO.password,
            "deviceFingerprint": "iOS"
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

    func updateAccessTokenByRefresh(completion: @escaping (Result<Auth, NSError>) -> Void, refreshToken: String) {
        let json: [String: String] = [
            "deviceFingerprint": "iOS",
            "refreshToken": refreshToken
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.updateAccessTokenByRefresh.request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    let error = NSError(domain: error.localizedDescription, code: 0)
                    completion(.failure(error))
                }
            }

            guard let data = data else { return }

            do {
                let authData = try JSONDecoder().decode(Auth.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(authData))
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
                DispatchQueue.main.async {
                    let jsonError = NSError(domain: jsonError.localizedDescription, code: 0)
                    completion(.failure(jsonError))
                }
            }
        }
        task.resume()
    }

    func getPlaces(completion: @escaping (Result<[Place], Error>) -> Void) {
        let request = ApiType.getPlaces.request

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            guard let data = data else { return }
            do {
                let places = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(places))
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

    func sendExcursion(excursion: ExcursionForPost, token: String, completion: @escaping (Result<ExcursionAfterPost, Error>) -> Void) {
        var request = ApiType.postExcursion(token: token, excursion: excursion).request

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(excursion.title)".data(using: .utf8)!)

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(excursion.description)".data(using: .utf8)!)

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(excursion.image.hashValue)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: file\r\n\r\n".data(using: .utf8)!)
        data.append(excursion.image.jpegData(compressionQuality: 1) ?? Data())

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"duration\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(excursion.duration)".data(using: .utf8)!)

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"distance\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(excursion.distance)".data(using: .utf8)!)

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"placesIds\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(excursion.placesIds)".data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            if let response = response {
                print(response.description)
            }
            guard let data = data else { return }
            do {
                let places = try JSONDecoder().decode(ExcursionAfterPost.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(places))
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
