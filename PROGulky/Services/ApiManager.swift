//
//  ApiManager.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 30.11.2022.
//

import Foundation
import Combine

// MARK: - ApiType

enum ApiType {
    case getExcursions(params: [URLQueryItem]) // Получить список всех экскурсий
    case addFavorites(token: String, excursionId: String) // Добавление экскурсии в избранное
    case removeFavorites(token: String, excursionId: String) // Удалить экскурсию из избранного
    case getFavoritesExcursions(token: String) // Избранные по токену для пользователя
    case getPlaces
    case postExcursion(token: String, excursion: ExcursionForPost)
    case getExcursion(token: String, excursionId: Int)
    case getPlaceImage(image: String)
    case getExcursionImage(image: String)
    case rateExcursion(token: String, excursionId: Int)

    case login // Логин
    case getMeInfo(token: String) // получение информации о себе
    case registration // Регистрация
    case updateAccessTokenByRefresh
    case delete(token: String)

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
        case let .getExcursion(token, _):
            return ["Authorization": "Bearer \(token)"]
        case let .getMeInfo(token):
            return ["Authorization": "Bearer \(token)"]
        case let .delete(token):
            return ["Authorization": "Bearer \(token)"]
        case let .rateExcursion(token, _):
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
        case let .getExcursion(_, excursionId): return "api/v1/excursions/\(excursionId)"
        case let .getPlaceImage(image): return "images/places/\(image)"
        case let .getExcursionImage(image): return "/images/excursions/\(image)"
        case .rateExcursion: return "api/v1/rating"
        case .login: return "api/v1/auth/login"
        case .registration: return "api/v1/auth/registration"
        case .getMeInfo: return "api/v1/auth/me"
        case .updateAccessTokenByRefresh: return "api/v1/auth/token/refresh"
        case .delete: return "api/v1/auth/delete"
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
        case .getExcursions, .getPlaces, .getExcursion, .getPlaceImage, .getExcursionImage:
            request.httpMethod = "GET"
            return request
        case .addFavorites, .login, .registration, .updateAccessTokenByRefresh, .rateExcursion:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        case .removeFavorites:
            request.httpMethod = "DELETE"
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
        case .delete:
            request.httpMethod = "DELETE"
            return request
        }
    }
}

// MARK: - ApiManager

final class ApiManager: BaseService {
    static let shared = ApiManager()

    func getExcursions(completion: @escaping (Result<PreviewExcursions, Error>) -> Void, params: [URLQueryItem]) {
        let request = ApiType.getExcursions(params: params).request

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                completion(.failure(error))
            }
            guard let data else { return }
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
            if let error {
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
            if let error {
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
            if let error {
                completion(.failure(error))
            }
            guard let data else { return }
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

    func login(_ loginDTO: LoginDTO, completion: @escaping (Result<AuthData, ApiCustomError>) -> Void) {
        let json: [String: Any] = [
            "email": loginDTO.email,
            "password": loginDTO.password,
            "deviceFingerprint": "iOS"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.login.request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(ApiCustomError.anotherError))
                }
            }
            guard let data = data else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }

