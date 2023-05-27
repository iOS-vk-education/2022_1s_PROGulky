//
//  RatingViewModel.swift
//  PROGulky
//
//  Created by Иван Тазенков on 25.05.2023.
//

import Foundation
import Combine

// MARK: - DetailExcursionViewModel

final class RatingViewModel: ObservableObject {
    @Published var ratingState = RatingState.notYet
    private var excursionId = 0
    private var ratingCancelable: AnyCancellable?

    init(excursionId: Int) {
        self.excursionId = excursionId
    }

    func rate(rating: Int) {
        ratingCancelable = ApiManager.shared
            .rateExcursion(excursionId: excursionId, rating: rating)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { resp in
                print(resp)
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                self.ratingState = RatingState(response.status)

            })
    }
}
