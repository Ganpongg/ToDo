//
//  UserService.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 13/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

typealias RegisterResponse = (UserResponse?, APIError?) -> Void
typealias LoginResponse = (UserResponse?, APIError?) -> Void
typealias LogoutResponse = (Success?, APIError?) -> Void

class UserService {
    func register(name: String, age: Int, email: String, password: String, completion: @escaping RegisterResponse) {
        let path = URLHelper.shared.buildURL(path: "user/register")
        let params: [String: Any] = ["name": name, "age": age, "email": email, "password": password]
        APIManager.shared.post(path: path, params: params, completion: completion)
    }
    
    func login(email: String, password: String, completion: @escaping LoginResponse) {
        let path = URLHelper.shared.buildURL(path: "user/login")
        let params = ["email": email, "password": password]
        APIManager.shared.post(path: path, params: params, completion: completion)
    }
    
    func logout(completion: @escaping LogoutResponse) {
        let path = URLHelper.shared.buildURL(path: "user/logout")
        APIManager.shared.post(path: path, completion: completion)
    }
}