            if statusCode == 201 {
                do {
                    let authData = try JSONDecoder().decode(AuthData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(authData))
                    }
                } catch _ {
                    DispatchQueue.main.async {
                        completion(.failure(ApiCustomError.JSONParseError))
                    }
                }
            } else if statusCode == 400 {
                completion(.failure(ApiCustomError.badСredentials))
            } else {
                completion(.failure(ApiCustomError.anotherError))
            }
        }
        task.resume()
    }

    // Пример метода, который требует наличие access-токена для запроса,
    // и в случае, если токен не валиден (истек), пытается его обновить,
    // сделать запрос заново и вернуть валидный объект.
    // Если же обновление токенов невозможно (истек рефреш) кидает ошибку RefreshIsExpired
    func getMeInfo2(
        success: @escaping ((_ user: User) -> Void),
        failure: @escaping ((_ error: ApiCustomError?) -> Void)
    ) {
        let request = ApiType.getMeInfo(token: getAccessToken()).request
        callWebService(request) { data in
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    success(user)
                }
            } catch let jsonError {
                print("Failed decode error:", jsonError)
            }
        }
        failure: { error in
            failure(error)
        }
    }

    func getMeInfo(completion: @escaping (Result<User, ApiCustomError>) -> Void, token: String) {
        let request = ApiType.getMeInfo(token: token).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(ApiCustomError.anotherError))
                }
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }

            if statusCode != 401 {
                guard let data else { return }

                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                } catch let jsonError {
                    DispatchQueue.main.async {
                        let error = NSError(domain: jsonError.localizedDescription, code: 0)
                        completion(.failure(ApiCustomError.JSONParseError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ApiCustomError.accessIsExpired))
                }
            }
        }
        task.resume()
    }

    func registration(_ registrtionDTO: RegistrationDTO, completion: @escaping (Result<AuthData, ApiCustomError>) -> Void) {
        let json: [String: Any] = [
            "name": registrtionDTO.nickname,
            "email": registrtionDTO.email,
            "password": registrtionDTO.password,
            "deviceFingerprint": "iOS"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.registration.request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(ApiCustomError.anotherError))
                }
            }
            guard let data = data else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }

            if statusCode == 201 { // Запрос успешный. Можно попробовать разобрать json
                do {
                    let authData = try JSONDecoder().decode(AuthData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(authData))
                    }
                } catch _ {
                    DispatchQueue.main.async {
                        completion(.failure(ApiCustomError.JSONParseError))
                    }
                }
            } else if statusCode == 400 { // Пользвоатель с таким email уже сущевствует
                completion(.failure(ApiCustomError.dublicateUserError))
            } else { // Непредвиденная ошибка
                completion(.failure(ApiCustomError.anotherError))
            }
        }
        task.resume()
    }

    // Запрос на ручку /refresh для обновление пары токенов по рефреш токену
    func updateAccessTokenByRefresh(
        completion: @escaping (Result<AuthData, ApiCustomError>) -> Void,
        refreshToken: String
    ) {
        let json: [String: String] = [
            "deviceFingerprint": "iOS",
            "refreshToken": refreshToken
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiType.updateAccessTokenByRefresh.request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(ApiCustomError.anotherError))
                }
            }

            guard let data else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }

            switch statusCode {
            case 200 ... 300:
                do {
                    let authData = try JSONDecoder().decode(AuthData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(authData))
                    }
                } catch let jsonError {
                    print("Failed decode error:", jsonError)
                    DispatchQueue.main.async {
                        completion(.failure(ApiCustomError.JSONParseError))
                    }
                }
            case 401: // Протух рефреш
                completion(.failure(ApiCustomError.refreshIsExpired))
            default: // Непонятный статус код (непонятная ошибка)
                completion(.failure(ApiCustomError.anotherError))
            }
        }
        task.resume()
    }

    func getPlaces(completion: @escaping (Result<[Place], Error>) -> Void) {
        let request = ApiType.getPlaces.request

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            guard let data else { return }
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
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            if let response {
                print(response.description)
            }
            guard let data else { return }
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

    func getExcursion(excursionId: Int) -> AnyPublisher<Excursion, ApiCustomError> {
        let request = ApiType.getExcursion(token: getAccessToken(), excursionId: excursionId).request
        return fetch(request)
            .retry(3)
            .mapError { error in
                switch error {
                case _ as URLError:
                    return .networkAccess
                default: return .anotherError
                }
            }
            .eraseToAnyPublisher()
    }

    func rateExcursion(excursionId: Int, rating: Int) -> AnyPublisher<RatingResponse, Never> {
        var request = ApiType.rateExcursion(token: getAccessToken(), excursionId: excursionId).request
        let data = RatingRequest(excursionId: excursionId, rating: rating, comment: "")
        do {
            let jsonData = try JSONEncoder().encode(data)
            request.httpBody = jsonData
        } catch {}
        return fetch(request)
            .replaceNil(with: .error)
            .replaceError(with: .error)
            .replaceEmpty(with: .error)
            .eraseToAnyPublisher()
    }

    func deleteAccount(completion: @escaping (Result<User, ApiCustomError>) -> Void, token: String) {
        let request = ApiType.delete(token: token).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(ApiCustomError.anotherError))
                }
            }
        }
        task.resume()
    }
}

