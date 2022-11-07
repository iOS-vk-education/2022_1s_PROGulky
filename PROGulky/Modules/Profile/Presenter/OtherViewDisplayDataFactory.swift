//
//  OtherViewDisplayDataFactory.swift
//  PROGulky
//
//  Created by Иван Тазенков on 07.11.2022.
//

import Foundation

// MARK: - ProfileViewType

enum ProfileViewType {
    case account
    case other
}

// MARK: - OtherViewDisplayDataFactoryProtocol

protocol OtherViewDisplayDataFactoryProtocol {
    func setDisplayDataForOtherView(type: ProfileViewType) -> ProfileUserAnotherView.DisplayData
}

// MARK: - OtherViewDisplayDataFactory

final class OtherViewDisplayDataFactory: OtherViewDisplayDataFactoryProtocol {
    func setDisplayDataForOtherView(type: ProfileViewType) -> ProfileUserAnotherView.DisplayData {
        switch type {
        case .account:
            let data = ProfileUserAnotherView.DisplayData(text1: "", text2: "")
            return data
        case .other:
            let data = ProfileUserAnotherView.DisplayData(text1: "", text2: "")
            return data
        }
    }
}
