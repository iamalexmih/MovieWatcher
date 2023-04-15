//
//  ProfileViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var containerView = UIView()
    private let avatarImageView = UIImageView()
    private let editButton = UIButton()
    private var bottomView = UIView()
    private var saveButton = CustomButton(title: "Save Changes")
    private let firstNameView = TextFieldWithLabel(labelText: "First Name",
                                                   textFieldPlaceHolder: "Enter your first name")
    private let lastNameView = TextFieldWithLabel(labelText: "Last Name",
                                                  textFieldPlaceHolder: "Enter your last name")
    private let emailView = TextFieldWithLabel(labelText: "E-mail",
                                               textFieldPlaceHolder: "Enter your E-mail")
    private let dateBirthView = DateOfBirthPicker(labelText: "Date of Birth",
                                                  placeholderText: "Enter your date of birth")
    private let locationView = TextViewWithLabel(labelText: "Location",
                                                 placeholderText: "Enter your location address")
    private let checkGenderView = CheckGenderView()
    let stackView = UIStackView()
    private var arrayElemets: [UIView] = []

    var scrollViewBottom = 0.0

    private var bottomViewHeight = 100.0

    private var scrollViewBottom: NSLayoutConstraint?
    
    var currentUser: UserModel?
 
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        addViews()
        configure()
        loadUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

extension ProfileViewController {

    // MARK: Actions
    @objc
    private func editPhoto() {
        print("Edit photo")
    }

    @objc
    private func saveButtonPress() {
        print("Save changes")
        saveNewUserData()
    }
    // MARK: Configure and constraints funcs
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubviews(editButton)
        view.addSubview(bottomView)
        bottomView.addSubview(saveButton)
        containerView.addSubview(stackView)
    }

    private func configure() {
        configureBottomView()
        configureSaveButton()
        configureScrollView()
        configurationNotificationCenter()
        configureContainerView()
        configureAvatarImage()
        configureEditButton()
        configureStackView()
        configureNavigationBar()
        configureTapGesture()
    }
    
    private func configureNavigationBar() {
        title = "Profile"
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureScrollView() {
        scrollView.backgroundColor = .clear
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).inset(scrollViewBottom)
            print("в configureScrollView \(scrollViewBottom)")
        }
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureAvatarImage() {
        avatarImageView.image = UIImage(named: Resources.Image.profileSettingScreen)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 50
        
        avatarImageView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(37)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureEditButton() {
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.backgroundColor = UIColor(named: Resources.Colors.accent)
        editButton.tintColor = UIColor(named: Resources.Colors.textFieldBackground)
        editButton.layer.cornerRadius = 15
        editButton.layer.masksToBounds = true
        editButton.addTarget(self, action: #selector(editPhoto), for: .touchUpInside)
        
        editButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalTo(avatarImageView).inset(68)
            make.left.equalTo(avatarImageView).inset(73)
        }
    }
    
    private func configureBottomView() {
        bottomView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(bottomViewHeight)
        }
    }
    
    private func configureSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonPress), for: .touchUpInside)
        saveButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(firstNameView)
        stackView.addArrangedSubview(lastNameView)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(dateBirthView)
        stackView.addArrangedSubview(checkGenderView)
        stackView.addArrangedSubview(locationView)
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
        
        locationView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        arrayElemets = [firstNameView, lastNameView, emailView, dateBirthView, checkGenderView]
        arrayElemets.forEach { $0.snp.makeConstraints { $0.height.equalTo(82) } }
    }


    // MARK: NotificationCenter
    private func configurationNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollViewBottom = -(keyboardSize.height - bottomViewHeight)
            configureScrollView()
            print("в keyboardDidShow \(scrollViewBottom)")
        }
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        scrollViewBottom = 0.0
        configureScrollView()
        print("в keyboardDidHide \(scrollViewBottom)")
    }
}

// MARK: - Extension to work with core data
extension ProfileViewController {
    
    private func loadUser() {
        if let user = UserInfoService.shared.fetchCurrentUserCoreData() {
            currentUser = user
            populateFieldsWithUserData()
        }
    }
    
    private func populateFieldsWithUserData() {
        guard let user = currentUser else {return}
        
        firstNameView.textField.text = user.firstName ?? ""
        lastNameView.textField.text = user.lastName ?? ""
        emailView.textField.text = user.email
        
        dateBirthView.textField.text = convertFromDate(user.dateBirth)
        
        if let gender = user.gender {
            // populate gender view with gender
        }
        
        locationView.textView.text = user.location ?? ""
    }
    
    private func saveNewUserData() {
        if let firstName = firstNameView.textField.text,
           let lastName = lastNameView.textField.text,
           let email = emailView.textField.text,
           let dateString = dateBirthView.textField.text,
           // let genderString = "",
           let location = locationView.textView.text {
            
            let date = convertFromString(dateString)
            
            let updatedUser = UserModel(idUuid: currentUser!.idUuid,
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        dateBirth: date,
                                        gender: HumanGender.male.rawValue,
                                        location: location)
            
            UserInfoService.shared.editingUserInCoreData(userModel: updatedUser)
        }
    }
    
    private func convertFromString(_ str: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        if let str = str {
            return dateFormatter.date(from: str) ?? Date()
        }
        return Date()
    }
    
    private func convertFromDate(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        
        if let date = date {
            
            dateFormatter.dateFormat = "YY/MM/dd"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
