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

        let settingViewController = SettingViewController()
        let testComponentsViewController = TestComponentsViewController()
        let tabBar = CustomTabBarController()
        let navControllerForAuth = UINavigationController.init(rootViewController: AuthViewController())
        let onBoardingViewController = OnBoardingViewController()
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.left.circle.fill")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left.circle.fill")
        UINavigationBar.appearance().backgroundColor = UIColor(named: Resources.Colors.backGround)
        UINavigationBar.appearance().tintColor = .systemGray
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}

