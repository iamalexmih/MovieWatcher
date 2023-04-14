//
//  ThemeManager.swift
//  ch 3 MovieWatcher
//
//  Created by Василий Васильевич on 15.04.2023.
//

import UIKit
import Foundation

class ThemeManager {
    static let shared = ThemeManager()

    private init() {}

    enum Theme: String {
        case light, dark
    }

    var currentTheme: Theme = .light {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: "theme")
        }
    }

    func setTheme() {
        if let savedTheme = UserDefaults.standard.string(forKey: "theme") {
            currentTheme = Theme(rawValue: savedTheme)!
        } else {
            currentTheme = .light
        }

        if currentTheme == .dark {
            applyDarkTheme()
        } else {
            applyLightTheme()
        }
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
