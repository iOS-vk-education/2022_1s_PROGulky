//
//  ProfileBuilder.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - ProfileModuleBuilder

final class ProfileModuleBuilder {
    func build(_ moduleOutput: ProfileModuleOutput) -> UIViewController {
        let viewController = ProfileViewController()
        let router = ProfileRouter()
        let userDefaultsLoginService = UserDefaultsLoginService.shared
        let userInfoHeaderDisplayDataFactory = UserInfoHeaderDisplayDataFactory()

        let interactor = ProfileInteractor(userDefaultsLoginService: userDefaultsLoginService)

        let presenter = ProfilePresenter(interactor: interactor, router: router, moduleOutput: moduleOutput, headerFactory: userInfoHeaderDisplayDataFactory)
        presenter.view = viewController

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