// MARK: - ApiCustomError

enum ApiCustomError: String, Error {
    case JSONParseError = "Ошибка приведения JSON"
    case accessIsExpired = "Токен доступа истек" // 401 протух ацесс
    case refreshIsExpired = "Токен обновления истек" // протух рефреш
    case anotherError = "Непредвиденная ошибка" // Любая непонятная ошибка
    case dublicateUserError = "Пользователь с таким Email уже существует" // Ошибка регистрации (юзер с такмим email уже существует)
    case badСredentials = "Неверный Email или пароль" // Ошибка логина (ошибка в кредах)
    case networkAccess = "Отсутствует соединение"
}

// MARK: - BaseService

class BaseService: NSObject {
    // Запрос на API с реквестом, которые создается до запроса и прокидывается сюда
    // для обновления в случае истечения токена
    func callWebService(
        _ request: URLRequest,
        success: @escaping ((_ responseObject: Data) -> Void),
        failure: @escaping ((_ error: ApiCustomError?) -> Void)
    ) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if error != nil {
                DispatchQueue.main.async {
                    failure(ApiCustomError.anotherError)
                }
            }

            guard let data = data else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }

            if statusCode == 200 { // Запрос успешный -> возвращается данные с типом Data
                success(data)
            } else if statusCode == 401 { // Истек access-токен и требуется его обновить
                self.requestForGetNewAccessToken(
                    request: request,
                    success: success,
                    failure: failure
                )
            } else { // Непредвиденная ошибка
                failure(ApiCustomError.anotherError)
            }
        }
        task.resume()
    }

    func fetch<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .map { data, response in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return data }
                var data: Data = data
                if statusCode == 401 {
                    self.requestForGetNewAccessToken(request: request) { responseObj in
                        data = responseObj
                    } failure: { _ in
                        print("error")
                    }
                }
                return data
            }

            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension BaseService {
    func getAccessToken() -> String {
        let accessToken = UserDefaults.standard.string(forKey: UserKeys.accessToken.rawValue)
        guard let accessToken = accessToken else { return "" }
        return accessToken
    }

    // Поулчение нового access-токена по refresh-токену
    func requestForGetNewAccessToken(
        request: URLRequest,
        success: @escaping ((_ responseObject: Data) -> Void),
        failure: @escaping ((_ error: ApiCustomError?) -> Void)
    ) {
        let refreshToken = UserDefaults.standard.string(forKey: UserKeys.refreshToken.rawValue)
        guard let refreshToken = refreshToken else { return }

        // Запрос за новыми токенами по рефреш-токену
        ApiManager.shared.updateAccessTokenByRefresh(
            completion: { result in
                switch result {
                case let .success(authData): // При успехе вовзращается объект с AuthData с новой парой токенов
                    UserDefaultsManager.shared.saveUserAuthData(authData: authData) // Сохранение новых токенов

                    var requestWithNewToken: URLRequest = request // Модернизация исходного запроса
                    requestWithNewToken.setValue("Bearer \(self.getAccessToken())", forHTTPHeaderField: "Authorization") // Добавление к исходному запросу нового токена
                    self.callWebService(requestWithNewToken, success: success, failure: failure)
                case let .failure(error):
                    UserDefaultsManager.shared.removeUserAuthData() // Удаление данных пользователя
                    failure(error)
                }
            },
            refreshToken: refreshToken
        )
    }
}
