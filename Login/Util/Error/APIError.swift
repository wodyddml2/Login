//
//  APIError.swift
//  Login
//
//  Created by J on 2022/11/04.
//

import Foundation

enum APIError: Error {
    case invalidAuthorization
    case failedRequest
    case takeEmail
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요"
        case .failedRequest:
            return "회원가입이 실패했습니다."
        case .takeEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요"
        }
    }
}
