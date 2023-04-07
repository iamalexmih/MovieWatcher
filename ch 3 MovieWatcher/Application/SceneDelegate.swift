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
        let testComponentsViewController = TestComponentsViewController()
        let tabBar = CustomTabBarController()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}

