//
//  CustomTabBarController.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 03.04.2023.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {
    
    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterViewController = NavBarController(rootViewController: SearchViewController())
        let listMovieViewController = NavBarController(rootViewController: RecentWatchViewController())
        let homeViewController = NavBarController(rootViewController: HomeViewController())
        let movieDetailViewController = NavBarController(rootViewController: FavoriteViewController())
        let settingViewController = NavBarController(rootViewController: SettingViewController())
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
        
        selectedIndex = 2
    }
    

}

extension CustomTabBarController {
    func customizeTabBar(_ controller: UINavigationController, name: String) {
        controller.viewControllers[0].title = name
        
        switch name {
        case "Search":
            controller.tabBarItem.title = ""
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarSearch)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarSearchFill)?.withRenderingMode(.alwaysOriginal)
        case "Recent Watch":
            controller.tabBarItem.title = ""
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarRecentWatch)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarRecentWatchFill)?.withRenderingMode(.alwaysOriginal)
        case "Home":
            controller.tabBarItem.title = ""
            controller.tabBarItem.image = UIImage(named: Resources.Image.tabBarHome)?
                .withRenderingMode(.alwaysOriginal)
            
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.tabBarHome)?
                .withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        case "Favorites":
            controller.tabBarItem.title = ""
            controller.tabBarItem.image = UIImage(named: Resources.Image.favourites)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: Resources.Image.favouritesFill)?.withRenderingMode(.alwaysOriginal)
        case "Setting":
            controller.tabBarItem.title = ""
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
