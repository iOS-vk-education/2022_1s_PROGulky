//
//  ProfileViewIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ProfileViewOutput

protocol ProfileViewOutput: AnyObject {
    func getAnotherDisplayData() -> ProfileUserAnotherView.DisplayData
}

// MARK: - ProfileViewInput

protocol ProfileViewInput: AnyObject {
}
