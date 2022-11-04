//
//  LoginViewModel.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    let login = PublishSubject<Result<Login,APIError>>()
    
    func requestLogin(email: String, password: String) {
        let api = Router.login(email: email, password: password)
        
        APIService.shared.requestSeSAC(type: Login.self, url: api.url, parameter: api.parameter, method: "POST", headers: api.header) { [weak self] result in
            self?.login.onNext(result)
        }
    }
    
    var disposeBag: DisposeBag = DisposeBag()
   
    struct Input {
        let signup: ControlEvent<Void>
        let login: ControlEvent<Void>
        let emailEdit: ControlEvent<Void>
        let passwordEdit: ControlEvent<Void>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
    }
    
    struct Output {
        let signup: ControlEvent<Void>
        let login: ControlEvent<Void>
        let emailEdit: ControlEvent<Void>
        let passwordEdit: ControlEvent<Void>
        let emailText: Observable<Bool>
        let passwordText: Observable<Bool>
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
        
        return Output(signup: input.signup, login: input.login, emailEdit: input.emailEdit, passwordEdit: input.passwordEdit, emailText: emailText, passwordText: passwordText)
    }
}
