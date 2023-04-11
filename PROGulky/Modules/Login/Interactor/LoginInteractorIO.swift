//
//  LoginInteractorIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import Foundation

// MARK: - LoginInteractorOutput

protocol LoginInteractorOutput: AnyObject {
    func successLogin(id: User)
    func handleError(error: Error)
}

// MARK: - LoginInteractorInput

protocol LoginInteractorInput: AnyObject {
    func login(_ loginDTO: LoginDTO)
}
