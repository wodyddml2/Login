//
//  LoginView.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

class LoginView: BaseView {
    let loginTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "로그인"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let loginEmailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "가입한 이메일 주소 입력"
        return view
    }()
    
    let loginPasswordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "비밀번호 입력"
        return view
    }()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
        return view
    }()
    
    let signupButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
