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
    case registration

    var baseURL: String {
        "http://37.140.195.167:5000"
    }

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .registration: return "/auth/registration"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)

        switch self {
        case .login, .registration:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}

// MARK: - ApiManagerLogin

final class ApiManagerLogin {
    static let shared = ApiManagerLogin()

    func login(_ loginDTO: LoginDTO, completion: @escaping (Result<User, Error>) -> Void) {
        let json: [String: Any] = [
            "email": loginDTO.email,
            "password": loginDTO.password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = ApiTypeLogin.login.request
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

        var request = ApiTypeLogin.registration.request
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
