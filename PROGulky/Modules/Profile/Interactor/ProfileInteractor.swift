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
}
