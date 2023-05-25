//
//  DetailExcursionViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI
import MapKit
import SkeletonUI

// MARK: - DetailExcursionView

struct DetailExcursionView: View {
    private enum Constants {
        static let imageURL = "\(baseURL)/images/excursions"
        static let ratingImageName = "star.fill"
        static let description = "Описание"
        static let buttonImageName = "heart"
        static let backButtonImageName = "chevron.left"
        static let placesTitle = "Точки экскурсии"
        static let ratePlease = "Оцените экскурсию"
    }

    @ObservedObject var viewModel: DetailExcursionViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isMapActive = false
    @State var showsAlert = false
    @State var rateText = Constants.ratePlease

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
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    imageWithLikeButton
                    placesInfoView
                        .padding([.bottom], 16)
                    placesView
                        .skeleton(with: viewModel.loading)
                        .multiline(lines: 3, scales: [1: 5], spacing: 20)
                        .padding([.bottom], 20)
                    descriptionView
                        .padding([.bottom], 24)
                    NavigationLink(isActive: $isMapActive) {
                        MapModuleView(excursion: viewModel.guardedExcursion)
                            .ignoresSafeArea()
                            .navigationBarBackButtonHidden()
                            .navigationBarItems(leading: backButton)
                    } label: {
                        RepresentedMapView(polyline: viewModel.polyline, points: viewModel.points)
                            .frame(width: 350, height: 350)
                            .padding(.bottom, 20)
                            .skeleton(with: viewModel.loading, size: CGSize(width: 350, height: 350))
                    }
                    HStack {
                        Spacer()
                        rate
                            .skeleton(with: viewModel.loading)
                    }
                }
                .padding(.horizontal, 16)
            }
            .disabled(showsAlert ? true : false)
            .blur(radius: showsAlert ? 5 : 0)
            .animation(.default, value: showsAlert)

            RatingView(viewModel: RatingViewModel(excursionId: viewModel.excursion.id),
                       isShown: $showsAlert)
                .opacity(showsAlert ? 1 : 0)
                .animation(.default, value: showsAlert)
        }
        .edgesIgnoringSafeArea(.top)
        .background(backgroundColor)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .onAppear(perform: viewModel.refresh)
    }

    @ViewBuilder
    private var backButton: some View {
        Button {
            isMapActive ? isMapActive.toggle() : presentationMode.wrappedValue.dismiss()
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
        .padding(.horizontal, -16)
        .skeleton(with: viewModel.loading)
        .shape(type: .rectangle)
        .scaledToFill()

        HStack {
            Spacer()
            Button {
                if !viewModel.loading {
                    viewModel.didiLikeButtonTapped()
                }
            } label: {
                Image(systemName: Constants.buttonImageName)
                    .resizable()
                    .frame(width: 24, height: 22)
                    .foregroundColor(.red)
                    .symbolVariant(viewModel.excursion.isLiked ? .fill : .none)
                    .skeleton(with: viewModel.loading)
                    .shape(type: .circle)
            }
            .frame(width: 52, height: 52)
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
            }
            .padding(.bottom, 16)
            .skeleton(with: viewModel.loading)

            divider

            HStack(alignment: .center, spacing: 80) {
                Text(viewModel.excursion.infoViewModel.numberOfPlaces)
                    .skeleton(with: viewModel.loading)
                Text(viewModel.excursion.infoViewModel.distance)
                    .skeleton(with: viewModel.loading)
                Text(viewModel.excursion.infoViewModel.duration)
                    .skeleton(with: viewModel.loading)
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
                .skeleton(with: viewModel.loading)
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
                .skeleton(with: viewModel.loading)
            Spacer()
        }
        Text(viewModel.excursion.description)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .font(.callout.weight(.light))
            .skeleton(with: viewModel.loading)
            .multiline(lines: 6)
    }

    private var divider: some View {
        Divider().overlay(.black)
    }

    private var rate: some View {
        Button(Constants.ratePlease) {
            showsAlert.toggle()
        }
        .buttonStyle(.bordered)
        .padding([.bottom], 12)
    }
}
