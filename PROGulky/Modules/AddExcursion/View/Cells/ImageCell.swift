//
//  ImageCell.swift
//  PROGulky
//
//  Created by Иван Тазенков on 26.12.2022.
//

import Foundation
import UIKit

final class ImageCell: UITableViewCell {
    private let userImageView = UIImageView(frame: .zero)
    private var image = UIImage(systemName: AddExcursionConstants.Image.placeholderName)

    private func setupViews() {
        addSubview(userImageView)
        setupConstraints()
        userImageView.image = image
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFit
        selectionStyle = UITableViewCell.SelectionStyle.none
    }

    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(image: UIImage? = nil) {
        if image != nil {
            self.image = image
        }
        setupViews()
    }
}
