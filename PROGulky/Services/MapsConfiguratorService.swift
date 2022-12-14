//
//  MapsConfiguratorService.swift
//  PROGulky
//
//  Created by Иван Тазенков on 22.11.2022.
//

import Foundation
import YandexMapsMobile

// MARK: - MapsConfiguratorServiceProtocol

protocol MapsConfiguratorServiceProtocol {
    func activateMaps()
}

// MARK: - MapsConfiguratorService

final class MapsConfiguratorService {
    // MARK: Private data structures

    private enum Constants {
        static let apiKey1 = "6d047132-8ff7-46de"
        static let apiKey2 = "-b166-1e771cb9033a"
    }
}

// MARK: MapsConfiguratorServiceProtocol

extension MapsConfiguratorService: MapsConfiguratorServiceProtocol {
    func activateMaps() {
        let key = Constants.apiKey1 + Constants.apiKey2
        YMKMapKit.setApiKey(key)
        YMKMapKit.setLocale("ru_RU")
        YMKMapKit.sharedInstance()
    }
}
