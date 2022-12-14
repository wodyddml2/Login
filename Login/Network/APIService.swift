//
//  APIService.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

import RxSwift


class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, parameter: [URLQueryItem]? = nil, method: String = "GET", headers: [String: String], completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        var compoment = URLComponents()
        compoment.queryItems = parameter
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        request.httpBody = compoment.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                return completionHandler(.failure(.failedRequest))
            }
            
            guard error == nil || response.statusCode == 200 else {
                return completionHandler(.failure(.failedRequest))
            }
            
            if response.statusCode == 401 {
                return completionHandler(.failure(.invalidAuthorization))
            }
            
            if response.statusCode == 406 {
                return completionHandler(.failure(.takeEmail))
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                return completionHandler(.failure(.failedRequest))
            }
            
            completionHandler(.success(result))
            
        }.resume()
        
    }
    
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
