//
//  APIManager+Fire.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import Foundation

import Alamofire

extension APIManager {
    func fire<T: Decodable>(urlRequest: URLRequest, headers: [String: String]? = nil, completion: @escaping ObjectResponse<T>) {
        var request = urlRequest
        request.allHTTPHeaderFields = buildHeaders(headers: headers)
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(nil, APIError.unknownError(error: error))
                    return
                }
                
                guard error == nil else {
                    if let error = error as? URLError {
                        switch error.code {
                        case .notConnectedToInternet, .networkConnectionLost:
                            completion(nil, APIError.networkError(error: error))
                        default:
                            completion(nil, APIError.unknownError(error: error))
                        }
                    }
                    completion(nil, APIError.unknownError(error: error))
                    return
                }
                
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(object, nil)
                } catch {
                    completion(nil, APIError.unknownError(error: error))
                }
            }
        })
        dataTask.resume()
    }
    
    private func buildHeaders(headers: [String: String]?) -> [String: String] {
        var newHeaders = [String: String]()
        newHeaders["Content-Type"] = "application/json"
        if let token = KeychainHelper.shared[.token] {
            newHeaders["Authorization"] = "Bearer \(token)"
        }
        headers?.forEach { newHeaders[$0] = $1 }
        return newHeaders
    }
}
