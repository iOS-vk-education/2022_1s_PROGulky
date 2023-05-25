//
//  RatingView.swift
//  PROGulky
//
//  Created by Иван Тазенков on 25.05.2023.
//

import SwiftUI
struct RatingView: View {
    @ObservedObject var viewModel: RatingViewModel
    @State var rating: Int = 0
    @Binding var isShown: Bool
    @Environment(\.colorScheme) var colorScheme

    var maximumRating = 5
    var image = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    private var backgroundColor: Color {
        colorScheme == .light ? .backgroundL : .backgroundD
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.ratingState.message)
                .padding([.top], 12)
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
                } else {
                    Button("Отмена") {
                        isShown.toggle()
                    }.tint(.gray)
                    Divider().frame(height: 20)
                    Button("Выставить") {
                        viewModel.rate(rating: rating)
                    }
                }
            }
            .padding([.bottom], 8)
        }
        .frame(width: 250)
        .background(backgroundColor)
        .cornerRadius(20)
    }
}
