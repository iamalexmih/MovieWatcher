//
//  RegisterViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 06.04.2023.
//

import UIKit
import SnapKit


class RegisterViewController: UIViewController {
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let label = UILabel()
        view.addSubview(label)
        if let email = email {
            label.text = email
        } else {
            label.text = "error"
        }
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .blue
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
}
