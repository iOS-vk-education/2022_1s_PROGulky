//
//  LoginViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - LoginViewOutput

protocol LoginViewOutput: AnyObject {
    func didSelectSignInBtn(token: String, id: Int, email: String, name: String, role: String)
    func didSelectSignUpBtn()
}

// MARK: - LoginViewInput

protocol LoginViewInput: AnyObject {
}
