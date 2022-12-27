//
//  DescriptionCell.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import Foundation
import UIKit

typealias AddExcursionDescriptionCellDelegate = UITextViewDelegate

final class AddExcursionDescriptionCell: UITableViewCell {
    private let descriptionField = UITextView(frame: .zero)
    var delegate: AddExcursionDescriptionCellDelegate?

    func configure() {
        self.addSubview(descriptionField)
        descriptionField.delegate = self.delegate
        setupConstraints()
    }

    func setupConstraints() {
        descriptionField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(200)

        }
    }

}
