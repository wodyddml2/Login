//
//  ViewModelType.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

