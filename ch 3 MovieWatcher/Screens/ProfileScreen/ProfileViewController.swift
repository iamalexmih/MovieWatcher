//
//  ProfileViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit



final class ProfileViewController: UIViewController {
    
    private let avatarView = UIImageView()
    
    private let firstNameView = TextFieldWithLabel(labelText: "First Name",
                                           textFieldPlaceHolder: "Enter your first name")
    
    private let lastNameView = TextFieldWithLabel(labelText: "Last Name",
                                          textFieldPlaceHolder: "Enter your last name")
    
    private let emailView = TextFieldWithLabel(labelText: "E-mail",
                                       textFieldPlaceHolder: "Enter your E-mail")
    
    private let dateBirthView = TextFieldWithLabel(labelText: "Date of Birth",
                                           textFieldPlaceHolder: "Enter your date of birth")
    
    private let locationView = TextViewWithLabel(labelText: "Location",
                                         placeholderText: "Enter your location address")
    
    private let checkGenderView = CheckGenderView()

    
    private let buttonSaveChanges = CustomButton(title: "Save Changes")
    let stackView = UIStackView()
    private var arrayElemets: [UIView] = []
    
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayElemets = [firstNameView, lastNameView, emailView, dateBirthView, checkGenderView]
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        addSubView()
        setConstraints()
        avatarViewConfigure()
        
    }
    
    private func addSubView() {
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubviews(stackView, buttonSaveChanges)
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(firstNameView)
        stackView.addArrangedSubview(lastNameView)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(dateBirthView)
        stackView.addArrangedSubview(checkGenderView)
//        stackView.addArrangedSubview(locationView)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalTo(buttonSaveChanges.snp.top).inset(-60)
        }
        
        avatarView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
        }
        
        arrayElemets.forEach { $0.snp.makeConstraints { $0.height.equalTo(82) } }
        
        locationView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        buttonSaveChanges.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(34)
        }
    }
    
    
    private func avatarViewConfigure() {
        avatarView.image = UIImage(systemName: "person.fill")
        avatarView.contentMode = .scaleAspectFit
    }
}
