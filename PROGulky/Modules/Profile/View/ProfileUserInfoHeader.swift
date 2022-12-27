//
//  ProfileUserInfoHeader.swift
//  PROGulky
//
//  Created by Сергей Киселев on 23.10.2022.
//

import UIKit

final class UserInfoHeader: UIView {
    struct DisplayData {
        let username: String
        let status: String
    }

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "person.crop.circle")?.withTintColor(.prog.Dynamic.primary, renderingMode: .alwaysOriginal)

        return iv
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: UserKeys.name.rawValue)
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstantsProfile.titleUserStatus + " - " + (UserDefaults.standard.string(forKey: UserKeys.role.rawValue) ?? "")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .prog.Dynamic.textGray
        return label
    }()

    private enum Constants {
        static let offset: CGFloat = 10
        static let imagesSize: CGFloat = 60
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(profileImageView,
                    usernameLabel,
                    statusLabel)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.imagesSize)
            make.height.equalTo(Constants.imagesSize + 4)
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ displayData: DisplayData) {
        usernameLabel.text = displayData.username
        statusLabel.text = displayData.status
    }
}
