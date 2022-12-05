//
//  MapDetailRouter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 29/11/2022.
//

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
    func embedMapModule(output: MapModuleOutput) {
        let builder = MapModuleBuilder()
        let mapViewController = builder.build(moduleOutput: output, excursion: excursion)
        mapDetailViewController?.embedMapModule(mapViewController)
    }

    func embedDetailModule(output: DetailExcursionModuleOutput) {
        let builder = DetailExcursionModuleBuilder()
        let detailViewController = builder.build(for: excursion, moduleOutput: output)
        mapDetailViewController?.embedDetailModule(detailViewController)
    }
}
