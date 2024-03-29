//
//  ProfileInteractorIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import Foundation

// MARK: - ProfileInteractorOutput

protocol ProfileInteractorOutput: AnyObject {
    func successLoadImage(with fileName: String)

    func successSetImage()

    func gotError()
}

// MARK: - ProfileInteractorInput

protocol ProfileInteractorInput: AnyObject {
    func logout()

    func deleteAccount()

    func postUserImage(userAvater: UserImageForPost)

    func setUserImage(with fileName: String) // Установить название загруженной картинки в боле image объекта user
}
