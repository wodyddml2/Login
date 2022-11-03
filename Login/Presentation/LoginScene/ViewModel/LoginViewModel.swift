//
//  LoginViewModel.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
   
    
    struct Input {
        let signup: ControlEvent<Void>
        let emailEdit: ControlEvent<Void>
        let passwordEdit: ControlEvent<Void>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
    }
    
    struct Output {
        let signup: ControlEvent<Void>
        let emailEdit: ControlEvent<Void>
        let passwordEdit: ControlEvent<Void>
        let emailText: Observable<Bool>
        let passwordText: Observable<Bool>
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
        
        return Output(signup: input.signup, emailEdit: input.emailEdit, passwordEdit: input.passwordEdit, emailText: emailText, passwordText: passwordText)
    }
}
