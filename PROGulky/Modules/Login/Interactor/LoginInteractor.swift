//
//  LoginInteractor.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import Foundation

// MARK: - LoginInteractor

final class LoginInteractor {
    weak var output: LoginInteractorOutput?
}

// MARK: LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
    func login(email: String, password: String) -> (User?) {
        let semaphore = DispatchSemaphore(value: 0)

        var returnData: User?
        let json: [String: Any] = [
            "email": email,
            "password": password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        print(json)

        var request = URLRequest(url: URL(string: baseURL + "/auth/login/")!, timeoutInterval: Double.infinity)
        print("request \(request)")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            returnData = try? JSONDecoder().decode(User.self, from: data)
            print("login returnData \(String(describing: returnData))")
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return returnData
    }
}
