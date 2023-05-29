//
//  ProfileModuleIO.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

// MARK: - ProfileModuleInput

protocol ProfileModuleInput: AnyObject {
}

// MARK: - ProfileModuleOutput

protocol ProfileModuleOutput: AnyObject {
    func profileModuleWantsToOpenScreen(with page: TabBarPage) // Открыть экран по id таббара
}
