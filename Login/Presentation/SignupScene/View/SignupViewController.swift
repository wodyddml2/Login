//
//  SignupViewController.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

import RxSwift

class SignupViewController: BaseViewController {
    
    private let mainView = SignupView()
    private let viewModel = SignupViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func configureUI() {
        signupBind()
        editBind()
        textBind()
    }
    
    private func output() -> SignupViewModel.Output {
        let input = SignupViewModel.Input(
            userEdit: mainView.userNameTextField.rx.controlEvent(.editingDidBegin),
            emailEdit: mainView.emailTextField.rx.controlEvent(.editingDidBegin),
            passwordEdit: mainView.passwordTextField.rx.controlEvent(.editingDidBegin),
            userText: mainView.userNameTextField.rx.text,
            emailText: mainView.emailTextField.rx.text,
            passwordText: mainView.passwordTextField.rx.text,
            signup: mainView.signupButton.rx.tap
        )
        
        return viewModel.transform(input: input)
    }
    
    private func signupBind() {
        viewModel.signup
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, value in
                switch value {
                case .success(_):
                    vc.showAlert(text: "회원가입 완료")
                case .failure(let error):
                    vc.showAlert(text: (error.localizedDescription))
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func editBind() {
        output().userEdit
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.userNameView.blackBorder()
                vc.mainView.emailView.lightGrayBorder()
                vc.mainView.passwordView.lightGrayBorder()
            }
            .disposed(by: disposeBag)
        
        output().emailEdit
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.userNameView.lightGrayBorder()
                vc.mainView.emailView.blackBorder()
                vc.mainView.passwordView.lightGrayBorder()
            }
            .disposed(by: disposeBag)
        
        output().passwordEdit
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.userNameView.lightGrayBorder()
                vc.mainView.emailView.lightGrayBorder()
                vc.mainView.passwordView.blackBorder()
            }
            .disposed(by: disposeBag)
    }
    
    
    
    private func textBind() {
        
        output().userText
            .bind(to: mainView.userNameValidLabel.rx.isHidden, mainView.emailTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output().emailText
            .bind(to: mainView.emailValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output().userText, output().emailText) { user, email in
            return user && email
        }
        .bind(to: mainView.passwordTextField.rx.isEnabled)
        .disposed(by: disposeBag)
        
        Observable.combineLatest(output().userText, output().emailText, output().passwordText) { user, email, password in
            return user && email && password
            
        }
        .withUnretained(self)
        .bind { vc, bool in
            vc.mainView.signupButton.isEnabled = bool
            vc.mainView.signupButton.backgroundColor = bool ? .green : .gray
        }
        .disposed(by: disposeBag)
        
        output().passwordText
            .withUnretained(self)
            .bind { vc, bool in
                vc.mainView.passwordValidLabel.isHidden = bool
            }
            .disposed(by: disposeBag)
       
        output().signup
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestSignup(name: vc.mainView.userNameTextField.text!, email: vc.mainView.emailTextField.text!, password: vc.mainView.passwordTextField.text!)
            }
            .disposed(by: disposeBag)
            
    }
}
