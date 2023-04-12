//
//  NavBarController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 13.04.2023.
//

import UIKit


final class NavBarController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        config()
    }

    
    private func config() {
        navigationBar.backgroundColor = .clear
        navigationBar.backIndicatorImage = UIImage(named: Resources.Image.arrowBack)
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: Resources.Image.arrowBack)
        navigationBar.tintColor = .label
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}
