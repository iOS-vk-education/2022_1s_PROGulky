//
//  RegistrationInteractor.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//
import Foundation

// MARK: - RegistrationInteractor

final class RegistrationInteractor {
    weak var output: RegistrationInteractorOutput?
    let urlAdress = "http://37.140.195.167:5000"
}

// MARK: RegistrationInteractorInput

extension RegistrationInteractor: RegistrationInteractorInput {
    func registration(email: String, name: String, password: String) -> (Login?) {
        let semaphore = DispatchSemaphore(value: 0)

        var returnData: Login?
        let json: [String: Any] = [
            "email": email,
            "name": name,
            "password": password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        print(json)

        var request = URLRequest(url: URL(string: urlAdress + "/auth/registration")!, timeoutInterval: Double.infinity)
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
            returnData = try? JSONDecoder().decode(Login.self, from: data)
            print("login returnData \(String(describing: returnData))")
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return returnData
    }
}
