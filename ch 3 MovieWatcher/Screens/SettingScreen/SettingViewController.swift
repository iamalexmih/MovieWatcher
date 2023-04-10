import UIKit
import SnapKit

class SettingViewController: UIViewController {

    let headerLabel = UILabel()
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
    var isDarkModeEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: Resources.Colors.backGround)

        setupHeaderView()
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

    func setupHeaderView() {
        headerLabel.text = "Setting"
        headerLabel.font = UIFont.jakartaRomanSemiBold(size: 18)

        let headerView = UIView()
        headerView.addSubview(headerLabel)
        view.addSubview(headerView)

        headerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(63)
            make.centerX.equalToSuperview()
        }
    }

    func setupAvatarView() {
        avatarView.image = UIImage(named: Resources.Image.profileSettingScreen)
        avatarView.contentMode = .scaleAspectFit
        avatarView.layer.cornerRadius = 28
        avatarView.clipsToBounds = true
        view.addSubview(avatarView)

        avatarView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(124)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
    }

    func setupNameLabel() {
        nameLabel.text = "Andy Lexian"
        nameLabel.font = UIFont.jakartaRomanSemiBold(size: 18)
        view.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(124)
            make.left.equalTo(avatarView.snp.right).offset(16)
            make.right.equalToSuperview().inset(24)
        }
    }

    func setupNickNameLabel() {
        nickNameLabel.text = "@Andy1999"
        nickNameLabel.textColor = UIColor(named: Resources.Colors.inactive)
        nickNameLabel.font = UIFont.jakartaRomanSemiBold(size: 18)
        view.addSubview(nickNameLabel)

        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(avatarView.snp.right).offset(16)
            make.right.equalToSuperview().inset(24)
        }
    }

    func setupPersonalInfoLabel() {
        personalInfo.text = "Personal Info"
        personalInfo.font = UIFont.jakartaLight(size: 12)
        view.addSubview(personalInfo)

        personalInfo.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(212)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(268)
        }
    }

    func setupHeadInProfileSetting() {
        headInProfileSetting.image = UIImage(named: Resources.Image.headInProfileSetting)
        headInProfileSetting.contentMode = .scaleAspectFit
        view.addSubview(headInProfileSetting)

        headInProfileSetting.snp.makeConstraints { make in
            make.top.equalTo(personalInfo.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(-15)
            make.right.equalToSuperview().inset(327)
        }
    }

    func setupFleshInProfileSetting() {
        fleshInProfileSetting.image = UIImage(named: Resources.Image.fleshInProfileSetting)
        fleshInProfileSetting.contentMode = .scaleAspectFit
        view.addSubview(fleshInProfileSetting)

        fleshInProfileSetting.snp.makeConstraints { make in
            make.top.equalTo(headInProfileSetting.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(-15)
            make.right.equalToSuperview().inset(327)
        }
    }

    func setupProfileButton() {
        profileButton.setTitle("Profile", for: .normal)
        profileButton.setTitleColor(.black, for: .normal)
        profileButton.titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(profileButton)

        profileButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(288)
        }
    }

    func setupChevronButton() {
        chevronButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = .lightGray
        view.addSubview(chevronButton)

        chevronButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileButton.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-29)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
    }

    func setupSecurityLabel() {

        security.text = "Security"
        security.font = UIFont.jakartaLight(size: 12)
        view.addSubview(security)

        security.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(296)
            make.left.equalToSuperview().offset(24)
        }
    }

    func setupChangePasswordProfileSettingImage() {
        changePasswordProfileSettingImage.image = UIImage(named: Resources.Image.changePasswordProfileSetting)
        view.addSubview(changePasswordProfileSettingImage)
        changePasswordProfileSettingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(387)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupChangePasswordProfileSettingTextButton() {
        changePasswordProfileSettingTextButton.setTitle("Change Password", for: .normal)
        changePasswordProfileSettingTextButton.setTitleColor(.black, for: .normal)
        changePasswordProfileSettingTextButton.titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(changePasswordProfileSettingTextButton)

        changePasswordProfileSettingTextButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(381)
        }
    }

    func setupForgotPasswordProfileSettingImage() {
        forgotPasswordProfileSettingImage.image = UIImage(named: Resources.Image.forgotPasswordProfileSetting)
        view.addSubview(forgotPasswordProfileSettingImage)
        forgotPasswordProfileSettingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(432)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle("Forgot Password", for: .normal)
        forgotPasswordButton.setTitleColor(.black, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(forgotPasswordButton)

        forgotPasswordButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(426)
        }
    }

    func setupDarkModeSettingImage() {
        darkModeSettingImage.image = UIImage(named: Resources.Image.darkModeProfileSetting)
        view.addSubview(darkModeSettingImage)
        darkModeSettingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(475)
            make.left.equalToSuperview().offset(32)
        }
    }

    func setupDarkModeSettingLabel() {
        darkModeSettingLabel.text = "Dark Mode"
        darkModeSettingLabel.font = UIFont.jakartaRomanSemiBold(size: 16)
        view.addSubview(darkModeSettingLabel)

        darkModeSettingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(475)

        }
    }

    func setupToggle() {
        view.addSubview(toggle)
        toggle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(470)
            make.right.equalToSuperview().inset(30)
        }
        toggle.addTarget(self, action: #selector(setupToggleDarkMode), for: .touchUpInside)
    }

    @objc func setupToggleDarkMode() {
        isDarkModeEnabled = !isDarkModeEnabled
        if isDarkModeEnabled {
            view.backgroundColor = .white
            toggle.backgroundColor = .white
        } else {
            view.backgroundColor = .black
            toggle.backgroundColor = .black
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
