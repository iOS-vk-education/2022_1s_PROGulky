//
//  DetailExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI
import MapKit

// MARK: - DetailExcursionView

struct DetailExcursionView: View {
    private enum Constants {
        static let imageURL = "\(baseURL)/images/excursions"
        static let ratingImageName = "star.fill"
        static let description = "Описание"
        static let buttonImageName = "heart"
        static let backButtonImageName = "chevron.left"
        static let placesTitle = "Точки экскурсии"
    }

    @ObservedObject var viewModel: DetailExcursionViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(viewModel: DetailExcursionViewModel) {
        self.viewModel = viewModel
    }

    private var backgroundColor: Color {
        colorScheme == .light ? .backgroundL : .backgroundD
    }

    private var shadowColor: Color {
        switch colorScheme {
        case .dark: return .shadowD
        case .light: return .shadowL
        @unknown default:
            return .shadowL
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                imageWithLikeButton
                placesInfoView.padding([.bottom], 16)
                placesView.padding([.bottom], 20)
                descriptionView.padding([.bottom], 24)
                VStack(alignment: .center) {
                    RepresentedMapView(polyline: viewModel.polyline, points: viewModel.points)
                        .frame(width: 350, height: 350)
                        .padding(.bottom, 24)
                }
            }
            .padding(.horizontal, 16)
        }
        .edgesIgnoringSafeArea(.top)
        .background(backgroundColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

    @ViewBuilder
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: Constants.backButtonImageName)
                .symbolVariant(.circle.fill)
                .aspectRatio(contentMode: .fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .black)
                .fontWeight(.bold)
        }
    }

    @ViewBuilder
    private var imageWithLikeButton: some View {
        WebImage(
            url: URL(string: "\(Constants.imageURL)/\(viewModel.excursion.image)")
        )
        .resizable()
        .placeholder(Image(systemName: "photo"))
        .indicator(.activity)
        .scaledToFill()
        .padding(.horizontal, -16)

        HStack {
            Spacer()
            Button {
                print("Pressed!")
            } label: {
                Image(systemName: Constants.buttonImageName)
                    .resizable()
                    .frame(width: 24, height: 22)
                    .foregroundColor(.red)
                    .symbolVariant(viewModel.excursion.isLiked ? .fill : .none)
            }
            .frame(width: 36, height: 36)
            .background(backgroundColor)
            .clipShape(Circle())
            .shadow(color: shadowColor, radius: 5, x: 1, y: 1)
            .padding(.trailing, 20)
            .padding(.top, -24)
        }
    }

    @ViewBuilder
    private var placesInfoView: some View {
        LazyVStack {
            HStack {
                Text(viewModel.excursion.infoViewModel.title)
                    .font(.title2.weight(.heavy))
                Image(systemName: Constants.ratingImageName)
                    .foregroundColor(.yellow)
                Text(viewModel.excursion.infoViewModel.rating)
                    .font(.body.weight(.medium))
                Spacer()
            }.padding(.bottom, 16)
            divider
            HStack(alignment: .center, spacing: 80) {
                Text(viewModel.excursion.infoViewModel.numberOfPlaces)
                Text(viewModel.excursion.infoViewModel.distance)
                Text(viewModel.excursion.infoViewModel.duration)
            }
            .font(.callout)
            divider
        }
    }

    @ViewBuilder
    private var placesView: some View {
        VStack(alignment: .leading) {
            Text(Constants.placesTitle)
                .font(.headline)
                .bold()
                .padding(.bottom, 16)
            divider
            ForEach(viewModel.excursion.places) { place in
                HStack {
                    Text(place.sort.formatted())
                        .font(.callout.weight(.medium))
                        .padding(.trailing, 16)

                    VStack(alignment: .leading) {
                        Text(place.title)
                            .font(.callout.weight(.medium))
                            .bold()
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        Text(place.subtitle)
                            .font(.subheadline.weight(.light))
                    }
                }.padding([.vertical], 8)
                divider
            }
        }
        .onTapGesture {
            print("place select")
        }
    }

    @ViewBuilder
    private var descriptionView: some View {
        HStack {
            Text(Constants.description)
                .font(.headline)
                .bold()
            Spacer()
        }
        Text(viewModel.excursion.description)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .font(.callout.weight(.light))
    }

    private var divider: some View {
        Divider().overlay(.black)
    }
}
