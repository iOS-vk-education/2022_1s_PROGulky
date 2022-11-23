//
//  ProfileUserInfoHeader.swift
//  PROGulky
//
//  Created by Сергей Киселев on 23.10.2022.
//

import UIKit

final class UserInfoHeader: UIView {
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Avatar")

        return iv
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstantsProfile.titleUserName
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstantsProfile.titleUserStatus
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = CustomColor.greyColor
        return label
    }()

    private enum Constants {
        static let offset: CGFloat = 20
        static let imagesSize: CGFloat = 60
        static let offsetUName: CGFloat = -10
        static let offsetAnchorUName: CGFloat = 20
        static let offsetUStatus: CGFloat = 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.offset)
            make.width.equalTo(Constants.imagesSize)
            make.height.equalTo(Constants.imagesSize + 4)
        }
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).offset(Constants.offsetUName)
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.offsetAnchorUName)
        }
        addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).offset(Constants.offsetUStatus)
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.offsetAnchorUName)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
