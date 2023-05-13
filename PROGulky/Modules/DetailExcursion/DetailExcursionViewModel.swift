//
//  DetailExcursionViewModel.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 23.04.2023.
//

import Foundation
import YandexMapsMobile

// MARK: - DetailExcursionViewModel

final class DetailExcursionViewModel: ObservableObject {
    @Published var excursion = DetailExcursion.empty
    @Published var places = [PlaceCoordinates.empty]

    private var massTransitSession: YMKMasstransitSession?
    private var requestPoints = [YMKRequestPoint]()

    @Published var polyline = YMKPolyline(points: [])
    @Published var points = [YMKPoint]()

    init(excursionId: Int) {
        excursion.id = excursionId
        loadModel()
    }

    private func loadModel() {
        ApiManager.shared.getExcursion(
            token: UserService.shared.userToken,
            excursionId: excursion.id
        ) { result in
            switch result {
            case let .success(excursion):
                self.excursion = DetailExcursionDisplayDataFactory().setupViewModel(excursion: excursion)
                self.places = DetailExcursionDisplayDataFactory().getPlacesCoordinates(excursion.places)
                self.getRoute()
            case let .failure(failure):
                print(failure.localizedDescription)
            }
        }
    }

    private func getRoute() {
        let lastWayPointNumber = places.count - 1

        requestPoints = places.enumerated().map { element in
            let place = element.element
            let count = element.offset
            let point = YMKRequestPoint(
                point: YMKPoint(latitude: place.latitude,
                                longitude: place.longitude),
                type: count == 0 || count == lastWayPointNumber ? .waypoint : .viapoint,
                pointContext: nil
            )
            return point
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

    private func onRoutesReceived(_ routes: [YMKMasstransitRoute]) {
        guard let route = routes.first else { return }
        polyline = route.geometry
        points = requestPoints.map(\.point)
    }

    private func onRoutesError(_ error: Error) {
        guard let routingError = (error as NSError).userInfo[YRTUnderlyingErrorKey]
            as? YRTError else { return }
        var errorMessage = "Unknown error"
        if routingError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if routingError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }
        // TODO: Show Alert
    }
}
