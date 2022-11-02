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
    
    func transform(input: Input) -> Output {
        
        let emailText = input.emailText
            .orEmpty
            .changed
            .map {$0.contains(".") && $0.contains("@") && $0.count > 10}
        
        let passwordText = input.passwordText
            .orEmpty
            .changed
            .map {$0.count > 8}
        
        return Output(signup: input.signup, emailEdit: input.emailEdit, passwordEdit: input.passwordEdit, emailText: emailText, passwordText: passwordText)
    }
}
