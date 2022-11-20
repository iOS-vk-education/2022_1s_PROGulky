//
//  Int+Extensions.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 21.11.2022.
//

import Foundation

extension Int {
    func places() -> String {
        var placeString: String!
        if "1".contains("\(self % 10)") { placeString = "место" }
        if "234".contains("\(self % 10)") { placeString = "места" }
        if "567890".contains("\(self % 10)") { placeString = "мест" }
        if 11 ... 14 ~= self % 100 { placeString = "мест" }
        return "\(self) " + placeString
    }
}
