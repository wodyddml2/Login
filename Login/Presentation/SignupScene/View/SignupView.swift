//
//  SignupView.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

final class SignupView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "회원가입"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let userNameValidLabel: UILabel = {
        let view = UILabel()
        view.validTextAndFont(text: ValidText.username.rawValue)
        return view
    }()
    
    var emailValidLabel: UILabel = {
        let view = UILabel()
        view.validTextAndFont(text: ValidText.email.rawValue)
        return view
    }()
    
    let passwordValidLabel: UILabel = {
        let view = UILabel()
        view.validTextAndFont(text: ValidText.password.rawValue)
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
        view.placeholder = TextFieldPlaceholder.email.rawValue
        view.isEnabled = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = TextFieldPlaceholder.password.rawValue
        view.isEnabled = false
        return view
    }()
    
    let userNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = TextFieldPlaceholder.username.rawValue
        return view
    }()

    let signupButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.backgroundColor = .gray
        view.isEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, userNameView, userNameValidLabel, emailView, emailValidLabel, passwordView, passwordValidLabel, userNameView, signupButton].forEach{
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
        
        userNameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameView.snp.bottom).offset(4)
            make.leading.equalTo(userNameView.snp.leading)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(userNameValidLabel.snp.bottom).offset(8)
            make.width.equalTo(userNameView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.edges.equalTo(emailView).inset(10)
        }
        
        emailValidLabel.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(4)
            make.leading.equalTo(emailView.snp.leading)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailValidLabel.snp.bottom).offset(8)
            make.width.equalTo(userNameView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.edges.equalTo(passwordView).inset(10)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(4)
            make.leading.equalTo(passwordView.snp.leading)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(30)
            make.width.equalTo(userNameView.snp.width)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
    }
}
