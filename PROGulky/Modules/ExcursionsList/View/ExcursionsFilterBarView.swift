//
//  ExcursionsFilterBarView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 08.11.2022.
//

import UIKit

final class ExcursionsFilterBarView: UIView {
    // Кнопка с выбранным городом
    private let selectedCityButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = ExcursionsListConstants.SelectedCityButton.title
        configuration.image = UIImage(systemName: ExcursionsListConstants.SelectedCityButton.icon)
        configuration.titleAlignment = .trailing
        configuration.imagePlacement = .leading
        configuration.imagePadding = ExcursionsListConstants.SelectedCityButton.padding
        button.configuration = configuration
        return button
    }()

    // Кнопка с фильтром
    private let filterButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = ExcursionsListConstants.FilterButton.title
        configuration.baseForegroundColor = .gray // Кнопка серая, потому что неактивная
        configuration.image = UIImage(systemName: ExcursionsListConstants.FilterButton.icon)
        configuration.titleAlignment = .leading
        configuration.imagePlacement = .trailing
        configuration.imagePadding = ExcursionsListConstants.FilterButton.padding
        button.configuration = configuration
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(selectedCityButton, filterButton)

        configureSelectedCityButtonConstraints()
        configureFilterButtonConstraints()
    }

    private func configureSelectedCityButtonConstraints() {
        selectedCityButton.translatesAutoresizingMaskIntoConstraints = false
        selectedCityButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedCityButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ExcursionsListConstants.Screen.padding).isActive = true
    }

    private func configureFilterButtonConstraints() {
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ExcursionsListConstants.Screen.padding).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
