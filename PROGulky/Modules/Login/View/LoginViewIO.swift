//
//  LoginViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - LoginViewOutput

protocol LoginViewOutput: AnyObject {
    func didTapSignInButton(loginDTO: LoginDTO)
    func didSelectSignUpBtn()
}

// MARK: - LoginViewInput

protocol LoginViewInput: AnyObject {
    func showAlert(message: String)
}
