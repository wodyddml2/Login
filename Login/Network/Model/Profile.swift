//
//  Profile.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}
