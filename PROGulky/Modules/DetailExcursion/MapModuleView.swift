//
//  MapModuleView.swift
//  PROGulky
//
//  Created by Иван Тазенков on 25.05.2023.
//

import Foundation
import SwiftUI
struct MapModuleView: UIViewControllerRepresentable {
    let excursion: Excursion
    func makeUIViewController(context: Context) -> some UIViewController {
        let builder = MapModuleBuilder()
        let vc = builder.build(excursion: excursion)
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
