//
//  ErrorReprView.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 27.05.2023.
//

import Foundation
import SwiftUI

struct RepresentedErrorHUDView: UIViewRepresentable {
    var errorMessage: String
    let errorView = ErrorHUDView(frame: .zero)

    func makeUIView(context: Context) -> ErrorHUDView {
        errorView.configure(with: errorMessage)
        return errorView
    }

    func updateUIView(_ uiView: ErrorHUDView, context: Context) {
        uiView.configure(with: errorMessage)
    }
}
