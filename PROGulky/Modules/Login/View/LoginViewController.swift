//
//  LoginViewController.swift
//  PROGulky
//
//  Created by Ivan Tazenkov on 22/11/2022.
//

import UIKit

// MARK: - LoginViewController

final class LoginViewController: UIViewController {
    var output: LoginViewOutput!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: LoginViewInput {
}
