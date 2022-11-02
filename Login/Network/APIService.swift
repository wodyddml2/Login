//
//  APIService.swift
//  Login
//
//  Created by J on 2022/11/02.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
    case overlap
}

class APIService {
    
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
                return completionHandler(.failure(.invalidData))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completionHandler(.failure(.invalidResponse))
            }
            
            if response.statusCode == 406 {
                return completionHandler(.failure(.overlap))
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
                    return completionHandler(.failure(.invalidData))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    return completionHandler(.failure(.invalidResponse))
                }
                
                guard response.statusCode == 200 else {
                    return completionHandler(.failure(.failedRequest))
                }
                
                if let result = try? JSONDecoder().decode(Login.self, from: data) {
                    return completionHandler(.failure(.overlap))
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
}
