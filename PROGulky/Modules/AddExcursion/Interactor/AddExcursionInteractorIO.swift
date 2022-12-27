//
//  AddExcursionInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - AddExcursionInteractorOutput

protocol AddExcursionInteractorOutput: AnyObject {
    func gotAuthError()
    func gotAnotherError()
    func successeded()
}

// MARK: - AddExcursionInteractorInput

protocol AddExcursionInteractorInput: AnyObject {
    func sendExcursion(excursion: ExcursionForPost)
}
