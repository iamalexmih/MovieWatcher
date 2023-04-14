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
    private let dateBirthView = TextFieldWithLabel(labelText: "Date of Birth",
                                                   textFieldPlaceHolder: "Enter your date of birth")
    private let locationView = TextViewWithLabel(labelText: "Location",
                                                 placeholderText: "Enter your location address")
    private let checkGenderView = CheckGenderView()
    let stackView = UIStackView()
    private var arrayElemets: [UIView] = []
    private var scrollViewBottom: NSLayoutConstraint?

    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        configure()
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

    private func configure() {
        configureBottomView()
        configureSaveButton()
        configureScrollView()
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
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }

    private func configureContainerView() {
        scrollView.addSubview(containerView)
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func configureAvatarImage() {
        containerView.addSubview(avatarImageView)
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
        containerView.addSubviews(editButton)
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
        view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor(named: Resources.Colors.backGround)

        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }

    private func configureSaveButton() {
        bottomView.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonPress), for: .touchUpInside)
        saveButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
        }
    }

    private func configureStackView() {
        containerView.addSubview(stackView)
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

    @objc
    private func editPhoto() {
        print("Edit photo")
    }

    @objc
    private func saveButtonPress() {
        print("Save changes")
    }
}
