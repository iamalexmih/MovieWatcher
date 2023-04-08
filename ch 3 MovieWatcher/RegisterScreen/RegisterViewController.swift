//
//  RegisterViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 06.04.2023.
//

import UIKit
import SnapKit


class RegisterViewController: UIViewController {
    
    // MARK: - UI Elements
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    let topStack = UIStackView()
    
      
    let middleStack = UIStackView()
    
    lazy var textFieldArr: [UIView] = {
       
        var arr: [UIView] = []
        
        let names = [
        ("First Name", "Enter your name"),
        ("Last Name", "Enter your surname"),
        ("E-mail", "Enter your email address"),
        ("Password", "Enter your password"),
        ("Confirm Password", "Confirm your password")
        ]
        
        for (label, placeholder) in names {
            let isSecure = label.contains("Password") ? true : false
            let field = TextFieldWithLabelStack(labelText: label, placeholderText: placeholder, isSecure: isSecure)
            arr.append(field)
        }
        return arr
    }()
 
    let singUpButton = CustomButton(title: "Sign Up")
    
    let loginStack = UIStackView()
    let loginLabel = UILabel()
    let loginButton = UIButton()
    
    // MARK: - Variables
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
  
    // MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        title = "Sign Up"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationItem.backBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left.circle.fill"),
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.tintColor = UIColor(named: Resources.Colors.secondText)
        setupUI()
        addActionsToButtons()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let navArray = navigationController?.viewControllers else {return}
        if navArray.count > 2 {
            navigationController?.viewControllers.remove(at: 1)
        }
        
    }
    
    // MARK: - Button Logic
    func addActionsToButtons() {
        singUpButton.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }
    
    @objc func signUp(_ sender: UIButton) {
//        email = validatedEmail()
//        let regVC = RegisterViewController()
//        regVC.email = email
//        navigationController?.pushViewController(regVC, animated: true)
    }
        
    @objc func login(_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.email = email
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
//    func validatedEmail() -> String {
//        if let email = emailTextField.textField.text {
//            return email
//        }
//        return "error"
//    }
    
    // MARK: - UI Setup section
    func setupUI() {
        view.backgroundColor = .systemBackground
       
        [titleLabel, subtitleLabel, topStack,
         middleStack, singUpButton, loginStack, loginLabel, loginButton].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setuTopStack()
        setupMiddleStack()
        setupLoginStack()
        setConstraints()
    }
    
    func setuTopStack() {
        
        topStack.addArrangedSubview(titleLabel)
        topStack.addArrangedSubview(subtitleLabel)
        topStack.axis = .vertical
        topStack.spacing = 8
        topStack.alignment = .center
        
        titleLabel.text = "Complete your account"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(named: Resources.Colors.text)
        
        subtitleLabel.text = "Some gibberish text to fill in empty space"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = UIColor(named: Resources.Colors.secondText)
    }
    
    func setupMiddleStack() {
       
        textFieldArr.append(singUpButton)
        textFieldArr.forEach {view.addSubview($0)}
        textFieldArr.forEach {middleStack.addArrangedSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false}
        
        middleStack.axis = .vertical
        middleStack.distribution = .equalCentering
        middleStack.spacing = 15
        
    }
    
    func setupLoginStack() {

        loginButton.isUserInteractionEnabled = true
        
        loginStack.addArrangedSubview(loginLabel)
        loginStack.addArrangedSubview(loginButton)
        loginStack.axis = .horizontal
        
        loginLabel.text = "Already have an account?"
        loginLabel.textColor = UIColor(named: Resources.Colors.secondText)
        loginLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor(named: Resources.Colors.accent), for: .normal)
  
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
        
        singUpButton.snp.makeConstraints({$0.height.equalTo(54)})
        
        loginStack.snp.makeConstraints { make in
            make.top.equalTo(middleStack.snp_bottomMargin).inset(-24)
            make.bottom.lessThanOrEqualTo(view.snp_bottomMargin).inset(43)
            make.leading.trailing.equalToSuperview().inset(65)
        }
    }
    
    
}
