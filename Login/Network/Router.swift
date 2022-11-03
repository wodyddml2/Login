//
//  Router.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

enum Router {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}


extension Router {

    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.memolease.com/api/v1/users/signup")!
        case .login:
            return URL(string: "http://api.memolease.com/api/v1/users/login")!
        case .profile:
            return URL(string: "http://api.memolease.com/api/v1/users/me")!
        }
    }
    
    var header: [String: String] {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
    }
    
    var parameter: [URLQueryItem] {
        switch self {
        case .signup(let username, let email, let password):
            return [
                URLQueryItem(name: "userName", value: username),
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password)
            ]
        case .login(let email, let password):
            return [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password)
            ]
        default: return [URLQueryItem(name: "", value: "")]
        }
    }
}
