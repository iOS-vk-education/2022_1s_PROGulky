//
//  MapDetailViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

// MARK: - MapDetailViewOutput

protocol MapDetailViewOutput: AnyObject {
    var viewModel: DetailExcursionInfoViewModel { get }
    func viewDidLoad()
    func backButtonTapped()
    func handleSwipe()
}

// MARK: - MapDetailViewInput

protocol MapDetailViewInput: AnyObject {
}
