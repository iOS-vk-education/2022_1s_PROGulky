//
//  UITextField+DoneButton.swift
//  PROGulky
//
//  Created by Иван Тазенков on 14.12.2022.
//

import Foundation
import UIKit
extension UITextField {
    @IBInspectable var doneAccessory: Bool {
        get {
            self.doneAccessory
        }
        set(hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        resignFirstResponder()
    }
}
