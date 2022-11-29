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

        contentView.addSubviews(excursionImageView,
                                excursionTitleLabel,
                                excursionRatingImage,
                                excursionRatingLabel,
                                excursionParametersLabel)

        setupUI()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: ExcursionsListConstants.ExcursionCell.ContentView.marginTop,
            left: ExcursionsListConstants.ExcursionCell.ContentView.marginLeft,
            bottom: ExcursionsListConstants.ExcursionCell.ContentView.marginBottom,
            right: ExcursionsListConstants.ExcursionCell.ContentView.marginRight
        ))
        contentView.layer.cornerRadius = ExcursionsListConstants.ExcursionCell.cornerRadius
        contentView.backgroundColor = .prog.Dynamic.lightBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }

    func set(excursion: ExcursionViewModel) {
        excursionImageView.image = UIImage(named: excursion.image ?? "placeholderImage")
        excursionTitleLabel.text = excursion.title
        excursionRatingImage.image = UIImage(systemName: ExcursionsListConstants.ExcursionCell.RatingImage.name)?
            .withTintColor(.prog.Dynamic.shadow, renderingMode: .alwaysOriginal)
        excursionRatingLabel.text = String(excursion.rating)
        excursionParametersLabel.text = String(excursion.parameters)
    }

    // MARK: configs styles

    private func setupUI() {
        backgroundColor = ExcursionsListConstants.Screen.backgroundColor

        configureCell()
        configureImageView()
        configureTitleLabel()
        configurRatingImage()
        configureRatingLabel()
        configureParametersLabel()
    }

    private func configureCell() {
        selectionStyle = UITableViewCell.SelectionStyle.none
    }

    private func configureImageView() {
        excursionImageView.layer.cornerRadius = ExcursionsListConstants.ExcursionCell.Image.cornerRadius
        excursionImageView.clipsToBounds = true
    }

    private func configureTitleLabel() {
        excursionTitleLabel.numberOfLines = 1
        excursionTitleLabel.contentMode = .bottom
        excursionTitleLabel.adjustsFontSizeToFitWidth = true
        excursionTitleLabel.font = UIFont.systemFont(ofSize: ExcursionsListConstants.ExcursionCell.Title.fontSize,
                                                     weight: ExcursionsListConstants.ExcursionCell.Title.fontWeight)
    }

    private func configurRatingImage() {
        excursionRatingImage.clipsToBounds = true
    }

    private func configureRatingLabel() {
        excursionRatingLabel.font = UIFont.systemFont(ofSize: ExcursionsListConstants.ExcursionCell.RatingLabel.fontSize,
                                                      weight: ExcursionsListConstants.ExcursionCell.RatingLabel.fontWeight)
        excursionRatingLabel.textColor = ExcursionsListConstants.ExcursionCell.RatingLabel.textColor
    }

    private func configureParametersLabel() {
        excursionParametersLabel.font = UIFont.systemFont(ofSize: ExcursionsListConstants.ExcursionCell.Parameters.fontSize,
                                                          weight: ExcursionsListConstants.ExcursionCell.Parameters.fontWeight)
        excursionParametersLabel.textColor = ExcursionsListConstants.ExcursionCell.Parameters.textColor
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
        excursionImageView.heightAnchor.constraint(equalToConstant: ExcursionsListConstants.ExcursionCell.Image.height).isActive = true
        excursionImageView.widthAnchor.constraint(equalTo: excursionImageView.heightAnchor,
                                                  multiplier: ExcursionsListConstants.ExcursionCell.Image.aspectRatio).isActive = true
    }

    private func setTitleLabelConstraints() {
        excursionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionTitleLabel.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor,
                                                     constant: ExcursionsListConstants.ExcursionCell.contentIndent).isActive = true
        excursionTitleLabel.heightAnchor.constraint(equalToConstant: ExcursionsListConstants.ExcursionCell.Title.heightFrame).isActive = true
        excursionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ExcursionsListConstants.Screen.padding).isActive = true
    }

    private func setRatingImageConstraints() {
        excursionRatingImage.translatesAutoresizingMaskIntoConstraints = false
        excursionRatingImage.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor,
                                                      constant: ExcursionsListConstants.ExcursionCell.contentIndent - 3).isActive = true
        excursionRatingImage.topAnchor.constraint(equalTo: excursionTitleLabel.bottomAnchor,
                                                  constant: ExcursionsListConstants.ExcursionCell.RatingImage.marginTop).isActive = true
        excursionRatingImage.heightAnchor.constraint(equalToConstant: ExcursionsListConstants.ExcursionCell.RatingImage.height).isActive = true
        excursionRatingImage.widthAnchor.constraint(equalTo: excursionRatingImage.heightAnchor,
                                                    multiplier: ExcursionsListConstants.ExcursionCell.RatingImage.aspectRatio).isActive = true
    }

    private func setRatingLabelConstraint() {
        excursionRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionRatingLabel.leadingAnchor.constraint(equalTo: excursionRatingImage.trailingAnchor,
                                                      constant: ExcursionsListConstants.ExcursionCell.RatingLabel.marginLeft).isActive = true
        excursionRatingLabel.topAnchor.constraint(equalTo: excursionTitleLabel.bottomAnchor,
                                                  constant: ExcursionsListConstants.ExcursionCell.RatingLabel.marginTop).isActive = true
    }

    private func setParametersLabelConstraint() {
        excursionParametersLabel.translatesAutoresizingMaskIntoConstraints = false
        excursionParametersLabel.leadingAnchor.constraint(equalTo: excursionImageView.trailingAnchor,
                                                          constant: ExcursionsListConstants.ExcursionCell.contentIndent).isActive = true
        excursionParametersLabel.topAnchor.constraint(equalTo: excursionRatingImage.bottomAnchor,
                                                      constant: ExcursionsListConstants.ExcursionCell.Parameters.marginTop).isActive = true
    }
}
