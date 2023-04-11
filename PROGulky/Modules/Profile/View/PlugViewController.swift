//
//  PlugViewController.swift
//  PROGulky
//
//  Created by Сергей Киселев on 27.12.2022.
//

import UIKit

// MARK: - PlugViewController

final class PlugViewController: UIViewController {
//    var output: ProfileViewOutput
    private let moduleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "gear")?.withTintColor(.prog.Dynamic.primary, renderingMode: .alwaysOriginal)
        return iv
    }()

    private let moduleLabel: UILabel = {
        let label = UILabel()
        label.text = "Модуль в разработке"
        label.textColor = .prog.Dynamic.primary
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .prog.Dynamic.background
        configureUI()
        testToken { [weak self] result in
            switch result {
            case .success:
                print("SUCCESS")
            case let .failure(error):
                print("FAILURE")
            }
        }
    }

    private func testToken(completion: @escaping (Result<Auth, Error>) -> Void) {
        let token = UserDefaults.standard.string(forKey: UserKeys.accessToken.rawValue)
        print("[DEBUG] test token", token)
        ApiManager.shared.getUserInfo(
            completion: { result in
                switch result {
                case let .success(user):
                    print(user.statusCode)
                    switch user.statusCode {
                    case 401:
//                        print("[DEBUG] test token 401")
//                        print("[DEBUG] refresh:", UserDefaults.standard.string(forKey: UserKeys.refreshToken.rawValue))
//                        print("[DEBUG] access:", UserDefaults.standard.string(forKey: UserKeys.accessToken.rawValue))

                        self.updateData { [weak self] result in
                            switch result {
                            case let .success(token):
//                                print("HOROSHO")
//                                print(print("[DEBUG] access:", UserDefaults.standard.string(forKey: UserKeys.accessToken.rawValue)))
                                break
                            case let .failure:
//                                print("NE HOROSHO")
                                break
                            }
                        }
                        if token == nil {
                            self.logout()
                        }

                    case nil:
//                        print("[DEBUG] test token OK")
//                        print("[DEBUG] access:", UserDefaults.standard.string(forKey: UserKeys.accessToken.rawValue))
//                        print("[DEBUG] refresh:", UserDefaults.standard.string(forKey: UserKeys.refreshToken.rawValue))
                        break
                    default:
                        print("[DEBUG] test token ERROR")
                    }
                case let .failure(failure):
//                    print("[DEBUG] test token NOT")
                    break
                }
            },
            token: token ?? "0"
        )
    }

    func logout() {
        print("здесь выбрасывать на логин и чистить кэш")
//        UserDefaultsManager.shared.removeUserAuthData() // removeUserAuthData()
//        let vc = LoginViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
//        output.logoutButtonTapped()
    }

    func updateData(completion: @escaping (Result<Auth, Error>) -> Void) {
        ApiManager.shared.updateAccessTokenByRefresh { result in
            print(result)
            switch result {
            case let .success(token):
                UserDefaultsManager.shared.setUserAuthData(token: token)
                DispatchQueue.main.async {
                    completion(.success(token))
                }
            case let .failure(failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }

    private func configureUI() {
        let imageSize = 150
        view.addSubview(moduleImageView)
        view.addSubview(moduleLabel)
        moduleImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
        }

        moduleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.moduleImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
