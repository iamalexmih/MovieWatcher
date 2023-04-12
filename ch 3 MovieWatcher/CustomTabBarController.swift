//
//  CustomTabBarController.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 03.04.2023.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {
    
    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterViewController = UINavigationController(rootViewController: SearchViewController())
        let listMovieViewController = UINavigationController(rootViewController: RecentWatchViewController())
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let movieDetailViewController = UINavigationController(rootViewController: FavoriteViewController())
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

extension CustomTabBarController {
    func customizeTabBar(_ controller: UINavigationController, name: String) {
        controller.viewControllers[0].title = ""
        
        switch name {
        case "Search":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarSearch)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarSearchFill)?.withRenderingMode(.alwaysOriginal)
        case "Recent Watch":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarRecentWatch)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarRecentWatchFill)?.withRenderingMode(.alwaysOriginal)
        case "Home":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarHome)?
                .withRenderingMode(.alwaysOriginal)
            
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarHome)?
                .withRenderingMode(.alwaysOriginal)
        case "Favorites":
            controller.tabBarItem.image = UIImage(named: Resources.Image.favourites)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.favouritesFill)?.withRenderingMode(.alwaysOriginal)
        case "Setting":
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarSetting)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarSettingFill)?.withRenderingMode(.alwaysOriginal)
        default: break
        }
    }

    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
}
