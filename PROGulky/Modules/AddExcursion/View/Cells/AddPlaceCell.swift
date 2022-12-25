//
//  AddCell.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 09.12.2022.
//

import UIKit

final class AddPlaceCell: UITableViewCell {
    private let title = UILabel()
    private let image = UIImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews(title, image)

        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }

    // MARK: configs styles

    private func setupUI() {
        backgroundColor = AddExcursionConstants.TableView.AddPlaceButtonCell.backgroundColor
        selectionStyle = UITableViewCell.SelectionStyle.none
        configureTitleLabel()
        configureImage()
    }

    private func configureTitleLabel() {
        title.font = AddExcursionConstants.TableView.AddPlaceButtonCell.Title.font
        title.text = AddExcursionConstants.TableView.AddPlaceButtonCell.Title.text
    }

    private func configureImage() {
        image.image = UIImage(systemName: "plus")
    }

    // MARK: constraints

    private func setupConstraints() {
        setImageConstraints()
        setTitleLabelConstraints()
    }

    private func setImageConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.widthAnchor.constraint(equalToConstant: AddExcursionConstants.TableView.AddPlaceButtonCell.Image.width).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AddExcursionConstants.TableView.AddPlaceButtonCell.Image.marginLeft).isActive = true
    }

    private func setTitleLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: AddExcursionConstants.TableView.AddPlaceButtonCell.Image.marginLeft).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AddExcursionConstants.Screen.padding).isActive = true
    }
}
