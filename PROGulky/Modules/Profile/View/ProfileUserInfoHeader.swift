//
//  ProfileUserInfoHeader.swift
//  PROGulky
//
//  Created by Сергей Киселев on 23.10.2022.
//

import UIKit

class UserInfoHeader: UIView {
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Avatar")

        return iv
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя пользователя"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "user status"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let userStatusBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Стать \n экскурсоводом", for: .normal)
        button.setTitleColor(UIColor(hexString: "#7B6F72"), for: .normal)
        button.layer.cornerRadius = 16
        button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#92FDB0")
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let profileImageDimension: CGFloat = 60

        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2

        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true

        addSubview(statusLabel)
        statusLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true

        addSubview(userStatusBtn)
        userStatusBtn.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0).isActive = true
        userStatusBtn.leftAnchor.constraint(equalTo: usernameLabel.rightAnchor, constant: 20).isActive = true
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
