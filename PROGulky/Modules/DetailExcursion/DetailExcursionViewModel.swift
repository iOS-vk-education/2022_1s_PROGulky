//
//  DetailExcursionViewModel.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 23.04.2023.
//

import Foundation
import Combine
import YandexMapsMobile

// MARK: - DetailExcursionViewModel

final class DetailExcursionViewModel: ObservableObject {
    @Published var excursion = DetailExcursion.empty
    @Published var places = [PlaceCoordinates.empty]
    var excursionData: Excursion?
    var isFavourite: Bool = false // Есть ли экскурсия с переданным id в избранном
    private var excursionCancelable: AnyCancellable?
    private var massTransitSession: YMKMasstransitSession?
    private var requestPoints = [YMKRequestPoint]()

    @Published var polyline = YMKPolyline(points: [])
    @Published var loading: Bool = true
    @Published var points = [YMKPoint]()

    var guardedExcursion: Excursion {
        guard let excursionData else { return .empty }
        return excursionData
    }

    init(excursionId: Int) {
        excursion.id = excursionId
        refresh()
    }

    public func didiLikeButtonTapped() {
        excursion.isLiked.toggle()
        guard let excursion = excursionData else { return }

        if isFavourite == false {
            isFavourite = true
            ExcursionsRepository.shared.addFavouriveExcursion(with: excursion)
        } else {
            isFavourite = false
            ExcursionsRepository.shared.removeFavouriveExcursion(with: excursion.id)
        }
    }

    func refresh() {
        guard excursionData == nil else { return }
        loading = true
        excursionCancelable = ApiManager.shared
            .getExcursion(excursionId: excursion.id)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                excursionData = value
                isFavourite = ExcursionsRepository.shared.getIssetFavouriveExcursion(with: excursion.id)
                excursion = DetailExcursionDisplayDataFactory()
                    .setupViewModel(excursion: value, isFavourite: self.isFavourite)
                places = DetailExcursionDisplayDataFactory().getPlacesCoordinates(value.places)
                getRoute()
                loading = false
            })
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
}
