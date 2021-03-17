//
//  APIManager.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import Alamofire
import ObjectMapper

typealias ObjectResponse<T> = (T?, APIError?) -> Void

enum APIError: Error {
    case networkError(error: Error?)
    case unknownError(error: Error?)
    
    var localizedDescription: String? {
        switch self {
        case .networkError:
            return "No internet connection"
        default:
            return "An error occured, please try again later"
        }
    }
}

class APIManager {
    static let shared = APIManager()
    
    let session = URLSession.shared
    
    func get<T: Decodable>(path: String, headers: [String: String]? = nil, completion: @escaping ObjectResponse<T>)  {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "GET"
        fire(urlRequest: request, headers: headers, completion: completion)
    }
    
    func post<T: Decodable>(path: String, params: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping ObjectResponse<T>) {
        var request = URLRequest(url: URL(string: path)!)
        let body = try? JSONSerialization.data(withJSONObject: params ?? [:], options: [])
        request.httpBody = body
        request.httpMethod = "POST"
        fire(urlRequest: request, headers: headers, completion: completion)
    }
    
    func put<T: Decodable>(path: String, params: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping ObjectResponse<T>) {
        var request = URLRequest(url: URL(string: path)!)
        let body = try? JSONSerialization.data(withJSONObject: params ?? [:], options: [])
        request.httpBody = body
        request.httpMethod = "PUT"
        fire(urlRequest: request, headers: headers, completion: completion)
    }
    
    func delete<T: Decodable>(path: String, headers: [String: String]? = nil, completion: @escaping ObjectResponse<T>) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "DELETE"
        fire(urlRequest: request, headers: headers, completion: completion)
    }
}
