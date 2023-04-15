//
//  SceneDelegate.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit



class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        ThemeManager.shared.setTheme()
        
        let screenSaverViewController = ScreenSaverViewController()
//        let onBoardingViewController = OnBoardingViewController()
//        let settingViewController = SettingViewController()
//        let tabBar = CustomTabBarController()
//        let authVC = AuthViewController()
        
        let navController = NavBarController(rootViewController: screenSaverViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

