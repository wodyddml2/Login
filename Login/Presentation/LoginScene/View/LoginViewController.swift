//
//  ViewController.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    let mainView = LoginView()
    let viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    
    }

    func bind() {
        let input = LoginViewModel.Input(
            signup: mainView.signupButton.rx.tap,
            emailEdit: mainView.emailTextField.rx.controlEvent(.editingDidBegin),
            passwordEdit: mainView.passwordTextField.rx.controlEvent(.editingDidBegin),
            emailText: mainView.emailTextField.rx.text,
            passwordText: mainView.passwordTextField.rx.text)
        let output = viewModel.transform(input: input)
        
        output.signup
            .withUnretained(self)
            .bind { viewController, _ in
                let vc = SignupViewController()
                viewController.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        output.emailEdit
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.emailView.blackBorder()
                vc.mainView.passwordView.lightGrayBorder()
            }
            .disposed(by: disposeBag)
   
        output.passwordEdit
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.passwordView.blackBorder()
                vc.mainView.emailView.lightGrayBorder()
            }
            .disposed(by: disposeBag)

        
        output.emailText
            .bind(to: mainView.passwordTextField.rx.isEnabled, mainView.emailValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        output.passwordText
            .withUnretained(self)
            .bind { vc, bool in
                vc.mainView.loginButton.isEnabled = bool
                vc.mainView.passwordValidLabel.isHidden = bool
                vc.mainView.loginButton.backgroundColor = bool ? .green : .gray
            }
            .disposed(by: disposeBag)
    }

}

