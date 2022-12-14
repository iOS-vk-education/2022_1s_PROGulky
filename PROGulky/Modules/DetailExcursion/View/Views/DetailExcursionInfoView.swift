//
//  ExcursionInfoView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 17.11.2022.
//

import UIKit
import SnapKit

final class DetailExcursionInfoView: UIView {
    // MARK: Private Properties

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

    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)

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
        setupUI()
        setupConstraints()
        button.isHidden = true
    }

    // MARK: Public Methods

    func set(excursion: DetailExcursionInfoViewModel) {
        title.text = excursion.title
        ratingImage.image = DetailExcursionConstants.InfoView.Rating.Image.image
        ratingLabel.text = excursion.rating
        numberOfPlacesLabel.text = excursion.numberOfPlaces
        durationLabel.text = excursion.duration
        distanceLabel.text = excursion.distance
    }

    // MARK: Private Methods

    private func setupUI() {
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
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.Title.marginTop)
            make.centerX.equalToSuperview()
        }
    }

    private func setRatingImageConstraint() {
        ratingImage.snp.makeConstraints { make in
            make.trailing.equalTo(ratingLabel.snp.leading)
                .offset(DetailExcursionConstants.InfoView.Rating.Image.marginRight)
            make.top.equalTo(title.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.Rating.Image.marginTop)
            make.height.equalTo(DetailExcursionConstants.InfoView.Rating.Image.height)
            make.width.equalTo(ratingImage.snp.height)
                .multipliedBy(DetailExcursionConstants.InfoView.Rating.Image.aspectRatio)
        }
    }

    private func setRatingLabelConstraint() {
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.Rating.Label.marginTop)
            make.centerX.equalToSuperview()
        }
    }

    private func setHorizontalLineConstraint() {
        horizontalLine.snp.makeConstraints { make in
            make.leading.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.HorizontalLine.marginLeft)
            make.trailing.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.HorizontalLine.marginRight)
            make.height.equalTo(DetailExcursionConstants.InfoView.HorizontalLine.height)
            make.top.equalTo(ratingImage.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.HorizontalLine.marginTop)
        }
    }

    private func setNumberOfPlacesLabelConstraint() {
        numberOfPlacesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.ParameterItem.marginLeft)
            make.top.equalTo(horizontalLine.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.ParameterItem.marginTop)
            make.height.equalTo(DetailExcursionConstants.InfoView.ParameterItem.height)
            make.width.equalTo(DetailExcursionConstants.InfoView.ParameterItem.width)
        }
    }

    private func setDurationLabelConstraint() {
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.ParameterItem.marginTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(DetailExcursionConstants.InfoView.ParameterItem.height)
            make.width.equalTo(DetailExcursionConstants.InfoView.ParameterItem.width)
        }
    }

    private func setDistanceLabelConstraint() {
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.ParameterItem.marginTop)
            make.trailing.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.ParameterItem.marginRight)
            make.height.equalTo(DetailExcursionConstants.InfoView.ParameterItem.height)
            make.width.equalTo(DetailExcursionConstants.InfoView.ParameterItem.width)
        }
    }

    private func setButtonConstraint() {
        button.snp.makeConstraints { make in
            make.top.equalTo(durationLabel.snp.bottom)
                .offset(DetailExcursionConstants.InfoView.Button.marginTop)
            make.leading.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.Button.marginLeft)
            make.trailing.equalToSuperview()
                .offset(DetailExcursionConstants.InfoView.Button.marginRight)
            make.height.equalTo(DetailExcursionConstants.InfoView.Button.height)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
