//
//  View+ResignKeyboard.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

//
//// MARK: - ResignKeyboardOnDragGesture
//
// struct ResignKeyboardOnDragGesture: ViewModifier {
//    var gesture = DragGesture().onChanged { _ in
//        UIApplication.shared.endEditing(true)
//    }
//
//    func body(content: Content) -> some View {
//        content.gesture(gesture)
//    }
// }
//
// extension View {
//    func resignKeyboardOnDragGesture() -> some View {
//        modifier(ResignKeyboardOnDragGesture())
//    }
// }
