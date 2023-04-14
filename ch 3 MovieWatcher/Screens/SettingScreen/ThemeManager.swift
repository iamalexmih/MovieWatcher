//
//  ThemeManager.swift
//  ch 3 MovieWatcher
//
//  Created by Василий Васильевич on 15.04.2023.
//

import UIKit
import Foundation



enum Theme: String {
    case light, dark
}


class ThemeManager {
    static let shared = ThemeManager()
    private init() {}


    var currentTheme: Theme = .light {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: "theme")
        }
    }

    func setTheme() {
        if loadCurrentTheme() == Theme.light.rawValue {
            currentTheme = .light
            applyLightTheme()
        } else {
            applyDarkTheme()
        }
    }
    
    func loadCurrentTheme() -> String {
        return UserDefaults.standard.string(forKey: "theme") ?? ""
    }

    func applyLightTheme() {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
    }

    func applyDarkTheme() {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    }
}
