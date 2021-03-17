//
//  ToDo.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import Foundation

class ToDoListResponse: Decodable {
    var count: Int?
    var data: [ToDo]?
}

class ToDoResponse: Decodable {
    var success: Bool?
    var data: ToDo?
}

class ToDo: Decodable {
    var id: String?
    var description: String?
    var completed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description
        case completed
    }
}
