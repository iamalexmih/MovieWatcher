//
//  LoginViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 06.04.2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Elements
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    let topStack = UIStackView()
    
      
    let middleStack = UIStackView()
    
    lazy var textFieldArr: [UIView] = {
       
        var arr: [UIView] = []
        
        let names = [
        ("E-mail", "Enter your email address"),
        ("Password", "Enter your password"),
        ]
        
        for (label, placeholder) in names {
            let isSecure = label.contains("Password") ? true : false
            let field = TextFieldWithLabelStack(labelText: label, placeholderText: placeholder, isSecure: isSecure)
            arr.append(field)
        }
        return arr
    }()
 
    let loginButton = CustomButton(title: "Login")
    
    
    // MARK: - Variables
    
    var email: String?
    var password: String?
  
    // MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        title = "Login"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        setupUI()
    }
    
    
    // MARK: - Button Logic
    // TODO: finalize button logic
    func addActionsToButtons() {
        loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }
    
 
    @objc func login(_ sender: UIButton) {
//        email = validatedEmail()
//        let loginVC = LoginViewController()
//        loginVC.email = email
//        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - UI Setup section
    func setupUI() {
        view.backgroundColor = .systemBackground
       
        setuTopStack()
        setupMiddleStack()
        setConstraints()
    }
    
    func setuTopStack() {
        
        [topStack, titleLabel, subtitleLabel].forEach { item in
           view.addSubview(item)
           item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        topStack.addArrangedSubview(titleLabel)
        topStack.addArrangedSubview(subtitleLabel)
        topStack.axis = .vertical
        topStack.spacing = 8
        topStack.alignment = .center
        
        titleLabel.text = "Provide your credentials"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(named: Resources.Colors.text)
        
        subtitleLabel.text = "Some gibberish text to fill in empty space"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = UIColor(named: Resources.Colors.secondText)
    }
    
    func setupMiddleStack() {
        
        view.addSubview(middleStack)
        middleStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        textFieldArr.append(loginButton)
        textFieldArr.forEach {view.addSubview($0)}
        textFieldArr.forEach {middleStack.addArrangedSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false}
        
        middleStack.axis = .vertical
        middleStack.distribution = .equalCentering
        middleStack.spacing = 15
        
    }
    
    
    func setConstraints() {
        topStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(120)
        }
         
        middleStack.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp_bottomMargin).inset(-40)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        loginButton.snp.makeConstraints({$0.height.equalTo(54)})
        
    }
    
    
}
