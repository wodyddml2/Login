//
//  ProfileViewController.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

import Kingfisher
import RxSwift

class ProfileViewController: BaseViewController {

    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    func bind() {
        
        let input = ProfileViewModel.Input(logout: mainView.logoutButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.logout
            .withUnretained(self)
            .bind { vc, _ in
                UserDefaults.standard.removeObject(forKey: "token")
                UserManager.login = false
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let viewController = LoginViewController()
                
                sceneDelegate?.window?.rootViewController = viewController
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            .disposed(by: disposeBag)
        
        viewModel.requestProfile()
        
        viewModel.profile
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { vc, value in
                guard let url = URL(string: value.user.photo) else {return}
                
                vc.mainView.photoImageView.kf.setImage(with: url)
                print(value)
                vc.mainView.emailLabel.text = "이메일: \(value.user.email)"
                vc.mainView.userNameLabel.text = "닉네임: \(value.user.username)"
                
        } onError: { error in
            print(error)
        }
        .disposed(by: disposeBag)
        
        
        

    }

}
