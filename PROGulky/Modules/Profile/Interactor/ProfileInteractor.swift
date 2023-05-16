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
}
