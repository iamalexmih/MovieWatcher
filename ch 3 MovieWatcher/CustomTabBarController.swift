//
//  CustomTabBarController.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 03.04.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterViewController = UINavigationController(rootViewController: FilterViewController())
        let listMovieViewController = UINavigationController(rootViewController: ListMovieViewController())
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let movieDetailViewController = UINavigationController(rootViewController: MoviewDetailViewController())
        let settingViewController = UINavigationController(rootViewController: SettingViewController())
        setViewControllers([filterViewController,
                            listMovieViewController,
                            homeViewController,
                            movieDetailViewController,
                            settingViewController], animated: false)
        
        customizeTabBar(filterViewController, name: "Search")
        customizeTabBar(listMovieViewController, name: "Recent Watch")
        customizeTabBar(homeViewController, name: "Home")
        customizeTabBar(movieDetailViewController, name: "Favorites")
        customizeTabBar(settingViewController, name: "Setting")
    }

}

private extension CustomTabBarController {
    func customizeTabBar(_ controller: UINavigationController, name: String) {
        controller.viewControllers[0].title = name
        
        switch name {
        case "Search":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarSearch)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarSearch)
        case "Recent Watch":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarRecentWatch)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarRecentWatchFill)
        case "Home":
            setupMiddleButton()
        case "Favorites":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarFavorites)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarFavoritesFill)
        case "Setting":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarSetting)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarSettingFill)
        default: break
        }
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))

        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width / 2 - menuButtonFrame.size.width / 2
        menuButton.frame = menuButtonFrame

        menuButton.layer.cornerRadius = menuButtonFrame.height / 2
        view.addSubview(menuButton)

        menuButton.setImage(UIImage(named: Resources.Image.tabBarHome), for: .normal)
        menuButton.imageEdgeInsets.top = -35
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }

    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
}
