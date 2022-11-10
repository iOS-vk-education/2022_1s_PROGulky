//
//  ExcursionsCell.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 06.11.2022.
//

import UIKit

class ExcursionCell: UITableViewCell {
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

    func set(excursion: Excursion) {
        excursionImageView.image = excursion.image
        excursionTitleLabel.text = excursion.title
        excursionRatingImage.image = UIImage(named: Constants.ExcursionCell.ratingImage)
        excursionRatingLabel.text = String(excursion.rating)
        excursionParametersLabel.text = String(excursion.parameters)
    }

    // MARK: configs styles

    private func setupUI() {
        configureImageView()
        configureTitleLabel()
        configurRatingImage()
        configureRatingLabel()
        configureParametersLabel()
    }

    private func configureImageView() {
        excursionImageView.layer.cornerRadius = Constants.ExcursionCell.imageCornerRadius
        excursionImageView.clipsToBounds = true
    }

    private func configureTitleLabel() {
        excursionTitleLabel.numberOfLines = 1
        excursionTitleLabel.contentMode = .bottom
        excursionTitleLabel.adjustsFontSizeToFitWidth = true
        excursionTitleLabel.font = UIFont.systemFont(ofSize: Constants.ExcursionCell.titleFontSize, weight: Constants.ExcursionCell.titleFontWeight)
    }

    private func configurRatingImage() {
        excursionRatingImage.clipsToBounds = true
    }

    private func configureRatingLabel() {
        excursionRatingLabel.font = UIFont.systemFont(ofSize: Constants.ExcursionCell.ratingFontSize, weight: Constants.ExcursionCell.ratingFontWeight)
        excursionRatingLabel.textColor = Constants.ExcursionCell.ratingTextColor
    }

    private func configureParametersLabel() {
        excursionParametersLabel.font = UIFont.systemFont(ofSize: Constants.ExcursionCell.parametersFontSize, weight: Constants.ExcursionCell.parametersFontWeight)
        excursionParametersLabel.textColor = Constants.ExcursionCell.parametersTextColor
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
        excursionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ExcursionsListScreen.padding).isActive = true
        excursionImageView.heightAnchor.constraint(equalToConstant: Constants.ExcursionCell.imageHeight).isActive = true
        excursionImageView.widthAnchor.constraint(equalTo: excursionImageView.heightAnchor, multiplier: Constants.ExcursionCell.imageAspectRatio).isActive = true
    }

    private func setTitleLabelConstraints() {
        excursionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionTitleLabel.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor, constant: Constants.ExcursionCell.contentIndent).isActive = true
        excursionTitleLabel.heightAnchor.constraint(equalToConstant: Constants.ExcursionCell.heightTitleFrame).isActive = true
        excursionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.ExcursionsListScreen.padding).isActive = true
    }

    private func setRatingImageConstraints() {
        excursionRatingImage.translatesAutoresizingMaskIntoConstraints = false
        excursionRatingImage.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor, constant: Constants.ExcursionCell.contentIndent - 8).isActive = true
        excursionRatingImage.topAnchor.constraint(equalTo: excursionTitleLabel.bottomAnchor).isActive = true
    }

    private func setRatingLabelConstraint() {
        excursionRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionRatingLabel.leadingAnchor.constraint(equalTo: excursionRatingImage.trailingAnchor).isActive = true
        excursionRatingLabel.topAnchor.constraint(equalTo: excursionTitleLabel.bottomAnchor,
                                                  constant: Constants.ExcursionCell.raitingImageIndentFromTitle).isActive = true
    }

    private func setParametersLabelConstraint() {
        excursionParametersLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionParametersLabel.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor, constant: Constants.ExcursionCell.contentIndent).isActive = true
        excursionParametersLabel.topAnchor.constraint(equalTo: excursionRatingImage.bottomAnchor).isActive = true
    }
}
