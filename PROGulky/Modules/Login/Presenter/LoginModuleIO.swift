//
//  LoginModuleIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

// MARK: - LoginModuleInput

protocol LoginModuleInput: AnyObject {
}

// MARK: - LoginModuleOutput

protocol LoginModuleOutput: AnyObject {
    func loginModuleWantsToOpenProfile()

    func loginModuleWantsToOpenRegistrationModule()
}
