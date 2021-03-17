//
//  TaskService.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 13/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

typealias GetToDoListResponse = (ToDoListResponse?, APIError?) -> Void
typealias GetToDoDetailResponse = (ToDoResponse?, APIError?) -> Void
typealias CreateToDoResponse = (ToDoResponse?, APIError?) -> Void
typealias UpdateToDoResponse = (ToDoResponse?, APIError?) -> Void
typealias DeleteToDoResponse = (Success?, APIError?) -> Void

class TaskService {
    func getToDoList(completion: @escaping GetToDoListResponse) {
        let path = URLHelper.shared.buildURL(path: "task")
        APIManager.shared.get(path: path, completion: completion)
    }
    
    func getToDoDetail(id: String, completion: @escaping GetToDoDetailResponse) {
        let path = URLHelper.shared.buildURL(path: "task/\(id)")
        APIManager.shared.get(path: path, completion: completion)
    }
    
    func createToDo(description: String, completion: @escaping CreateToDoResponse) {
        let path = URLHelper.shared.buildURL(path: "task")
        let params = ["description": description]
        APIManager.shared.post(path: path, params: params, completion: completion)
    }
    
    func updateToDo(id: String, description: String, completed: Bool, completion: @escaping UpdateToDoResponse) {
        let path = URLHelper.shared.buildURL(path: "task/\(id)")
        let params: [String: Any] = ["description": description, "completed": completed]
        APIManager.shared.put(path: path, params: params, completion: completion)
    }
    
    func deleteToDo(id: String, completion: @escaping DeleteToDoResponse) {
        let path = URLHelper.shared.buildURL(path: "task/\(id)")
        APIManager.shared.delete(path: path, completion: completion)
    }
}
