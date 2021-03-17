//
//  UrlHelper.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import Foundation

class URLHelper {
    static let shared = URLHelper()
    
    func buildURL(path: String) -> String {
        return "\(domain)/\(path)"
    }
}

var domain: String = "https://api-nodejs-todolist.herokuapp.com"
