//
//  UserDefaultManager.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 14.04.2023.
//

import Foundation


class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    private init() {}
    
    
    private let userDefaults = UserDefaults.standard
    private let key = "CurrenUserId"
    
    
    func save(currenUserId: String) {
        userDefaults.set(currenUserId, forKey: key)
    }
    
    
    func load() -> String {
        return userDefaults.string(forKey: key) ?? ""
    }
    
    
    func clear(currenUserId: [String]) {
        userDefaults.removeObject(forKey: key)
    }
}
