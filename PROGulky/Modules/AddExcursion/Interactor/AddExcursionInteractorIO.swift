//
//  AddExcursionInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - AddExcursionInteractorOutput

protocol AddExcursionInteractorOutput: AnyObject {
}

// MARK: - AddExcursionInteractorInput

protocol AddExcursionInteractorInput: AnyObject {
    func sendExcursion(excursion: ExcursionForPost)
}
