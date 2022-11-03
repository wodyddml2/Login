//
//  UILabel+Extesion.swift
//  Login
//
//  Created by J on 2022/11/03.
//

import UIKit

extension UILabel {
    func validTextAndFont(text: String) {
        self.text = text
        self.font = .systemFont(ofSize: 12)
        self.isHidden = true
    }
}
