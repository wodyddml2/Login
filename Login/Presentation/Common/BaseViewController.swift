//
//  BaseViewController.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    

}
