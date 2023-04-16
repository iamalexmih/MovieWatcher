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
            // for hiding keyboard
            field.textField.delegate = self
            arr.append(field)
        }
        return arr
    }()
    
    let singUpButton = CustomButton(title: "Sign Up")
    
    let loginStack = UIStackView()
    let loginLabel = UILabel()
    let loginButton = UIButton()
    
    // MARK: - Variables
    
    var authModel: AuthModel!
    
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
        
        authModel.destroyNavigationStack(in: navigationController)
    }
    
    // MARK: - Button Logic
    func addActionsToButtons() {
        singUpButton.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }
    
    @objc func signUp(_ sender: UIButton) {
        authModel.checkFields(textFieldArr, isRegistration: true)
        authModel.transitionToMainScreen(controller: self, isRegistration: true)
    }
    
    @objc func login(_ sender: UIButton) {
        let loginVC = LoginViewController()
        authModel.unValidatedEmail = (textFieldArr[2] as? TextFieldWithLabelStack)?.textField.text
        loginVC.authModel = authModel
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    // MARK: - UI Setup section
    func setupUI() {
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        
        [titleLabel, subtitleLabel, topStack,
         middleStack, singUpButton, loginStack, loginLabel, loginButton].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setuTopStack()
        setupMiddleStack()
        setupLoginStack()
        setConstraints()
        getEmailFromPreviousScreen()
        configureTapGesture()
    }
    
    // hiding keyboard
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func getEmailFromPreviousScreen() {
        if let email = authModel.unValidatedEmail {
            (textFieldArr[2] as? TextFieldWithLabelStack)?.textField.text = email
        }
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

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // or textField.resignFirstResponder()
        return true
    }
}
