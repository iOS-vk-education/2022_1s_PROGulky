//
//  ProfileUserAnotherView.swift
//  PROGulky
//
//  Created by Сергей Киселев on 04.11.2022.
//

import UIKit

final class ProfileUserAnotherView: UIView {
    // MARK: - add accountSettingsLabel

    private let accountSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleOthers
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = CustomColor.blackColor
        return label
    }()

    // MARK: - add contactUs

    private let contactUsLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleContactUs
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let contactUsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-Edit")
        return iv
    }()

    private let contactUsBtn: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - add privacyPolicy

    private let privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titlePrivacyPolicy
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let privacyPolicyImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-Privacy")
        return iv
    }()

    private let privacyPolicyBtn: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - add signOut

    private let signOutLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.titleSignOut
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private let signOutImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Icon-Setting")
        return iv
    }()

    private let signOutBtn: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    @objc private func buttonAction(sender: UIButton!) {
        switch sender.tag {
        case 1:
            print("Button contact us tapped")
        case 2:
            print("Button privacy policy tapped")
        case 3:
            print("Button sign out tapped")
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

        let imagesSize: CGFloat = 20

        // MARK: - add accountSettingsLabel

        addSubview(accountSettingsLabel)
        accountSettingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.TitleLabel.topOffset)
            make.leading.equalToSuperview().offset(Constants.TitleLabel.offset)
        }

        // MARK: - add contactUs

        addSubview(contactUsImageView)
        contactUsImageView.snp.makeConstraints { make in
            make.top.equalTo(accountSettingsLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(contactUsLabel)
        contactUsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contactUsImageView.snp.centerY)
            make.leading.equalTo(contactUsImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(contactUsBtn)
        contactUsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(contactUsImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        // MARK: - add privacyPolicy

        addSubview(privacyPolicyImageView)
        privacyPolicyImageView.snp.makeConstraints { make in
            make.top.equalTo(contactUsLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(privacyPolicyLabel)
        privacyPolicyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(privacyPolicyImageView.snp.centerY)
            make.leading.equalTo(privacyPolicyImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(privacyPolicyBtn)
        privacyPolicyBtn.snp.makeConstraints { make in
            make.centerY.equalTo(privacyPolicyImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        // MARK: - add signOut

        addSubview(signOutImageView)
        signOutImageView.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyLabel).offset(Constants.ImageView.topOffset)
            make.leading.equalTo(accountSettingsLabel)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }

        addSubview(signOutLabel)
        signOutLabel.snp.makeConstraints { make in
            make.centerY.equalTo(signOutImageView.snp.centerY)
            make.leading.equalTo(signOutImageView.snp.trailing).offset(Constants.Label.offset)
        }

        addSubview(signOutBtn)
        signOutBtn.snp.makeConstraints { make in
            make.centerY.equalTo(signOutImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.Button.offset)
            make.width.equalTo(Constants.ImageView.imagesSize)
            make.height.equalTo(Constants.ImageView.imagesSize)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // будет нужно для переиспользования вьюх
    struct DisplayData {
        let text1: String
        let text2: String
    }

    func configure(data: DisplayData) {
        // настройка тайтлов
    }
}
