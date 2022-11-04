//
//  ProfileViewModel.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    
    let profile = BehaviorSubject(value: Profile(user: User(photo: "", email: "", username: "")))
    
    func requestProfile() {
        let api = Router.profile
        
        APIService.shared.requestSeSAC(type: Profile.self, url: api.url, headers: api.header) { [weak self] result in
            switch result {
            case .success(let success):
                self?.profile.onNext(success)
            case .failure(let error):
                self?.profile.onError(error)
            }
        }
    }
    
    struct Input {
        let logout: ControlEvent<Void>
    }
    
    struct Output {
        let logout: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(logout: input.logout)
    }
}
