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

        contentView.addSubview(text)

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
        backgroundColor = DetailExcursionConstants.TableView.DescriptionCell.backgroundColor
        selectionStyle = UITableViewCell.SelectionStyle.none
        configureDecriptionText()
    }

    private func configureDecriptionText() {
        text.numberOfLines = DetailExcursionConstants.TableView.DescriptionCell.Text.numberOfLines
        text.font = DetailExcursionConstants.TableView.DescriptionCell.Text.font
    }

    private func setupConstraints() {
        setDescriptionTextConstraints()
    }

    private func setDescriptionTextConstraints() {
        let marginGuide = contentView.layoutMarginsGuide
        text.translatesAutoresizingMaskIntoConstraints = false
        text.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        text.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        text.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        text.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
}
