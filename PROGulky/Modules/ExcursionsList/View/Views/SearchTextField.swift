//
//  SearchTextField.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 02.03.2023.
//

import UIKit

final class SearchTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: ExcursionsListConstants.SearchTextField.padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: ExcursionsListConstants.SearchTextField.padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: ExcursionsListConstants.SearchTextField.padding)
    }

    private func setupTextField(placeholder: String) {
        textColor = ExcursionsListConstants.SearchTextField.textColor

        layer.cornerRadius = ExcursionsListConstants.SearchTextField.cornerRadius
        layer.backgroundColor = ExcursionsListConstants.SearchTextField.backgroundColor.cgColor

        layer.shadowColor = ExcursionsListConstants.SearchTextField.shadowColor.cgColor
        layer.shadowRadius = ExcursionsListConstants.SearchTextField.shadowRadius
        layer.shadowOpacity = ExcursionsListConstants.SearchTextField.shadowOpacity

        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: ExcursionsListConstants.SearchTextField.placeholderColor
        ])
        font = .systemFont(ofSize: ExcursionsListConstants.SearchTextField.fontSize)

        heightAnchor.constraint(equalToConstant: ExcursionsListConstants.SearchTextField.height).isActive = true
    }
}
