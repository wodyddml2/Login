//
//  ViewModelType.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
    var disposeBag: DisposeBag { get set }
}

extension ViewModelType {
    func validateEmail(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z]{2,16}+@[A-Za-z0-9]{4,16}+\\.[A-Za-z]{2,10}"
        return text.range(of: emailRegEx, options: .regularExpression) != nil
    }
}
