//
//  UserDefault.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let storages: UserDefaults
    
    var wrappedValue: T {
        get { self.storages.object(forKey: self.key) as? T ?? self.defaultValue }
        set { self.storages.set(newValue, forKey: self.key)}
    }
    
    init(key: String, defaultValue: T, storages: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storages = storages
    }
}

class UserManager {
    @UserDefault(key: "login", defaultValue: false)
    static var login: Bool
    
    @UserDefault(key: "token", defaultValue: "")
    static var token: String
}
