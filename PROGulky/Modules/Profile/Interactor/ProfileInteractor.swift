//
//  ProfileInteractor.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ProfileInteractor

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
}

// MARK: ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {
    func logout() {
        UserAuthService.shared.logout()
    }

    func deleteAccount() {
        UserDefaultsManager.shared.removeUserAuthData()
        let token = UserService.shared.userToken
        UserAuthService.shared.deleteAccount(completion: { [weak self] result in
            switch result {
            case let .success(userData):
                print("[DEBUG] \(userData)")
            case let .failure(error):
                print("[DEBUG] \(error)")
            }
        }, token: token)
    }

    func getUserInfo() {
        print("[UserService]", UserService.shared.userData.token)
//        UserAuthService.shared.login(dto: loginDTO) { [weak self] result in
//            switch result {
//            case let .success(token):
//                print("HERE OPEN PROFILE")
//                self?.output?.successLogin(token: token)
//            case let .failure(error):
//                self?.output?.handleError(error: error)
//            }
//        }
    }

    func postUserImage(userAvater: UserImageForPost) {
        ApiManager.shared.sendUserAvatar(userAvater: userAvater) { result in
            switch result {
            case let .success(success):
                print(success.fileName)
                self.output?.successeded()
            case let .failure(failure):
                self.output?.gotError()
            }
        }
    }
}
