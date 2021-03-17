//
//  KeychainHelper.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import KeychainAccess

class KeychainHelper {
    
    enum Key: String {
        case token
    }
    
    static let shared = KeychainHelper()
    
    private let keychain = KeychainAccess.Keychain(server: domain, protocolType: .http)
    
    subscript(_ key: Key) -> String? {
        get { return keychain[key.rawValue] }
        set { keychain[key.rawValue] = newValue }
    }
    
    subscript(data key: Key) -> Data? {
        get { return keychain[data: key.rawValue] }
        set { keychain[data: key.rawValue] = newValue }
    }
    
    func remove(_ key: Key) throws {
        try keychain.remove(key.rawValue)
    }
    
    func set(_ data: Data, key: Key) throws {
        try keychain.set(data, key: key.rawValue)
    }
    
    func set(_ text: String, key: Key) throws {
        try keychain.set(text, key: key.rawValue)
    }
}
