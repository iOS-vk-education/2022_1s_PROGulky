//
//  RegistrationViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - RegistrationViewOutput

protocol RegistrationViewOutput: AnyObject {
    func didSelectSignUpBtn(user: User)
}

// MARK: - RegistrationViewInput

protocol RegistrationViewInput: AnyObject {
}
