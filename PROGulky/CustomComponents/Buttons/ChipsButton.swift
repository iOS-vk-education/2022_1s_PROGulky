//
//  ChipsButton.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 03.04.2023.
//

import UIKit

// Кастомный компонент кнопки со скругленными краямы (кнопка похожа на чипсу, поэтому называется ChipsButton). Кнопка используется в фильтре на главной

class ChipsButton: UIButton {
    let title: String
    let apiParameters: [String: String]
    var select: Bool = false

    required init(title: String, apiParameters: [String: String]) {
        self.title = title
        self.apiParameters = apiParameters

        super.init(frame: .zero)
        backgroundColor = .prog.Dynamic.lightBackground
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {
        setTitleColor(.prog.Dynamic.textGray, for: .normal)
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        setTitle(title, for: .normal)
    }

    func changeColor() {
        if select {
            backgroundColor = .systemGray6
            setTitleColor(.prog.Dynamic.textGray, for: .normal)
        } else {
            backgroundColor = .prog.Dynamic.primary
            setTitleColor(.white, for: .normal)
        }
        select = !select
    }
}
