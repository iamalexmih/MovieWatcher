//
//  ViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button = GoogleButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .blue
        
    }
    
}

