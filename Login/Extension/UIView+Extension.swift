//
//  UITextField+Extension.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

extension UIView {
    func lightGrayBorder() {
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func blackBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
