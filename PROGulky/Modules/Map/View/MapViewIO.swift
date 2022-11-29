//
//  MapViewIO.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 21/11/2022.
//

import YandexMapsMobile

// MARK: - MapViewOutput

protocol MapViewOutput: AnyObject {
    var detailExcursionInfoViewModel: DetailExcursionInfoViewModel { get }
    func setupRoute()
}

// MARK: - MapViewInput

protocol MapViewInput: AnyObject {
    func showAlert(with alertMessage: String)
    func routeRecieved(route: YMKMasstransitRoute, points: [YMKPoint])
}
