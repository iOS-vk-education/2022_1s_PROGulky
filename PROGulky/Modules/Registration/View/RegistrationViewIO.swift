//
//  RegistrationViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - RegistrationViewOutput

protocol RegistrationViewOutput: AnyObject {
    func didSelectSignUpBtn(token: String, id: Int, email: String, name: String, role: String)
}

// MARK: - RegistrationViewInput

protocol RegistrationViewInput: AnyObject {
}
