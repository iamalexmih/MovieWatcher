import UIKit
import SnapKit
import FirebaseAuth

class SettingViewController: UIViewController {
    let avatarView = UIImageView()
    let nameLabel = UILabel()
    let nickNameLabel = UILabel()
    let personalInfo = UILabel()
    let headInProfileSetting = UIImageView()
    let fleshInProfileSetting = UIImageView()
    let profileButton = UIButton()
    let chevronButton = UIButton()
    let security = UILabel()
    let changePasswordProfileSettingImage = UIImageView()
    let changePasswordProfileSettingTextButton = UIButton()
    let forgotPasswordProfileSettingImage = UIImageView()
    let forgotPasswordButton = UIButton()
    let darkModeSettingImage = UIImageView()
    let darkModeSettingLabel = UILabel()
    let toggle = UISwitch()
    let logOutTemplateButton = LogOutTemplateButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: Resources.Colors.backGround)

        setupAvatarView()
        setupNameLabel()
        setupNickNameLabel()
        setupPersonalInfoLabel()
        setupHeadInProfileSetting()
        setupFleshInProfileSetting()
        setupProfileButton()
        setupChevronButton()
        setupSecurityLabel()
        setupChangePasswordProfileSettingImage()
        setupChangePasswordProfileSettingTextButton()
        setupForgotPasswordProfileSettingImage()
        setupForgotPasswordButton()
        setupDarkModeSettingImage()
        setupDarkModeSettingLabel()
        setupToggle()
        setAppTheme()
        setupToggleDarkMode()
        setupLogOutTemplateButton()

    }
}

// MARK: Extension
extension SettingViewController {

    func setupAvatarView() {
        avatarView.image = UIImage(named: Resources.Image.profileSettingScreen)
        avatarView.contentMode = .scaleAspectFit
        avatarView.layer.cornerRadius = 28
        avatarView.clipsToBounds = true
        view.addSubview(avatarView)

        avatarView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(144)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
    }

