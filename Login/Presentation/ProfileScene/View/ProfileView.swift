//
//  ProfileView.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import UIKit

class ProfileView: BaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let userNameLabel: UILabel = {
        let view = UILabel()
        view.text = "닉네임:  "
        return view
    }()
    
    let emailLabel: UILabel = {
        let view = UILabel()
        view.text = "이메일:  "
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [photoImageView, userNameLabel, emailLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
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
