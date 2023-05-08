//
//  RegistrationInteractorIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import Foundation

// MARK: - RegistrationInteractorOutput

protocol RegistrationInteractorOutput: AnyObject {
    func successRegistration(user: User)
    
    func handleError(error: ApiCustomErrors)
}

// MARK: - RegistrationInteractorInput

protocol RegistrationInteractorInput: AnyObject {
    func registration(_ registrationDTO: RegistrationDTO)
}
