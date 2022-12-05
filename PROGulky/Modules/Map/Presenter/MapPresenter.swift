//
//  MapPresenter.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 21/11/2022.
//

// MARK: - MapPresenter

import Foundation
import YandexMapsMobile

// MARK: - MapPresenter

final class MapPresenter {
    // MARK: - Public Properties

    weak var view: MapViewInput!

    // MARK: - Private Properties

    private let interactor: MapInteractorInput
    private let router: MapRouterInput
    private let excursion: Excursion
    private var massTransitSession: YMKMasstransitSession?
    private var requestPoints = [YMKRequestPoint]()
    private let factory = DetailExcursionDisplayDataFactory()
    private weak var moduleOutput: MapModuleOutput?

    // MARK: - Lifecycle

    init(interactor: MapInteractorInput, router: MapRouterInput, excursion: Excursion, moduleOutput: MapModuleOutput) {
        self.interactor = interactor
        self.router = router
        self.excursion = excursion
        self.moduleOutput = moduleOutput
    }

    func onRoutesReceived(_ routes: [YMKMasstransitRoute]) {
        guard let route = routes.first else { return }
        let points = requestPoints.map(\.point)
        view.routeRecieved(route: route, points: points)
    }

    func onRoutesError(_ error: Error) {
        guard let routingError = (error as NSError).userInfo[YRTUnderlyingErrorKey]
            as? YRTError else { return }
        var errorMessage = "Unknown error"
        if routingError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if routingError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }

        view.showAlert(with: errorMessage)
    }
}

extension MapPresenter: MapModuleInput {
}

// MARK: MapViewOutput

extension MapPresenter: MapViewOutput {
    var detailExcursionInfoViewModel: DetailExcursionInfoViewModel {
        factory.setupViewModel(excursion: excursion).infoViewModel
    }

    func setupRoute() {
        var count = 0
        excursion.places.forEach { place in
            let point = YMKRequestPoint(
                point: YMKPoint(latitude: Double(place.latitude) ?? 0,
                                longitude: Double(place.longitude) ?? 0),
                type: count == 0 || count == excursion.places.count - 1 ? .waypoint : .viapoint,
                pointContext: nil
            )
            requestPoints.append(point)
            count += 1
        }

        let responseHandler = { (routesResponse: [YMKMasstransitRoute]?, error: Error?) in
            if let routes = routesResponse {
                self.onRoutesReceived(routes)
            } else {
                self.onRoutesError(error!)
            }
        }

        let pedestrianRouter = YMKTransport.sharedInstance().createPedestrianRouter()
        massTransitSession = pedestrianRouter.requestRoutes(
            with: requestPoints,
            timeOptions: YMKTimeOptions(departureTime: Date(), arrivalTime: nil),
            routeHandler: responseHandler
        )
    }
}

extension MapPresenter: MapInteractorOutput {
}
