//
//  FilterBadgeButton.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 08.04.2023.
//

import UIKit

// MARK: - Constants

private struct Constants {
    enum Badge {
        static let frame: CGRect = .init(x: 20, y: -10, width: 20, height: 20)
        static let borderColor: CGColor = UIColor.clear.cgColor
        static let borderWidth: CGFloat = 2
        static let textColor: UIColor = .white
        static let backgroundColor: UIColor = .red
    }

    enum Button {
        static let image: UIImage? = UIImage(systemName: "slider.horizontal.3")
    }
}

// MARK: - FilterBadgeButton

// Кастомная кнопка фильтра с бейджом
final class FilterBadgeButton: UIButton {
    // бейдж
    private var badgeCount: UILabel = {
        let label = UILabel(frame: Constants.Badge.frame)
        label.layer.borderColor = Constants.Badge.borderColor
        label.layer.borderWidth = Constants.Badge.borderWidth
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = Constants.Badge.textColor
        label.font = label.font.withSize(12)
        label.backgroundColor = Constants.Badge.backgroundColor

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        hideBadge()
        setBackgroundImage(Constants.Button.image, for: .normal)
        addSubview(badgeCount)
    }

    func setupTextToBadgeLabel(with text: String) {
        badgeCount.text = text
    }

    func showBadge() {
        badgeCount.isHidden = false
    }

    func hideBadge() {
        badgeCount.isHidden = true
    }
}
