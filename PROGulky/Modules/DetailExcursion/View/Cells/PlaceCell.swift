//
//  PlaceCell.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 18.11.2022.
//

import UIKit

final class PlaceCell: UITableViewCell {
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
        selectionStyle = UITableViewCell.SelectionStyle.none
        configureSortLabel()
        configureTitleLabel()
        configureSubtitleLabel()
    }

    private func configureSortLabel() {
    }

    private func configureTitleLabel() {
        title.numberOfLines = DetailExcursionConstants.TableView.PlaceCell.Title.numberOfLines
        title.font = DetailExcursionConstants.TableView.PlaceCell.Title.font
    }

    private func configureSubtitleLabel() {
        subtitle.numberOfLines = DetailExcursionConstants.TableView.PlaceCell.Subtitle.numberOfLines
        subtitle.font = DetailExcursionConstants.TableView.PlaceCell.Subtitle.font
        subtitle.textColor = DetailExcursionConstants.TableView.PlaceCell.Subtitle.textColor
    }

    // MARK: constraints

    private func setupConstraints() {
        setSortLabelConstraint()
        setTitleLabelConstraints()
        setSubtitleLabelConstraint()
    }

    private func setSortLabelConstraint() {
        sort.translatesAutoresizingMaskIntoConstraints = false
        sort.widthAnchor.constraint(equalToConstant: DetailExcursionConstants.TableView.PlaceCell.Sort.width).isActive = true
        sort.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sort.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailExcursionConstants.TableView.PlaceCell.Sort.marginLeft).isActive = true
    }

    private func setTitleLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: DetailExcursionConstants.TableView.PlaceCell.Title.YOffset).isActive = true
        title.leadingAnchor.constraint(equalTo: sort.trailingAnchor, constant: DetailExcursionConstants.TableView.PlaceCell.Title.marginLeft).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DetailExcursionConstants.Screen.padding).isActive = true
    }

    private func setSubtitleLabelConstraint() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: sort.trailingAnchor, constant: DetailExcursionConstants.TableView.PlaceCell.Subtitle.marginLeft).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DetailExcursionConstants.Screen.padding).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: DetailExcursionConstants.TableView.PlaceCell.Subtitle.marginTop).isActive = true
    }
}
