//
//  DescriptionCell.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 19.11.2022.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    private let text = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(text)

        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }

    func set(description: String) {
        text.text = description
    }

    private func setupUI() {
        configureDecriptionText()
    }

    private func configureDecriptionText() {
        text.numberOfLines = DetailExcursionConstants.TableView.DescriptionCell.Text.numberOfLines
        text.font = DetailExcursionConstants.TableView.DescriptionCell.Text.font
        // descriptionText.textAlignment = .justified
    }

    private func setupConstraints() {
        setdescriptionTextConstraints()
    }

    private func setdescriptionTextConstraints() {
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: topAnchor, constant: DetailExcursionConstants.TableView.DescriptionCell.Text.marginTop).isActive = true
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailExcursionConstants.Screen.padding).isActive = true
        text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DetailExcursionConstants.Screen.padding).isActive = true
    }
}
