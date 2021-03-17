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
}

class User: Decodable {
    var name: String?
    var age: Int?
    var email: String?
}
