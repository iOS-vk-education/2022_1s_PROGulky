//
//  ProfilePresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ProfilePresenter

final class ProfilePresenter {
    // MARK: - Public Properties

    weak var view: ProfileViewInput!

    // MARK: - Private Properties

    private let interactor: ProfileInteractorInput
    private let router: ProfileRouterInput
    private weak var moduleOutput: ProfileModuleOutput?

    // MARK: - Lifecycle

    init(interactor: ProfileInteractorInput, router: ProfileRouterInput, moduleOutput: ProfileModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

// MARK: ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    func logoutButtonTapped() {
        UserDefaults.standard.set(true, forKey: "isLoggedOut")
        moduleOutput?.profileModuleWantsToOpenLoginModule()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
}
