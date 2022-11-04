//
//  LoginView.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

import SnapKit

final class LoginView: BaseView {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "로그인"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let emailValidLabel: UILabel = {
        let view = UILabel()
        view.validTextAndFont(text: "이메일 형식으로 입력해주세요.")
        return view
    }()
    
    let passwordValidLabel: UILabel = {
        let view = UILabel()
        view.validTextAndFont(text: "8자 이상 입력해주세요.")
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
    
    let emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "가입한 이메일 주소 입력"
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "비밀번호 입력"
        view.isEnabled = false
        return view
    }()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("로그인하기", for: .normal)
        view.backgroundColor = .gray
        view.isEnabled = false
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
        
        [titleLabel, emailView, emailValidLabel, passwordView, passwordValidLabel, loginButton, signupButton].forEach{
            self.addSubview($0)
        }
        
        emailView.addSubview(emailTextField)
        
        passwordView.addSubview(passwordTextField)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(18)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.edges.equalTo(emailView).inset(10)
        }
        
        emailValidLabel.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(8)
            make.leading.equalTo(emailView.snp.leading)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailValidLabel.snp.bottom).offset(8)
            make.width.equalTo(emailView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.edges.equalTo(passwordView).inset(10)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(8)
            make.leading.equalTo(passwordView.snp.leading)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(25)
            make.width.equalTo(emailView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.width.equalTo(emailView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
    }
    
}
