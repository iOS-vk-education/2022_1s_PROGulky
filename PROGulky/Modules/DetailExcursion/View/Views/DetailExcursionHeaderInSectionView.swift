//
//  DetailExcursionHeaderInSectionView.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 20.11.2022.
//

import UIKit

final class DetailExcursionHeaderInSectionView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = DetailExcursionConstants.TableView.HeaderInSection.textColor
        label.font = DetailExcursionConstants.TableView.HeaderInSection.font
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = DetailExcursionConstants.TableView.HeaderInSection.backgroundColor
        addSubview(label)
        setupConstraints()
    }

    func set(headerText: String) {
        label.text = headerText
    }

    private func setupConstraints() {
        setLabelConstraint()
    }

    private func setLabelConstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailExcursionConstants.Screen.padding).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
