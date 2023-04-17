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

        testToken { result in
            switch result {
            case .success:
                print("SUCCESS")
            case .failure:
                print("FAILURE")
            }
        }
    }

    private func testToken(completion: @escaping (Result<Auth, ApiCustomErrors>) -> Void) {
        let token = UserDefaults.standard.string(forKey: UserKeys.accessToken.rawValue)
//        UserDefaultsManager.shared.removeUserAuthData()
//        return
        print("[DEBUG]: \(UserDefaultsManager.shared.isLogged)")

        ApiManager.shared.getMeInfo2(success: { data in
            guard let data = data else { return }

            print("[DEBUG] AnyObjectData: \(data)")

        }, failure: { error in
            print("ERRRRRr: \(error)")
        })
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
        ApiManager.shared.updateAccessTokenByRefresh(completion: { result in
                                                         print(result)
                                                         switch result {
                                                         case let .success(token):
                                                             UserDefaultsManager.shared.saveUserAuthData(authData: token)
                                                             DispatchQueue.main.async {
                                                                 completion(.success(token))
                                                             }
                                                         case let .failure(failure):
                                                             DispatchQueue.main.async {
                                                                 completion(.failure(failure))
                                                             }
                                                         }
                                                     },
                                                     refreshToken: "")
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
