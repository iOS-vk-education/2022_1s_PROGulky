//
//  ExcursionInfoView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.11.2022.
//

import UIKit

final class DetailExcursionInfoView: UIView {
    // Заголовок
    private let title: UILabel = {
        let label = UILabel()
        label.font = DetailExcursionConstants.InfoView.Title.font
        return label
    }()

    private let ratingImage: UIImageView = {
        let image = UIImageView()
        let img = DetailExcursionConstants.InfoView.Rating.Image.image
        image.image = DetailExcursionConstants.InfoView.Rating.Image.image
        return image
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let horizontalLine: UIView = {
        let line = UIView(frame: CGRect())
        line.backgroundColor = DetailExcursionConstants.InfoView.HorizontalLine.color
        return line
    }()

    private let numberOfPlacesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = DetailExcursionConstants.InfoView.ParameterItem.numberOfLines
        label.textAlignment = .center
        label.textColor = DetailExcursionConstants.InfoView.ParameterItem.textColor
        return label
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = DetailExcursionConstants.InfoView.ParameterItem.numberOfLines
        label.textAlignment = .center
        label.textColor = DetailExcursionConstants.InfoView.ParameterItem.textColor
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = DetailExcursionConstants.InfoView.ParameterItem.numberOfLines
        label.textAlignment = .center
        label.textColor = DetailExcursionConstants.InfoView.ParameterItem.textColor
        return label
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = DetailExcursionConstants.InfoView.Button.color
        button.layer.cornerRadius = DetailExcursionConstants.InfoView.Button.cornerRadius
        button.setTitle(DetailExcursionConstants.InfoView.Button.text, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(
            title,
            ratingImage,
            ratingLabel,
            horizontalLine,
            numberOfPlacesLabel,
            durationLabel,
            distanceLabel,
            button
        )

        setupConstraints()
    }

    func set(excursion: DetailExcursionInfoViewModel) {
        title.text = excursion.title
        ratingImage.image = UIImage(named: ExcursionsListConstants.ExcursionCell.ratingImage)
        ratingLabel.text = excursion.rating
        numberOfPlacesLabel.text = excursion.numberOfPlaces
        durationLabel.text = excursion.duration
        distanceLabel.text = excursion.distance
    }

    private func setupConstraints() {
        setTitleConstraint()
        setRatingImageConstraint()
        setRatingLabelConstraint()
        setHorizontalLineConstraint()
        setNumberOfPlacesLabelConstraint()
        setDurationLabelConstraint()
        setDistanceLabelConstraint()
        setButtonConstraint()
    }

    private func setTitleConstraint() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: topAnchor, constant: DetailExcursionConstants.InfoView.Title.marginTop).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    // TODO: - change size, не отображается картинка

    private func setRatingImageConstraint() {
        ratingImage.translatesAutoresizingMaskIntoConstraints = false
        ratingImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: DetailExcursionConstants.InfoView.Rating.Image.XOffset).isActive = true
        ratingImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: DetailExcursionConstants.InfoView.Rating.Image.marginTop).isActive = true
    }

    private func setRatingLabelConstraint() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.leadingAnchor.constraint(equalTo: ratingImage.trailingAnchor).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: DetailExcursionConstants.InfoView.Rating.Label.marginTop).isActive = true
    }

    private func setHorizontalLineConstraint() {
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailExcursionConstants.InfoView.HorizontalLine.marginLeft).isActive = true
        horizontalLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: DetailExcursionConstants.InfoView.HorizontalLine.marginRight).isActive = true
        horizontalLine.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.HorizontalLine.height).isActive = true
        horizontalLine.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: DetailExcursionConstants.InfoView.HorizontalLine.marginTop).isActive = true
    }

    private func setNumberOfPlacesLabelConstraint() {
        numberOfPlacesLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfPlacesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailExcursionConstants.InfoView.ParameterItem.marginLeft).isActive = true
        numberOfPlacesLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,
                                                 constant: DetailExcursionConstants.InfoView.ParameterItem.marginTop).isActive = true
        numberOfPlacesLabel.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.ParameterItem.height).isActive = true
        numberOfPlacesLabel.widthAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.ParameterItem.width).isActive = true
    }

    private func setDurationLabelConstraint() {
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: DetailExcursionConstants.InfoView.ParameterItem.marginTop).isActive = true
        durationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.ParameterItem.height).isActive = true
        durationLabel.widthAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.ParameterItem.width).isActive = true
    }

    private func setDistanceLabelConstraint() {
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: DetailExcursionConstants.InfoView.ParameterItem.marginTop).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: DetailExcursionConstants.InfoView.ParameterItem.marginRight).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.ParameterItem.height).isActive = true
        distanceLabel.widthAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.ParameterItem.width).isActive = true
    }

    private func setButtonConstraint() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: DetailExcursionConstants.InfoView.Button.marginTop).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailExcursionConstants.InfoView.Button.marginLeft).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: DetailExcursionConstants.InfoView.Button.marginRight).isActive = true
        button.heightAnchor.constraint(equalToConstant: DetailExcursionConstants.InfoView.Button.height).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
