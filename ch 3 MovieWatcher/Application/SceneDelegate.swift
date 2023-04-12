//
//  SceneDelegate.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit



// swiftlint:disable all
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

//        let settingViewController = SettingViewController()
//        let tabBar = CustomTabBarController()
        let navControllerForAuth = NavBarController(rootViewController: AuthViewController())
//        let onBoardingViewController = OnBoardingViewController()
    
        window?.rootViewController = navControllerForAuth
        window?.makeKeyAndVisible()
    }
}

