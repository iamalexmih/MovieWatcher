import UIKit
import SnapKit

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
        setupToggleDarkMode()
        setupLogOutTemplateButton()

    }

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

    func setupToggle() {
        view.addSubview(toggle)
        toggle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(425)
            make.right.equalToSuperview().inset(30)
        }
        toggle.addTarget(self, action: #selector(setupToggleDarkMode), for: .touchUpInside)
    }

    @objc func setupToggleDarkMode() {
        if toggle.isOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }

    func setupLogOutTemplateButton() {
        view.addSubview(logOutTemplateButton)

        logOutTemplateButton.snp.makeConstraints { make in
            make.width.equalTo(367)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(87)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)

            }
        }
    }
