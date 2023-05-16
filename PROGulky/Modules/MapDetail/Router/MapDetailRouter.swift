//
//  MapDetailRouter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

import SwiftUI

// MARK: - MapDetailRouter

final class MapDetailRouter {
    weak var mapDetailViewController: MapDetailTransitionHandlerProtocol?
    private let excursion: Excursion

    init(_ transitionHandler: MapDetailTransitionHandlerProtocol? = nil,
         excursion: Excursion) {
        mapDetailViewController = transitionHandler
        self.excursion = excursion
    }
}

// MARK: MapDetailRouterInput

extension MapDetailRouter: MapDetailRouterInput {
    func embedDetailModule() {
        let viewModel = DetailExcursionViewModel(excursionId: excursion.id)
        let detailView = DetailExcursionView(viewModel: viewModel)
        let hostingViewController = UIHostingController(rootView: detailView)
        mapDetailViewController?.embedDetailModule(hostingViewController)
    }

    func embedMapModule(output: MapModuleOutput) {
        let builder = MapModuleBuilder()
        let mapViewController = builder.build(excursion: excursion)
        mapDetailViewController?.embedMapModule(mapViewController)
    }
}
