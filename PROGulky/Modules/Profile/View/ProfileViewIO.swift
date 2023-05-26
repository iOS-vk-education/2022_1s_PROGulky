//
//  ProfileViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - ProfileViewOutput

protocol ProfileViewOutput: AnyObject {
    var headerDisplayData: UserInfoHeader.DisplayData { get }
    func logoutButtonTapped()
    func deleteAccountButtonTapped()
    func saveUserAvatar(image: UIImage)
}

// MARK: - ProfileViewInput

protocol ProfileViewInput: AnyObject {
    func showErrorView()
}
