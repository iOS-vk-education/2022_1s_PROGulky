//
//  Int+Extensions.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 21.11.2022.
//

import Foundation

extension Int {
    func wordEnding(for wordRoot: String) -> String {
        var placeString: String!
        if "1".contains("\(self % 10)") { placeString = "\(wordRoot)о" }
        if "234".contains("\(self % 10)") { placeString = "\(wordRoot)а" }
        if "567890".contains("\(self % 10)") { placeString = "\(wordRoot)" }
        if 11 ... 14 ~= self % 100 { placeString = "\(wordRoot)" }
        return "\(self) " + placeString
    }
}
