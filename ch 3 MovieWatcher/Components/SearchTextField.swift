import UIKit
import SnapKit

class SearchTextField: UIView {
    let searchImageViewImage = UIImage(systemName: Resources.Image.searchImage)
    let cancelButtonImage = UIImage(systemName: Resources.Image.closeImage)
    let filterButtonImage = UIImage(systemName: Resources.Image.filterImage)
    let iconColor = UIColor(named: Resources.Colors.inactive)
    let buttonsColor = UIColor(named: Resources.Colors.text)
    var textFieldPlaceHolder = "Search"

    lazy var containerView = UIView()
    lazy var stackView = UIStackView()
    lazy var searchImageView = UIImageView()
    lazy var searchTextField = UITextField()
    lazy var cancelButton = UIButton(type: .system)
    lazy var breakView = UIView()
    lazy var filterButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        configureContainerView()
        configureSearchImageView()
        configureSearchTextField()
        configureCancelButton()
        configureBreakView()
        configureFilterButton()
    }

    private func configureContainerView() {
        addSubview(containerView)
        containerView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        containerView.layer.borderColor = UIColor(named: Resources.Colors.accent)?.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 26
        containerView.layer.masksToBounds = true
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configureSearchImageView() {
        containerView.addSubview(searchImageView)
        searchImageView.image = searchImageViewImage
        searchImageView.tintColor = iconColor
        searchImageView.snp.makeConstraints { make in
            make.left.equalTo(containerView).inset(16)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(18)
        }
    }

    private func configureSearchTextField() {
        containerView.addSubview(searchTextField)
        searchTextField.backgroundColor = UIColor(named: Resources.Colors.backGround)
        searchTextField.placeholder = textFieldPlaceHolder
        searchTextField.font = .jakartaMedium(size: 16)
        searchTextField.textColor = UIColor(named: Resources.Colors.text)
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(searchImageView.snp_rightMargin).inset(-16)
            make.height.equalTo(24)
            make.centerY.equalTo(containerView)
        }
    }

    private func configureCancelButton() {
        containerView.addSubview(cancelButton)
        cancelButton.setImage(cancelButtonImage, for: .normal)
        cancelButton.tintColor = buttonsColor
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(searchTextField.snp.right).inset(-8)
            make.width.height.equalTo(18)
            make.centerY.equalTo(containerView)
        }
    }

    private func configureBreakView() {
        containerView.addSubview(breakView)
        breakView.backgroundColor = iconColor
        breakView.snp.makeConstraints { make in
            make.left.equalTo(cancelButton.snp.right).inset(-8)
            make.width.equalTo(1)
            make.height.equalTo(18)
            make.centerY.equalTo(containerView)
        }
    }

    private func configureFilterButton() {
        containerView.addSubview(filterButton)
        filterButton.setImage(filterButtonImage, for: .normal)
        filterButton.tintColor = buttonsColor
        filterButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(breakView.snp.right).inset(-8)
            make.width.height.equalTo(18)
            make.centerY.equalTo(containerView)
        }
    }
}
