//
//  SignupViewModel.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift
import RxCocoa

class SignupViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let signup = PublishSubject<Result<String, Error>>()
    
    func requestSignup(name: String, email: String, password: String) {
        
        APIService.shared.singleSignup(name: name, email: email, password: password).subscribe { [weak self] value in
            self?.signup.onNext(value)
        }
        .disposed(by: disposeBag)
        
//        APIService.shared.requestSignup(name: name, email: email, password: password) { [weak self] result in
//            switch result {
//            case .success(let success):
//                self?.signup.onNext(success)
//            case .failure(let error):
//                self?.signup.onError(error)
//            }
//        }
    }
    
    struct Input {
        let userEdit: ControlEvent<Void>
        let emailEdit: ControlEvent<Void>
        let passwordEdit: ControlEvent<Void>
        let userText: ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let signup: ControlEvent<Void>
    }
    
    struct Output {
        let userEdit: ControlEvent<Void>
        let emailEdit: ControlEvent<Void>
        let passwordEdit: ControlEvent<Void>
        let userText: Observable<Bool>
        let emailText: Observable<Bool>
        let passwordText: Observable<Bool>
        let signup: ControlEvent<Void>
    }
    
    func validateEmail(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z]{2,16}+@[A-Za-z0-9]{4,16}+\\.[A-Za-z]{2,10}"
        return text.range(of: emailRegEx, options: .regularExpression) != nil
    }
    
    func transform(input: Input) -> Output {
        let emailText = input.emailText
            .orEmpty
            .changed
            .withUnretained(self)
            .map({ vm, value in
                vm.validateEmail(value)
            })
        
        let passwordText = input.passwordText
            .orEmpty
            .changed
            .map {$0.count > 7}
        
        let userText = input.userText
            .orEmpty
            .changed
            .map {$0.count > 1}
        
        return Output(userEdit: input.userEdit, emailEdit: input.emailEdit, passwordEdit: input.passwordEdit, userText: userText, emailText: emailText, passwordText: passwordText, signup: input.signup)
       
    }
}
