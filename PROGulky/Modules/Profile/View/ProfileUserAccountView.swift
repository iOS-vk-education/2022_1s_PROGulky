//
//  ProfileUserAccountView.swift
//  PROGulky
//
//  Created by Сергей Киселев on 03.11.2022.
//

import UIKit

class ProfileUserAccountView: UIView {
    // MARK: - add accountSettingsLabel

    let accountSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунт"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#1D1617")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - add personalDataSettings

    let personalDataSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let personalDataSettingsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Icon-Profile")
        return iv
    }()

    let personalDataSettingsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - add achievements

    let achievementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Достижения"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let achievementsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Icon-Achievement")
        return iv
    }()

    let achievementsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - add history

    let historyLabel: UILabel = {
        let label = UILabel()
        label.text = "История прогулок"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let historyImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Icon-Activity")
        return iv
    }()

    let historyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }

//    let personalDataSettingsView: UIView = {
//        let view = UIView()
//        return view
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let imagesDimension: CGFloat = 20

        // MARK: - add accountSettingsLabel

        addSubview(accountSettingsLabel)
        accountSettingsLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        accountSettingsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true

        // MARK: - add personalDataSettings

        addSubview(personalDataSettingsImageView)
        personalDataSettingsImageView.centerYAnchor.constraint(equalTo: accountSettingsLabel.bottomAnchor, constant: 25).isActive = true
        personalDataSettingsImageView.leftAnchor.constraint(equalTo: accountSettingsLabel.leftAnchor).isActive = true
        personalDataSettingsImageView.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        personalDataSettingsImageView.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        personalDataSettingsImageView.layer.cornerRadius = imagesDimension / 2

        addSubview(personalDataSettingsLabel)
        personalDataSettingsLabel.centerYAnchor.constraint(equalTo: personalDataSettingsImageView.centerYAnchor).isActive = true
        personalDataSettingsLabel.leftAnchor.constraint(equalTo: personalDataSettingsImageView.rightAnchor, constant: 20).isActive = true

        addSubview(personalDataSettingsBtn)
        personalDataSettingsBtn.centerYAnchor.constraint(equalTo: personalDataSettingsLabel.centerYAnchor).isActive = true
        personalDataSettingsBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        personalDataSettingsBtn.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        personalDataSettingsBtn.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        personalDataSettingsBtn.layer.cornerRadius = imagesDimension / 2

        // MARK: - add achievements

        addSubview(achievementsImageView)
        achievementsImageView.centerYAnchor.constraint(equalTo: personalDataSettingsLabel.bottomAnchor, constant: 25).isActive = true
        achievementsImageView.leftAnchor.constraint(equalTo: accountSettingsLabel.leftAnchor).isActive = true
        achievementsImageView.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        achievementsImageView.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        achievementsImageView.layer.cornerRadius = imagesDimension / 2

        addSubview(achievementsLabel)
        achievementsLabel.centerYAnchor.constraint(equalTo: achievementsImageView.centerYAnchor).isActive = true
        achievementsLabel.leftAnchor.constraint(equalTo: achievementsImageView.rightAnchor, constant: 20).isActive = true

        addSubview(achievementsBtn)
        achievementsBtn.centerYAnchor.constraint(equalTo: achievementsLabel.centerYAnchor).isActive = true
        achievementsBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        achievementsBtn.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        achievementsBtn.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        achievementsBtn.layer.cornerRadius = imagesDimension / 2

        // MARK: - add history

        addSubview(historyImageView)
        historyImageView.centerYAnchor.constraint(equalTo: achievementsLabel.bottomAnchor, constant: 25).isActive = true
        historyImageView.leftAnchor.constraint(equalTo: accountSettingsLabel.leftAnchor).isActive = true
        historyImageView.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        historyImageView.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        historyImageView.layer.cornerRadius = imagesDimension / 2

        addSubview(historyLabel)
        historyLabel.centerYAnchor.constraint(equalTo: historyImageView.centerYAnchor).isActive = true
        historyLabel.leftAnchor.constraint(equalTo: historyImageView.rightAnchor, constant: 20).isActive = true

        addSubview(historyBtn)
        historyBtn.centerYAnchor.constraint(equalTo: historyLabel.centerYAnchor).isActive = true
        historyBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        historyBtn.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        historyBtn.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        historyBtn.layer.cornerRadius = imagesDimension / 2
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
