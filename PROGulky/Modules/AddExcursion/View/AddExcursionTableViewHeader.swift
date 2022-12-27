//
//  AddExcursionTableViewHeader.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import UIKit
import SnapKit

// MARK: - AddExcursionTableViewHeaderDelegate

protocol AddExcursionTableViewHeaderDelegate: AnyObject {
    func editButtonTapped()
}

// MARK: - AddExcursionTableViewHeader

final class AddExcursionTableViewHeader: UITableViewHeaderFooterView {
    private let editButton = UIButton(frame: .zero)
    weak var delegate: AddExcursionTableViewHeaderDelegate?
    private var isEditing = false
    private var label = UILabel(frame: .zero)

    func configure(isEditing: Bool, distance: Double, duration: Int) {
        self.isEditing = isEditing
        addSubview(editButton)
        addSubview(label)
        configureLabel(distance: distance, duration: duration)
        editButton.setTitleColor(.prog.Dynamic.text, for: .normal)
        setupTitle()

        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
                .offset(20)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.leading.greaterThanOrEqualTo(self.label.snp.trailing).offset(4)
        }

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }

    func configureLabel(distance: Double, duration: Int) {
        label.text = "\(distance) км \(duration) мин"
    }

    private func setupTitle() {
        if !isEditing {
            editButton.setTitle("Редактировать", for: .normal)
        } else {
            editButton.setTitle("Готово", for: .normal)
        }
//        layoutIfNeeded()
    }

    @objc
    private func editButtonTapped() {
        delegate?.editButtonTapped()
        isEditing = !isEditing
//        UIView.animate(withDuration: 0.17) {
        setupTitle()
//        }
    }
}
