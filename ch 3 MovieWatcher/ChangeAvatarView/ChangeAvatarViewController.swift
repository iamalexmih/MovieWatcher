//
//  ChangeAvatarViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit

class ChangeAvatarViewController: UIViewController {
    var imageView = UIImageView()
    let settingsAvatar = ProfileViewController()
    
    private let pageContainer = UIView()
    private let titleLabel = UILabel()
    private let line = UIView()
    private let takePhoto = ImageLabelButton(image: "camera", title: "  Make a Photo")
    private let chooseFile = ImageLabelButton(image: "photo.on.rectangle.angled", title: "  Choose from your library")
    private let deletePhoto = ImageLabelButton(image: "trash", title: "  Delete Photo")
    private var saveButton = CustomButton(title: "Save Changes")
    private let stack = UIStackView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        modalPresentationStyle = .fullScreen
//        modalTransitionStyle = .flipHorizontal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBlur()
        setPageContainer()
        addActionsToButtons()
        
        navigationItem.hidesBackButton = true 
    }
}

// MARK: - Navigation and Picker
extension ChangeAvatarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func addActionsToButtons() {
        takePhoto.addTarget(self, action: #selector(makePhoto), for: .touchUpInside)
        chooseFile.addTarget(self, action: #selector(photoPicker), for: .touchUpInside)
        deletePhoto.addTarget(self, action: #selector(deletePicker), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonPress), for: .touchUpInside)
    }
    
    // choose photo from picker
    @objc func makePhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true)
        }
    }
    
    // choose file from picker
    @objc func photoPicker(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true)
        }
    }
    
    @objc func deletePicker(_ sender: UIButton) {
        print("delete")
        imageView.image = UIImage(systemName: "person.fill")
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image

            print(image.size)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    @objc func saveButtonPress(_ sender: UIButton) {
        settingsAvatar.ava = imageView
        self.dismiss(animated: true)
    }
}


// MARK: - Extension for Constraints
extension ChangeAvatarViewController {
    private func setBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func setPageContainer() {
        view.addSubview(pageContainer)

        pageContainer.translatesAutoresizingMaskIntoConstraints = false
        pageContainer.addSubview(titleLabel)
        pageContainer.backgroundColor = UIColor(named: Resources.Colors.backGround)

        titleLabel.text = "Change your picture"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(named: Resources.Colors.text)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        pageContainer.addSubview(line)
        line.backgroundColor = UIColor(named: Resources.Colors.categoryColour)
        line.translatesAutoresizingMaskIntoConstraints = false

        pageContainer.addSubview(stack)
        stack.addArrangedSubview(takePhoto)
        stack.addArrangedSubview(chooseFile)
        stack.addArrangedSubview(deletePhoto)
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        pageContainer.addSubview(saveButton)

        takePhoto.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        chooseFile.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        deletePhoto.setTitleColor(.red, for: .normal)
        deletePhoto.tintColor = .red
        deletePhoto.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        pageContainer.backgroundColor = UIColor(named: Resources.Colors.backGround)
        pageContainer.layer.masksToBounds = true
        pageContainer.layer.cornerRadius = 12

        pageContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(180)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }

        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(80)
            make.height.equalTo(1)
        }

        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(100)
//            make.bottom.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(stack.snp_bottomMargin).inset(-20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
