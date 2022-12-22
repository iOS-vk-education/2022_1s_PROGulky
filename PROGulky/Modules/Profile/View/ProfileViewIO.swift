//
//  ProfileViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ProfileViewOutput

protocol ProfileViewOutput: AnyObject {
    var headerDisplayData: UserInfoHeader.DisplayData { get }
    func logoutButtonTapped()
}

// MARK: - ProfileViewInput

protocol ProfileViewInput: AnyObject {
}
