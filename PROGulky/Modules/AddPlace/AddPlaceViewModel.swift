//
//  AddPlaceViewModel.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import Foundation

// MARK: - AppPlaceViewModuleOutput

protocol AppPlaceViewModuleOutput: AnyObject {
    func addPlaceViewModuleWantsToClose()
}

// MARK: - AddPlaceViewModel

final class AddPlaceViewModel: ObservableObject {
    @Published var places: [Place] = .init()
    @Published var selectedPlaces = [Place]()
    private let apiManager = ApiManager.shared
    private let selectedPlacesManager = SelectedPlacesManager.sharedInstance
    private weak var moduleOutput: AppPlaceViewModuleOutput?

    init(moduleOutput: AppPlaceViewModuleOutput) {
        obtainPlaces()
        checkSelectedPlaces()
        self.moduleOutput = moduleOutput
    }

    private func obtainPlaces() {
        apiManager.getPlaces { result in
            switch result {
            case let .success(places):
                self.places = places
            case .failure:
                self.places = [Place]()
            }
        }
    }

    private func checkSelectedPlaces() {
        selectedPlaces = selectedPlacesManager.selectedPlaces
    }

    func selectPlace(place: Place) {
        selectedPlacesManager.addOrRemovePlace(place)
        checkSelectedPlaces()
    }

    func viewWillDisappear() {
        moduleOutput?.addPlaceViewModuleWantsToClose()
    }
}
