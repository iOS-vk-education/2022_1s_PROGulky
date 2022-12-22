//
//  UserProvider.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.12.2022.
//

import Foundation

// Класс замокан. В этом классе должна быть реализована работа с профилем
final class UserProvider {
    static let provider = UserProvider()
    let defaults = UserDefaultsLoginService()

    static let a = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    static let b = ".eyJpZCI6MSwibmFtZSI6ItCh0LXQvNC10L0iLCJlbWFpbCI6InNlbXlvbkBlbWFpbC5ydSIsInJvbGVzIjp7ImlkIjoyLCJ2YWx1ZSI6InVzZXIiLCJkZXNjcmlwdGlvbiI6ItCf"
    static let b0 = "0L7Qu9GM0LfQvtCy0LDRgtC10LvRjCIsImNyZWF0ZWRBdCI6IjIwMjItMTEtMjJUMjE6NDc6MjQuMjE3WiIsInVwZGF0ZWRBdCI6IjIwMjItMTEtMjJ"
    static let b1 = "UMjE6NDc6MjQuMjE3WiJ9LCJpYXQiOjE2NzE0Njc1NDksImV4cCI6MTY3NDA1OTU0OX0"
    static let c = ".rQYxqYWbe3qy3mBCDxxm3WlEJHOmZ5_NdbbrJRa3Ocs"
    let mockToken = "\(a)\(b)\(b0)\(b1)\(c)"

    func userIsAuth() -> Bool {
        defaults.isAuth()
    }

    func userToken() -> String? {
        defaults.userToken()
    }
}
