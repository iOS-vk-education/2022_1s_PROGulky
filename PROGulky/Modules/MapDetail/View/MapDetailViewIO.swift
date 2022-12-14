//
//  MapDetailViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

// MARK: - MapDetailViewOutput

protocol MapDetailViewOutput: AnyObject {
    func didLoadView()
    func didTapBackButton()
}

// MARK: - MapDetailViewInput

protocol MapDetailViewInput: AnyObject {
}
