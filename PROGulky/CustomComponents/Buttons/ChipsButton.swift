//
//  ChipsButton.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 03.04.2023.
//

import UIKit

// Кастомный компонент кнопки со скругленными краямы (кнопка похожа на чипсу, поэтому называется ChipsButton). Кнопка используется в фильтре на главной

final class ChipsButton: UIButton {
    required init() {
        super.init(frame: .zero)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        setDefaultColor()
        layer.cornerRadius = 12
    }

    func setDefaultColor() { // Установить серый цвет чипсы
        backgroundColor = .systemGray6
        setTitleColor(.prog.Dynamic.textGray, for: .normal)
    }

    func setSelectedColor() { // Установить синий цвет чипсы
        backgroundColor = .prog.Dynamic.primary
        setTitleColor(.white, for: .normal)
    }
}
