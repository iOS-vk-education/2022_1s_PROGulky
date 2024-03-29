//
//  ProfilePresenter.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation
import UIKit

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

        // Перейти на главный экран (список экскурсий) при логауте
        moduleOutput?.profileModuleWantsToOpenScreen(with: .excursionList)
    }

    func deleteAccountButtonTapped() {
        interactor.deleteAccount()
        moduleOutput?.profileModuleWantsToOpenScreen(with: .excursionList)
    }

    func saveUserAvatar(image: UIImage) {
        let avatar = UserImageForPost(image: image)
        // TODO: добавить запуск лоадера
        interactor.postUserImage(userAvater: avatar)
    }
}

// MARK: ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    func successSetImage() {
        // TODO: добавить остановку лоадера
        print("Success Set")
    }

    func successLoadImage(with fileName: String) {
        interactor.setUserImage(with: fileName)
    }

    func gotError() {
        view.showErrorView()
    }
}
