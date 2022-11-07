//
//  ProfilePresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ProfilePresenter

final class ProfilePresenter {
    // MARK: - Public Properties

    weak var view: ProfileViewInput!

    // MARK: - Private Properties

    private let interactor: ProfileInteractorInput
    private let router: ProfileRouterInput
    private let factory = OtherViewDisplayDataFactory()

    // MARK: - Lifecycle

    init(interactor: ProfileInteractorInput, router: ProfileRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

// MARK: ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    func getAnotherDisplayData() -> ProfileUserAnotherView.DisplayData {
        factory.setDisplayDataForOtherView(type: .other)
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
}
