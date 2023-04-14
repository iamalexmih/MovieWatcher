//
//  AuthViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 06.04.2023.
//

import UIKit
import SnapKit
import Firebase

// Simple password validation -- DONE
// hookup with firebase -- DONE
// add "cont with google func"
// Add slide animation


class AuthViewController: UIViewController {
    
    // MARK: - UI Elements
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    let topStack = UIStackView()
    
    var logo = UIImageView()
    
    let authOptionsView = UIView()
    let bottomStack = UIStackView()
    
    let emailTextField = TextFieldWithLabelStack(labelText: "Email",
                                                 placeholderText: "Enter your email address",
                                                 isSecure: false)
    let emailButton = CustomButton(title: "Continue with Email")
    let tempLabel = UILabel()
    let googleButton = GoogleButton()
    
    let loginStack = UIStackView()
    let loginLabel = UILabel()
    let loginButton = UIButton()
    
    // MARK: - Variables
    

    
    // MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupUI()
        addActionsToButtons()
        presentAuthOptions()
        checkAuth()
    }
    
    func presentAuthOptions() {

    }
    
    private func checkAuth() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                let rootTabBar = CustomTabBarController()
                rootTabBar.modalTransitionStyle = .flipHorizontal
                rootTabBar.modalPresentationStyle = .fullScreen
                self.present(rootTabBar, animated: true)
            }
        }
    }
    
    
    // MARK: - Button Logic

    func addActionsToButtons() {
        emailButton.addTarget(self, action: #selector(continueWithEmail(_:)), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(continueWithGoogle(_:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }
    
    @objc func continueWithEmail(_ sender: UIButton) {
        let regVC = RegisterViewController()
        regVC.authModel = AuthModel()
        regVC.authModel.unValidatedEmail = getEmail()
        navigationController?.pushViewController(regVC, animated: true)
    }
    
    @objc func continueWithGoogle(_ sender: UIButton) {
        
    }
    
    @objc func login(_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.authModel = AuthModel()
        loginVC.authModel?.unValidatedEmail = getEmail()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func getEmail() -> String? {
        return emailTextField.textField.text
    }
    
    // MARK: - UI Setup section
    func setupUI() {
        view.backgroundColor = UIColor(named: Resources.Colors.accent)
        
        [topStack, titleLabel, subtitleLabel, logo, authOptionsView].forEach { item in
           view.addSubview(item)
           item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setuTopStack()
        
        logo.image = UIImage(named: Resources.Image.googleSymbol)
        
        setupBottomStack()
        setConstraints()
    }
    
    func setuTopStack() {
        topStack.addArrangedSubview(titleLabel)
        topStack.addArrangedSubview(subtitleLabel)
        topStack.axis = .vertical
        topStack.spacing = 8
        topStack.alignment = .center
        
        titleLabel.text = "Create account"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(named: Resources.Colors.justWhite)
        
        subtitleLabel.text = "Some gibberish text to fill in empty space"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.textColor = UIColor(named: Resources.Colors.justWhite)
    }
    
    func setupBottomStack() {
        [
            bottomStack,
            emailTextField,
            emailButton,
            tempLabel,
            googleButton,
            loginStack,
            loginLabel,
            loginButton
        ].forEach {authOptionsView.addSubview($0)}
        
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        authOptionsView.backgroundColor = UIColor(named: Resources.Colors.backGround)

        authOptionsView.layer.cornerRadius = 20
        
        tempLabel.text = "Or Continue With"
        tempLabel.textColor = UIColor(named: Resources.Colors.secondText)
        
        var stackArr = [emailTextField, emailButton, tempLabel, googleButton]
        
        stackArr.forEach {bottomStack.addArrangedSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false}
        bottomStack.axis = .vertical
        bottomStack.distribution = .equalCentering
        bottomStack.spacing = 10
        
        stackArr.removeFirst()
        stackArr.forEach { element in
            element.snp.makeConstraints { make in
                make.height.equalTo(65)
            }
        }
        
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
            make.top.equalToSuperview().inset(74)
        }
        
        logo.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        authOptionsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.height-200)
            make.top.equalToSuperview().inset(200)
            make.bottom.equalToSuperview()
        }
        
        bottomStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.trailing.leading.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(250)
        }
        
        loginStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(93)
            make.leading.trailing.equalToSuperview().inset(65)
        }
    }
    
}


// MARK: - TextField Delegate Ext

extension AuthViewController: UITextFieldDelegate {
    
}
