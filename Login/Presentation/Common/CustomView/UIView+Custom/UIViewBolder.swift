//
//  Bolder.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

class UIViewBolder: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
