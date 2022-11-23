//
//  ExcursionCell.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 06.11.2022.
//

import UIKit

final class ExcursionCell: UITableViewCell {
    private let excursionImageView = UIImageView()
    private let excursionTitleLabel = VerticalAlignedLabel()
    private let excursionRatingImage = UIImageView()
    private let excursionRatingLabel = UILabel()
    private var excursionParametersLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews(excursionImageView,
                    excursionTitleLabel,
                    excursionRatingImage,
                    excursionRatingLabel,
                    excursionParametersLabel)

        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }

    func set(excursion: ExcursionViewModel) {
        excursionImageView.image = UIImage(named: excursion.image ?? "placeholderImage")
        excursionTitleLabel.text = excursion.title
        excursionRatingImage.image = UIImage(named: ExcursionsListConstants.ExcursionCell.ratingImage)
        excursionRatingLabel.text = String(excursion.rating)
        excursionParametersLabel.text = String(excursion.parameters)
    }

    // MARK: configs styles

    private func setupUI() {
        selectionStyle = UITableViewCell.SelectionStyle.none
        configureImageView()
        configureTitleLabel()
        configurRatingImage()
        configureRatingLabel()
        configureParametersLabel()
    }

    private func configureImageView() {
        excursionImageView.layer.cornerRadius = ExcursionsListConstants.ExcursionCell.imageCornerRadius
        excursionImageView.clipsToBounds = true
    }

    private func configureTitleLabel() {
        excursionTitleLabel.numberOfLines = 1
        excursionTitleLabel.contentMode = .bottom
        excursionTitleLabel.adjustsFontSizeToFitWidth = true
        excursionTitleLabel.font = UIFont.systemFont(ofSize: ExcursionsListConstants.ExcursionCell.titleFontSize,
                                                     weight: ExcursionsListConstants.ExcursionCell.titleFontWeight)
    }

    private func configurRatingImage() {
        excursionRatingImage.clipsToBounds = true
    }

    private func configureRatingLabel() {
        excursionRatingLabel.font = UIFont.systemFont(ofSize: ExcursionsListConstants.ExcursionCell.ratingFontSize,
                                                      weight: ExcursionsListConstants.ExcursionCell.ratingFontWeight)
        excursionRatingLabel.textColor = ExcursionsListConstants.ExcursionCell.ratingTextColor
    }

    private func configureParametersLabel() {
        excursionParametersLabel.font = UIFont.systemFont(ofSize: ExcursionsListConstants.ExcursionCell.parametersFontSize,
                                                          weight: ExcursionsListConstants.ExcursionCell.parametersFontWeight)
        excursionParametersLabel.textColor = ExcursionsListConstants.ExcursionCell.parametersTextColor
    }

    // MARK: constraints

    private func setupConstraints() {
        setImageConstraints()
        setTitleLabelConstraints()
        setRatingImageConstraints()
        setRatingLabelConstraint()
        setParametersLabelConstraint()
    }

    private func setImageConstraints() {
        excursionImageView.translatesAutoresizingMaskIntoConstraints = false
        excursionImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        excursionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ExcursionsListConstants.Screen.padding).isActive = true
        excursionImageView.heightAnchor.constraint(equalToConstant: ExcursionsListConstants.ExcursionCell.imageHeight).isActive = true
        excursionImageView.widthAnchor.constraint(equalTo: excursionImageView.heightAnchor,
                                                  multiplier: ExcursionsListConstants.ExcursionCell.imageAspectRatio).isActive = true
    }

    private func setTitleLabelConstraints() {
        excursionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionTitleLabel.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor,
                                                     constant: ExcursionsListConstants.ExcursionCell.contentIndent).isActive = true
        excursionTitleLabel.heightAnchor.constraint(equalToConstant: ExcursionsListConstants.ExcursionCell.heightTitleFrame).isActive = true
        excursionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ExcursionsListConstants.Screen.padding).isActive = true
    }

    private func setRatingImageConstraints() {
        excursionRatingImage.translatesAutoresizingMaskIntoConstraints = false
        excursionRatingImage.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor,
                                                      constant: ExcursionsListConstants.ExcursionCell.contentIndent - 8).isActive = true
        excursionRatingImage.topAnchor.constraint(equalTo: excursionTitleLabel.bottomAnchor).isActive = true
    }

    private func setRatingLabelConstraint() {
        excursionRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionRatingLabel.leadingAnchor.constraint(equalTo: excursionRatingImage.trailingAnchor).isActive = true
        excursionRatingLabel.topAnchor.constraint(equalTo: excursionTitleLabel.bottomAnchor,
                                                  constant: ExcursionsListConstants.ExcursionCell.raitingImageIndentFromTitle).isActive = true
    }

    private func setParametersLabelConstraint() {
        excursionParametersLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionParametersLabel.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor,
                                                          constant: ExcursionsListConstants.ExcursionCell.contentIndent).isActive = true
        excursionParametersLabel.topAnchor.constraint(equalTo: excursionRatingImage.bottomAnchor).isActive = true
    }
}
