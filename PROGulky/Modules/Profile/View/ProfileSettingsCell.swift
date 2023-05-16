//
//  ProfileSettingsCell.swift
//  PROGulky
//
//  Created by Сергей Киселев on 19.11.2022.
//

import UIKit

final class SettingsCell: UITableViewCell {
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            imageView?.image = UIImage(systemName: sectionType.image)?
                .withTintColor(.prog.Dynamic.text, renderingMode: .alwaysOriginal)
            textLabel?.text = sectionType.description
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
