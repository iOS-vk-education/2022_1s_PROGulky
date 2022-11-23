//
//  CustomTextField.swift
//  PROGulky
//
//  Created by Сергей Киселев on 23.11.2022.
//

import UIKit

class CustomTextField: UITextField {
    private var security = Bool()
    private var name = String()
    private var image = String()

    convenience init(name: String, image: String, security: Bool) {
        self.init()
        self.name = name
        self.image = image
        self.security = security
        entryField()
    }

    private func entryField() {
        textColor = .black
        placeholder = name
        layer.cornerRadius = 14
        layer.borderWidth = 0.5
        autocorrectionType = .no
        clearButtonMode = .always
        isSecureTextEntry = security
        autocapitalizationType = .none
        font = UIFont.systemFont(ofSize: 14)
        backgroundColor = CustomColor.whiteColor
        layer.borderColor = UIColor.lightGray.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.height))
        let imageView = UIImageView(frame: CGRect(x: 10, y: -9, width: 20, height: 20))
        imageView.image = UIImage(named: image)
        leftView?.addSubview(imageView)
        leftViewMode = .always
    }
}
