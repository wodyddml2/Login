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
            login: mainView.loginButton.rx.tap,
            emailEdit: mainView.emailTextField.rx.controlEvent(.editingDidBegin),
            passwordEdit: mainView.passwordTextField.rx.controlEvent(.editingDidBegin),
            emailText: mainView.emailTextField.rx.text,
            passwordText: mainView.passwordTextField.rx.text)
        let output = viewModel.transform(input: input)
        
        viewModel.login
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, result in
            switch result {
            case .success( let value ):
                UserManager.token = value.token
                UserManager.login = true
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let viewController = ProfileViewController()
                
                sceneDelegate?.window?.rootViewController = viewController
                sceneDelegate?.window?.makeKeyAndVisible()
            case .failure(let error):
                vc.showAlert(text: error.localizedDescription)
            }
        }
            .disposed(by: disposeBag)
        
        output.login
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestLogin(
                    email: vc.mainView.emailTextField.text!,
                    password: vc.mainView.passwordTextField.text!)
            }
            .disposed(by: disposeBag)
        
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
                vc.mainView.passwordValidLabel.isHidden = bool
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.emailText, output.passwordText) { email, password in
            return email && password
            
        }
        .withUnretained(self)
        .bind { vc, bool in
            vc.mainView.loginButton.isEnabled = bool
            vc.mainView.loginButton.backgroundColor = bool ? .green : .gray
        }
        .disposed(by: disposeBag)
    }

}

