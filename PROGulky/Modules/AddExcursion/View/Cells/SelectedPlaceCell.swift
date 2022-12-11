//
//  SelectedPlaceCell.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 09.12.2022.
//

import UIKit

final class SelectedPlaceCell: UITableViewCell {
    private let sort = UILabel()
    private let title = UILabel()
    private let subtitle = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews(sort, title, subtitle)

        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }

    func set(place: PlaceViewModel) {
        sort.text = place.sort
        title.text = place.title
        subtitle.text = place.subtitle
    }

    // MARK: configs styles

    private func setupUI() {
        backgroundColor = CreateExcursionConstants.TableView.SelectedPlaceCell.backgroundColor
        selectionStyle = UITableViewCell.SelectionStyle.none
        configureSortLabel()
        configureTitleLabel()
        configureSubtitleLabel()
    }

    private func configureSortLabel() {
    }

    private func configureTitleLabel() {
        title.numberOfLines = CreateExcursionConstants.TableView.SelectedPlaceCell.Title.numberOfLines
        title.font = CreateExcursionConstants.TableView.SelectedPlaceCell.Title.font
    }

    private func configureSubtitleLabel() {
        subtitle.numberOfLines = CreateExcursionConstants.TableView.SelectedPlaceCell.Subtitle.numberOfLines
        subtitle.font = CreateExcursionConstants.TableView.SelectedPlaceCell.Subtitle.font
        subtitle.textColor = CreateExcursionConstants.TableView.SelectedPlaceCell.Subtitle.textColor
    }

    // MARK: constraints

    private func setupConstraints() {
        setSortLabelConstraint()
        setTitleLabelConstraints()
        setSubtitleLabelConstraint()
    }

    private func setSortLabelConstraint() {
        sort.translatesAutoresizingMaskIntoConstraints = false
        sort.widthAnchor.constraint(equalToConstant: CreateExcursionConstants.TableView.SelectedPlaceCell.Sort.width).isActive = true
        sort.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sort.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CreateExcursionConstants.TableView.SelectedPlaceCell.Sort.marginLeft).isActive = true
    }

    private func setTitleLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: CreateExcursionConstants.TableView.SelectedPlaceCell.Title.YOffset).isActive = true
        title.leadingAnchor.constraint(equalTo: sort.trailingAnchor, constant: CreateExcursionConstants.TableView.SelectedPlaceCell.Title.marginLeft).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CreateExcursionConstants.Screen.padding).isActive = true
    }

    private func setSubtitleLabelConstraint() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: sort.trailingAnchor, constant: CreateExcursionConstants.TableView.SelectedPlaceCell.Subtitle.marginLeft).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CreateExcursionConstants.Screen.padding).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: CreateExcursionConstants.TableView.SelectedPlaceCell.Subtitle.marginTop).isActive = true
    }
}