    func setupNameLabel() {
        nameLabel.text = "Andy Lexian"
        nameLabel.textColor = UIColor(named: Resources.Colors.text)
        nameLabel.font = UIFont.jakartaRomanSemiBold(size: 18)
        view.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(92)
            make.top.equalToSuperview().offset(147)
        }
    }

    func setupNickNameLabel() {
        nickNameLabel.text = "@Andy1999"
        nickNameLabel.textColor = UIColor(named: Resources.Colors.inactive)
        nickNameLabel.font = UIFont.jakartaRomanSemiBold(size: 18)
        view.addSubview(nickNameLabel)

        nickNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(92)
            make.top.equalToSuperview().offset(172)
        }
    }

    func setupPersonalInfoLabel() {
        personalInfo.text = "Personal Info"
        personalInfo.textColor = UIColor(named: Resources.Colors.text)
        personalInfo.font = UIFont.jakartaLight(size: 12)
        view.addSubview(personalInfo)

        personalInfo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(222)
        }
    }

    func setupHeadInProfileSetting() {
        let image = UIImage(named: Resources.Image.headInProfileSetting)?.withTintColor(.label)
        headInProfileSetting.image = image
        headInProfileSetting.contentMode = .scaleAspectFit
        view.addSubview(headInProfileSetting)

        headInProfileSetting.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(258)
            make.left.equalToSuperview().offset(35)
        }
    }

    func setupFleshInProfileSetting() {
        let image = UIImage(named: Resources.Image.fleshInProfileSetting)?.withTintColor(.label)
        fleshInProfileSetting.image = image
        fleshInProfileSetting.contentMode = .scaleAspectFit
        view.addSubview(fleshInProfileSetting)

        fleshInProfileSetting.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(268)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupProfileButton() {
        profileButton.setTitle("Profile", for: .normal)
        profileButton.setTitleColor(UIColor(named: Resources.Colors.text), for: .normal)
        profileButton.titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(profileButton)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)

        profileButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(250)
        }
    }

    func setupChevronButton() {
        chevronButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = .lightGray
        view.addSubview(chevronButton)

        chevronButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(260)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
    }

    func setupSecurityLabel() {

        security.text = "Security"
        security.font = UIFont.jakartaLight(size: 12)
        view.addSubview(security)

        security.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(295)
        }
    }

    func setupChangePasswordProfileSettingImage() {
        let image = UIImage(named: Resources.Image.changePasswordProfileSetting)?.withTintColor(.label)
        changePasswordProfileSettingImage.image = image
        changePasswordProfileSettingImage.contentMode = .scaleAspectFit
        view.addSubview(changePasswordProfileSettingImage)
        changePasswordProfileSettingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(332)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupChangePasswordProfileSettingTextButton() {
        changePasswordProfileSettingTextButton.setTitle("Change Password", for: .normal)
        changePasswordProfileSettingTextButton.setTitleColor(UIColor(named: Resources.Colors.text), for: .normal)
        changePasswordProfileSettingTextButton.titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(changePasswordProfileSettingTextButton)
        changePasswordProfileSettingTextButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)

        changePasswordProfileSettingTextButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(325)
        }
    }

    func setupForgotPasswordProfileSettingImage() {
        let image = UIImage(named: Resources.Image.forgotPasswordProfileSetting)?.withTintColor(.label)
        forgotPasswordProfileSettingImage.image = image
        forgotPasswordProfileSettingImage.contentMode = .scaleAspectFit
        view.addSubview(forgotPasswordProfileSettingImage)
        forgotPasswordProfileSettingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(382)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle("Forgot Password", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor(named: Resources.Colors.text), for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)

        forgotPasswordButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(375)
        }
    }

    func setupDarkModeSettingImage() {
        let image = UIImage(named: Resources.Image.darkModeProfileSetting)?.withTintColor(.label)
        darkModeSettingImage.image = image
        darkModeSettingImage.contentMode = .scaleAspectFit
        view.addSubview(darkModeSettingImage)
        darkModeSettingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(430)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupDarkModeSettingLabel() {
        darkModeSettingLabel.text = "Dark Mode"
        darkModeSettingLabel.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(darkModeSettingLabel)

        darkModeSettingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(430)
        }
    }

    func setAppTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }

    func setupToggle() {
        view.addSubview(toggle)
        toggle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(425)
            make.right.equalToSuperview().inset(30)
        }
        toggle.addTarget(self, action: #selector(setupToggleDarkMode), for: .touchUpInside)
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        toggle.isOn = isDarkMode
    }

    @objc func setupToggleDarkMode() {
        let isDarkMode = toggle.isOn
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }

    func setupLogOutTemplateButton() {
        view.addSubview(logOutTemplateButton)
        logOutTemplateButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)

        logOutTemplateButton.snp.makeConstraints { make in
            make.width.equalTo(367)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(87)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)

        }
    }

    @objc
    private func logOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            onExit()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

    private func onExit() {
        let authVC = AuthViewController()
        navigationController?.pushViewController(authVC, animated: true)
    }

    @objc
    private func changePassword() {
        var newPasswordTextField = UITextField()
        let alert = UIAlertController(title: "Enter the password", message: "", preferredStyle: .alert)
        let changeAction = UIAlertAction(title: "Change", style: .default) { _ in
            guard let password = newPasswordTextField.text else { return }
            if (!password.isEmpty) {
                Auth.auth().currentUser?.updatePassword(to: password) { error in
                   print("Error  - updatePassword\(error)")
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alert.addTextField { textfield in
            newPasswordTextField = textfield
            newPasswordTextField.placeholder = "New password"
        }
        alert.addAction(changeAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

    }

    @objc
    private func forgotPassword() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Enter your e-mail", message: "", preferredStyle: .alert)
        let changeAction = UIAlertAction(title: "Get link!", style: .default) { _  in
            guard let email = textField.text else { return }
            if (!email.isEmpty) {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    print("Error sendPasswordReset - \(error)")
                 }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { field in
            textField = field
            textField.placeholder = "E-mail"
        }
        alert.addAction(changeAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    @objc
    private func openProfile() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
