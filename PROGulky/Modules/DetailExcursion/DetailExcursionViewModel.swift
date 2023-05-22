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

    var excursionData: Excursion? // Данные как они приходят с API
    var isFavourite: Bool = false // Есть ли экскурсия с переданным id в избранном

    private var massTransitSession: YMKMasstransitSession?
    private var requestPoints = [YMKRequestPoint]()

    @Published var polyline = YMKPolyline(points: [])
    @Published var points = [YMKPoint]()

    init(excursionId: Int) {
        excursion.id = excursionId
        loadModel()
    }

    public func didiLikeButtonTapped() {
        excursion.isLiked.toggle()
        guard let excursion = excursionData else { return }

        if isFavourite == false {
            ExcursionsRepository.shared.addFavouriveExcursion(with: excursion)
        } else {
            ExcursionsRepository.shared.removeFavouriveExcursion(with: excursion.id)
        }
    }

    private func loadModel() {
        ApiManager.shared.getExcursion(
            excursionId: excursion.id,
            success: { excursion in
                self.isFavourite = ExcursionsRepository.shared.getIssetFavouriveExcursion(with: excursion.id) // Вычисление есть ли экскурсия в избранном
                self.excursionData = excursion

                self.excursion = DetailExcursionDisplayDataFactory().setupViewModel(excursion: excursion, isFavourite: self.isFavourite)
                self.places = DetailExcursionDisplayDataFactory().getPlacesCoordinates(excursion.places)
                self.getRoute()
            }, failure: { error in
                // TODO: тут реализуется бизнес логика на какой экран пойти пользователю, если при запросе токены протухли и хранилище с данными очистилось
                print("[DEBUG] error: \(error)")
            }
        )
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
