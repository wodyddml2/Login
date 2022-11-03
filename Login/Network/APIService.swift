//
//  APIService.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift


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

class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, parameter: [URLQueryItem]? = nil, method: String = "GET",headers: [String: String], completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        var compoment = URLComponents()
        compoment.queryItems = parameter
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        request.httpBody = compoment.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard error == nil || data != nil || response.statusCode == 200 else {
                return completionHandler(.failure(.failedRequest))
            }
            
            if response.statusCode == 401 {
                return completionHandler(.failure(.invalidAuthorization))
            }
            
            if response.statusCode == 406 {
                return completionHandler(.failure(.takeEmail))
            }
            
            
            completionHandler(.success("ok" as! T))
            
        }.resume()
        
    }
    
    
    ////////////////
    func requestSignup(name: String, email: String, password: String, completionHandler: @escaping (Result<String, APIError>) -> Void) {
        let api = Router.signup(userName: name, email: email, password: password)
        
        var compoment = URLComponents()
        compoment.queryItems = api.parameter
        
        var request = URLRequest(url: api.url)
        request.allHTTPHeaderFields = api.header
        request.httpMethod = "POST"
        request.httpBody = compoment.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard data != nil else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completionHandler(.failure(.failedRequest))
            }
            
            if response.statusCode == 406 {
                return completionHandler(.failure(.takeEmail))
            }
            
            guard response.statusCode == 200 else {
                return completionHandler(.failure(.failedRequest))
            }
            
            completionHandler(.success("ok"))
            
        }.resume()
    }
    
    
    func requestLogin(email: String, password: String, completionHandler: @escaping (Result<Login, APIError>) -> Void) {
        let api = Router.login(email: email, password: password)
        
        let requestBody = try! JSONSerialization.data(withJSONObject: api.parameter, options: [])
        
        var request = URLRequest(url: api.url)
        request.allHTTPHeaderFields = api.header
        request.httpMethod = "POST"
        request.httpBody = requestBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard response.statusCode == 200 else {
                return completionHandler(.failure(.failedRequest))
            }
            
            if let result = try? JSONDecoder().decode(Login.self, from: data) {
                return completionHandler(.failure(.takeEmail))
            } else {
                return print(response)
            }
            
            
            //            print("data===\(data)")
            //            print("response===\(response)")
            //            print("error===\(error)")
        }.resume()
        
        
        func requestProfile() {
            
        }
    }
    
    
    // ==============================
    
    
    func singleSignup(name: String, email: String, password: String) -> Single<String> {
        
        return Single<String>.create { single in
            let api = Router.signup(userName: name, email: email, password: password)
            
            var compoment = URLComponents()
            compoment.queryItems = api.parameter
            
            var request = URLRequest(url: api.url)
            request.allHTTPHeaderFields = api.header
            request.httpMethod = "POST"
            request.httpBody = compoment.query?.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let response = response as? HTTPURLResponse else {
                    return single(.failure(APIError.failedRequest))
                }
                
                guard error == nil || data != nil || response.statusCode == 200 else {
                    return single(.failure(APIError.failedRequest))
                }
                
                if response.statusCode == 401 {
                    return single(.failure(APIError.invalidAuthorization))
                }
                
                if response.statusCode == 406 {
                    return single(.failure(APIError.takeEmail))
                }
                
                single(.success("ok"))
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
}
