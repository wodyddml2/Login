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
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { viewController, _ in
                let vc = SignupViewController()
                viewController.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }


}

