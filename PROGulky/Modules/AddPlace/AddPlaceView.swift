//
//  AddPlaceView.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - AddPlaceView

struct AddPlaceView: View {
    @ObservedObject var viewModel: AddPlaceViewModel
    @State private var text = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
        NavigationStack {
            searchBar
                .padding(.horizontal)
                .navigationBarHidden(false)
            List {
                ForEach(viewModel.places.filter { place in
                    text == "" || place.title.lowercased().contains(text
                        .lowercased()
                        .trimmingCharacters(in: .whitespacesAndNewlines))

                }) { place in
                    HStack {
                        Text(place.title)
                        Spacer()

                        if viewModel.selectedPlaces.contains(where: { pl in
                            pl.id == place.id
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .onTapGesture {
                        viewModel.selectPlace(place: place)
                    }
                }
            }
        }
        .onDisappear {
            viewModel.viewWillDisappear()
        }
    }

    @ViewBuilder
    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Поиск", text: $text, onEditingChanged: { isEditing in
                    self.showCancelButton = isEditing
                }, onCommit: {
                }).foregroundColor(.primary)

                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill").opacity(text == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if showCancelButton {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.text = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
    }
}

// MARK: - DetailPlaceView

struct DetailPlaceView: View {
    @State var place: Place

    var body: some View {
        List {
            WebImage(url:
                URL(string: "\(AddExcursionConstants.Api.imageURL)/\(place.image ?? "")"))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .indicator(.activity)
                .scaledToFill()
            Section("Название") {
                Text(place.title)
            }
            Section("Город") {
                Text(place.city)
            }
            Section("Адрес") {
                Text(place.address)
            }
            Section("Описание") {
                Text(place.description)
            }
        }
    }
}
