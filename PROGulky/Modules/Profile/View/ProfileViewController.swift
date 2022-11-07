//
//  ProfileViewController.swift
//  PROGulky
//
//  Created by SemyonPyatkov on 31/10/2022.
//

import UIKit

// MARK: - ProfileViewController

final class ProfileViewController: UIViewController {
    var output: ProfileViewOutput!
    var userInfoHeader: UserInfoHeader!
    var userAccountView: ProfileUserAccountView!
    var userAnotherSettingsView: ProfileUserAnotherView!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        var userInfoHeader: UserInfoHeader!
        view.backgroundColor = .white
        configureUI()
    }

    func configureUI() {
        let title: UILabel = {
            let label = UILabel()
            label.text = "Profile"
            label.frame = CGRect(x: self.view.frame.width / 2 - 25, y: 60, width: 50, height: 30)
            return label
        }()

        let frameUserInfoHeader = CGRect(x: 20, y: 110, width: view.frame.width, height: 60)
        userInfoHeader = UserInfoHeader(frame: frameUserInfoHeader)
        view.addSubview(userInfoHeader)
        let frameUserAccountView = CGRect(x: 20, y: 210, width: view.frame.width - 40, height: 158)
        userAccountView = ProfileUserAccountView(frame: frameUserAccountView)

        userAccountView.backgroundColor = .white
        userAccountView.layer.shadowColor = UIColor.black.cgColor
        userAccountView.layer.shadowOpacity = 0.1
        userAccountView.layer.shadowOffset = .zero
        userAccountView.layer.shadowRadius = 10
        userAccountView.layer.cornerRadius = 16
        userAccountView.layer.shadowPath = UIBezierPath(rect: userAccountView.bounds).cgPath

        view.addSubview(userAccountView)

        let frameUserAnotherSettingsView = CGRect(x: 20, y: 400, width: view.frame.width - 40, height: 158)
        userAnotherSettingsView = ProfileUserAnotherView(frame: frameUserAnotherSettingsView)

        userAnotherSettingsView.backgroundColor = .white
        userAnotherSettingsView.layer.shadowColor = UIColor.black.cgColor
        userAnotherSettingsView.layer.shadowOpacity = 0.1
        userAnotherSettingsView.layer.shadowOffset = .zero
        userAnotherSettingsView.layer.shadowRadius = 10
        userAnotherSettingsView.layer.cornerRadius = 16
        userAnotherSettingsView.layer.shadowPath = UIBezierPath(rect: userAccountView.bounds).cgPath

        view.addSubview(userAnotherSettingsView)

        view.addSubview(title)
    }
}

extension ProfileViewController: ProfileViewInput {
}
