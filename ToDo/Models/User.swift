//
//  User.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import Foundation

class UserResponse: Decodable {
    var user: User?
    var token: String?
    
    init(user: User?, token: String?) {
        self.user = user
        self.token = token
    }
}

class User: Decodable {
    var name: String?
    var age: Int?
    var email: String?
    
    init(name: String?, age: Int?, email: String?) {
        self.name = name
        self.age = age
        self.email = email
    }
}
