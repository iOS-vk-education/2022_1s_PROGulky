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
    private let headerFactory: UserInfoHeaderDisplayDataFactoryProtocol

    // MARK: - Lifecycle

    init(interactor: ProfileInteractorInput, router: ProfileRouterInput, moduleOutput: ProfileModuleOutput, headerFactory: UserInfoHeaderDisplayDataFactoryProtocol) {
        self.interactor = interactor
        self.router = router
        self.moduleOutput = moduleOutput
        self.headerFactory = headerFactory
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

// MARK: ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    var headerDisplayData: UserInfoHeader.DisplayData {
        headerFactory.getDisplayData()
    }

    func logoutButtonTapped() {
        interactor.logout()
        moduleOutput?.profileModuleWantsToOpenLoginModule()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
}
