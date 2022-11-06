//
//  ProfileUserAnotherView.swift
//  PROGulky
//
//  Created by Сергей Киселев on 04.11.2022.
//

import UIKit

class ProfileUserAnotherView: UIView {
    // MARK: - add accountSettingsLabel

    let accountSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Другое"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#1D1617")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - add contactUs

    let contactUsLabel: UILabel = {
        let label = UILabel()
        label.text = "Свяжитесь с нами"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let contactUsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Icon-Edit")
        return iv
    }()

    let contactUsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - add privacyPolicy

    let privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "Достижения"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let privacyPolicyImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Icon-Privacy")
        return iv
    }()

    let privacyPolicyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "Icon-Arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - add signOut

    let signOutLabel: UILabel = {
        let label = UILabel()
        label.text = "История прогулок"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#7B6F72")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let signOutImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "Icon-Setting")
        return iv
    }()

    let signOutBtn: UIButton = {
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

    //    let contactUsView: UIView = {
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

        // MARK: - add contactUs

        addSubview(contactUsImageView)
        contactUsImageView.centerYAnchor.constraint(equalTo: accountSettingsLabel.bottomAnchor, constant: 25).isActive = true
        contactUsImageView.leftAnchor.constraint(equalTo: accountSettingsLabel.leftAnchor).isActive = true
        contactUsImageView.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        contactUsImageView.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        contactUsImageView.layer.cornerRadius = imagesDimension / 2

        addSubview(contactUsLabel)
        contactUsLabel.centerYAnchor.constraint(equalTo: contactUsImageView.centerYAnchor).isActive = true
        contactUsLabel.leftAnchor.constraint(equalTo: contactUsImageView.rightAnchor, constant: 20).isActive = true

        addSubview(contactUsBtn)
        contactUsBtn.centerYAnchor.constraint(equalTo: contactUsLabel.centerYAnchor).isActive = true
        contactUsBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        contactUsBtn.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        contactUsBtn.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        contactUsBtn.layer.cornerRadius = imagesDimension / 2

        // MARK: - add privacyPolicy

        addSubview(privacyPolicyImageView)
        privacyPolicyImageView.centerYAnchor.constraint(equalTo: contactUsLabel.bottomAnchor, constant: 25).isActive = true
        privacyPolicyImageView.leftAnchor.constraint(equalTo: accountSettingsLabel.leftAnchor).isActive = true
        privacyPolicyImageView.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        privacyPolicyImageView.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        privacyPolicyImageView.layer.cornerRadius = imagesDimension / 2

        addSubview(privacyPolicyLabel)
        privacyPolicyLabel.centerYAnchor.constraint(equalTo: privacyPolicyImageView.centerYAnchor).isActive = true
        privacyPolicyLabel.leftAnchor.constraint(equalTo: privacyPolicyImageView.rightAnchor, constant: 20).isActive = true

        addSubview(privacyPolicyBtn)
        privacyPolicyBtn.centerYAnchor.constraint(equalTo: privacyPolicyLabel.centerYAnchor).isActive = true
        privacyPolicyBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        privacyPolicyBtn.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        privacyPolicyBtn.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        privacyPolicyBtn.layer.cornerRadius = imagesDimension / 2

        // MARK: - add signOut

        addSubview(signOutImageView)
        signOutImageView.centerYAnchor.constraint(equalTo: privacyPolicyLabel.bottomAnchor, constant: 25).isActive = true
        signOutImageView.leftAnchor.constraint(equalTo: accountSettingsLabel.leftAnchor).isActive = true
        signOutImageView.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        signOutImageView.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        signOutImageView.layer.cornerRadius = imagesDimension / 2

        addSubview(signOutLabel)
        signOutLabel.centerYAnchor.constraint(equalTo: signOutImageView.centerYAnchor).isActive = true
        signOutLabel.leftAnchor.constraint(equalTo: signOutImageView.rightAnchor, constant: 20).isActive = true

        addSubview(signOutBtn)
        signOutBtn.centerYAnchor.constraint(equalTo: signOutLabel.centerYAnchor).isActive = true
        signOutBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        signOutBtn.widthAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        signOutBtn.heightAnchor.constraint(equalToConstant: imagesDimension).isActive = true
        signOutBtn.layer.cornerRadius = imagesDimension / 2
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
