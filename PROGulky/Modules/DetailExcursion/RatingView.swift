//
//  RatingView.swift
//  PROGulky
//
//  Created by Иван Тазенков on 25.05.2023.
//

import SwiftUI
struct RatingView: View {
    @ObservedObject private var viewModel: RatingViewModel
    @State private var rating: Int = 0
    @Binding private var isShown: Bool
    @Environment(\.colorScheme) private var colorScheme

    private let maximumRating = 5
    private let image = Image(systemName: "star.fill")

    private let offColor = Color.gray
    private let onColor = Color.yellow
    private var backgroundColor: Color {
        colorScheme == .light ? .backgroundL : .backgroundD
    }

    init(viewModel: RatingViewModel, isShown: Binding<Bool>) {
        self.viewModel = viewModel
        _isShown = isShown
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.ratingState.message)
                .padding([.top], 20)
                .padding([.leading], 12)
                .padding([.trailing], 12)
                .padding([.bottom], 4)
                .multilineTextAlignment(.center)
            HStack {
                ForEach(1 ..< maximumRating + 1, id: \.self) { number in
                    image
                        .foregroundColor(number > rating ? offColor : onColor)
                        .onTapGesture {
                            rating = number
                        }
                }
            }
            HStack(spacing: 20) {
                if viewModel.ratingState == .success {
                    Button("Ок") {
                        isShown.toggle()
                    }
                    .padding([.bottom], 10)
                    .padding([.top], 10)
                } else {
                    Button("Отмена") {
                        isShown.toggle()
                    }.tint(.gray)
                    Divider().frame(height: 40)
                    Button("Выставить") {
                        viewModel.rate(rating: rating)
                    }
                }
            }
            .padding([.bottom], 8)
        }
        .frame(width: 280)
        .background(backgroundColor)
        .cornerRadius(20)
    }
}
