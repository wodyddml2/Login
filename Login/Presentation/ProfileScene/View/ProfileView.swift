//
//  ProfileView.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

final class ProfileView: BaseView {
    
    let logoutButton: UIButton = {
        let view = UIButton()
        view.setTitle("로그아웃", for: .normal)
        view.backgroundColor = .red
        return view
    }()
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let userNameLabel: UILabel = {
        let view = UILabel()
     
        return view
    }()
    
    let emailLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [logoutButton, photoImageView, userNameLabel, emailLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        logoutButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.top.equalTo(logoutButton.snp.bottom).offset(40)
            make.centerX.equalTo(self)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(40)
            make.leading.equalTo(16)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(18)
            make.leading.equalTo(16)
        }
    }
    
}
