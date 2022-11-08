//
//  ProfileUserAccountView.swift
//  PROGulky
//
//  Created by Сергей Киселев on 03.11.2022.
//

import UIKit

final class ProfileUserAccountView: UIView {
    // MARK: - add accountSettingsLabel

    private let accountSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleAccount
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = CustomColor.blackColor
        return label
    }()

    // MARK: - add personalDataSettings

    private let personalDataSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titlePersonalData
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let personalDataSettingsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-Profile")
        return iv
    }()

    private let personalDataSettingsBtn: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - add achievements

    private let achievementsLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleAchievements
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let achievementsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-Achievement")
        return iv
    }()

    private let achievementsBtn: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - add history

    private let historyLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleHistory
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let historyImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-Activity")
        return iv
    }()

    private let historyBtn: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - add beGuide

    private let beGuideLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleBeGuide
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let beGuideImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-UserBeGuide")
        return iv
    }()

    private let beGuideBtn: UIButton = {
        let button = UIButton()
        button.tag = 4
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    @objc private func buttonAction(sender: UIButton!) {
        switch sender.tag {
        case 1:
            print("Button personal data tapped")
        case 2:
            print("Button achievements tapped")
        case 3:
            print("Button history tapped")
        case 4:
            print("Button be guide tapped")
        default:
            print("Unknown button tapped")
        }
    }

    private enum Constants {
        enum TitleLabel {
            static let topOffset: CGFloat = 20
            static let offset: CGFloat = 16
        }

        enum ImageView {
            static let topOffset: CGFloat = 30
            static let imagesSize: CGFloat = 20
        }

        enum Label {
            static let offset: CGFloat = 20
        }

        enum Button {
            static let offset: CGFloat = -20
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // MARK: - add accountSettingsLabel

        addSubview(accountSettingsLabel)
        accountSettingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.TitleLabel.topOffset)
            make.leading.equalToSuperview().offset(Constants.TitleLabel.offset)
        }

        // MARK: - add personalDataSettings

        addSubview(personalDataSettingsImageView)
        personalDataSettingsImageView.snp.makeConstraints { make in
            make.top.equalTo(accountSettingsLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(personalDataSettingsLabel)
        personalDataSettingsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(personalDataSettingsImageView.snp.centerY)
            make.leading.equalTo(personalDataSettingsImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(personalDataSettingsBtn)
        personalDataSettingsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(personalDataSettingsImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        // MARK: - add achievements

        addSubview(achievementsImageView)
        achievementsImageView.snp.makeConstraints { make in
            make.top.equalTo(personalDataSettingsLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(achievementsLabel)
        achievementsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(achievementsImageView.snp.centerY)
            make.leading.equalTo(achievementsImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(achievementsBtn)
        achievementsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(achievementsImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        // MARK: - add history

        addSubview(historyImageView)
        historyImageView.snp.makeConstraints { make in
            make.top.equalTo(achievementsLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(historyImageView.snp.centerY)
            make.leading.equalTo(historyImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(historyBtn)
        historyBtn.snp.makeConstraints { make in
            make.centerY.equalTo(historyImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        // MARK: - add beGuide

        addSubview(beGuideImageView)
        beGuideImageView.snp.makeConstraints { make in
            make.top.equalTo(historyLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(beGuideLabel)
        beGuideLabel.snp.makeConstraints { make in
            make.centerY.equalTo(beGuideImageView.snp.centerY)
            make.leading.equalTo(beGuideImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(beGuideBtn)
        beGuideBtn.snp.makeConstraints { make in
            make.centerY.equalTo(beGuideImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
