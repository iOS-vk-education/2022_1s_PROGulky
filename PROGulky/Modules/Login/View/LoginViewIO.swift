//
//  LoginViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - LoginViewOutput

protocol LoginViewOutput: AnyObject {
    func didSelectSignInBtn(user: User)
    func didSelectSignUpBtn()
}

// MARK: - LoginViewInput

protocol LoginViewInput: AnyObject {
}
