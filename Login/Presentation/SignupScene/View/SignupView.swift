//
//  SignupView.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

class SignupView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "회원가입"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let emailView: UIViewBolder = {
        let view = UIViewBolder()
        return view
    }()
    
    let passwordView: UIViewBolder = {
        let view = UIViewBolder()
        return view
    }()
    
    let userNameView: UIViewBolder = {
        let view = UIViewBolder()
        
        return view
    }()
    
    let emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "가입한 이메일 주소 입력"
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "비밀번호 입력"
        return view
    }()
    
    let userNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "닉네임 입력"
        return view
    }()

    let signupButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, emailView, passwordView, userNameView, signupButton].forEach{
            self.addSubview($0)
        }
        
        userNameView.addSubview(userNameTextField)
        
        emailView.addSubview(emailTextField)
        
        passwordView.addSubview(passwordTextField)
        
        
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(18)
        }
        
        userNameView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.edges.equalTo(userNameView).inset(10)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(userNameView.snp.bottom).offset(8)
            make.width.equalTo(userNameView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.edges.equalTo(emailView).inset(10)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(8)
            make.width.equalTo(userNameView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.edges.equalTo(passwordView).inset(10)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(30)
            make.width.equalTo(userNameView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
    }
}