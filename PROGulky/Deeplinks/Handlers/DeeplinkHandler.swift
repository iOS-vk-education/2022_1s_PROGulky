//
//  DeeplinkHandler.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29.05.2023.
//
import Foundation

// MARK: - DeeplinkHandlerProtocol

protocol DeeplinkHandlerProtocol {
    func openDeeplink(_: DeeplinkType) -> Bool
}

// MARK: - DeeplinkHandler

final class DeeplinkHandler: DeeplinkHandlerProtocol {
    func openDeeplink(_ deeplink: DeeplinkType) -> Bool {
        deeplink.handler.openDeeplink(deeplink)
    }
}
