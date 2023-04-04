//
//  TestComponentsViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit
import SnapKit



class TestComponentsViewController: UIViewController {
    
    let googleButton = GoogleButton(type: .system)
    let textFieldWithLabel = TextFieldWithLabel()
    let searchTextField = SearchTextField()
    let logOutTemplateButton = LogOutTemplateButton()
    let customButton = CustomButton(title: "Custom Button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray

        addGoogleButtonOnView()
        addTextFieldWithLabel()
        addSearchTextField()
        addLogOutTemplateButton()
        addCustomButton()
    }
    
    func addGoogleButtonOnView() {
        view.addSubview(googleButton)
        
        googleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(50)
            make.height.equalTo(60)
            make.width.equalTo(250)
        }
    }
    
    func addTextFieldWithLabel() {
        view.addSubview(textFieldWithLabel)
        
        textFieldWithLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(googleButton.snp.bottom).offset(50)
            make.height.equalTo(100)
        }
    }
    
    func addSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(textFieldWithLabel.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
    }
    
    
    func addLogOutTemplateButton() {
        view.addSubview(logOutTemplateButton)
        
        logOutTemplateButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(searchTextField.snp.bottom).offset(50)
            make.height.equalTo(60)
        }
    }
    
    func addCustomButton() {
        view.addSubview(customButton)
        
        customButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(logOutTemplateButton.snp.bottom).offset(50)
            make.height.equalTo(60)
        }
    }
}
