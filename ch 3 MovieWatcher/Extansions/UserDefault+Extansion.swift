//
//  UserDefault+Extansion.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 15.04.2023.
//

import Foundation


extension UserDefaults {
    private enum UserDefaultKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}
