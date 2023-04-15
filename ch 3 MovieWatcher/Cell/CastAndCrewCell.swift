//
//  CastAndCrewCell.swift
//  ch 3 MovieWatcher
//
//  Created by Луиза Самойленко on 06.04.2023.
//

import UIKit

class CastAndCrewCell: UICollectionViewCell {
    static let reuseId = "CastAndCrewCell"

    var castAndCrewPhoto = UIImage(systemName: "person.crop.circle.badge.questionmark.fill")
    var nameLabelText = "Jon Watts"
    var roleLabelText = "Director"

    lazy var photoImageView = UIImageView()
    lazy var stackView = UIStackView()
    lazy var nameLabel = UILabel()
    lazy var roleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
//        contentView.backgroundColor = .clear
    }
    
    // network for configure cell in castCrew -- kompot -- work 
    func configureNetworkCell(cast: Cast) {
        guard let name = cast.name else { return }
        nameLabel.text = name
        
        guard let role = cast.known_for_department else { return }
        roleLabel.text = role
        
        guard let photoPath = NetworkService.shared.makeUrlForPhoto(photoPath: cast.profile_path) else { return }
        let urlPhoto = URL(string: photoPath)
        photoImageView.kf.setImage(with: urlPhoto, placeholder: UIImage(systemName: "person.crop.circle.badge.questionmark.fill"))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        configurePhotoImageView()
        configureStackView()
        configureNameLabel()
        configureRoleLabel()
    }

    private func configurePhotoImageView() {
        contentView.addSubview(photoImageView)
        photoImageView.image = castAndCrewPhoto
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 20
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView)
            make.left.equalTo(photoImageView.snp.right).inset(-8)
            make.top.bottom.equalTo(photoImageView)
            make.right.equalToSuperview()
        }
    }

    private func configureNameLabel() {
        stackView.addArrangedSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor(named: Resources.Colors.text)
        nameLabel.font = .jakartaRomanSemiBold(size: 14)
        nameLabel.text = nameLabelText
    }

    private func configureRoleLabel() {
        stackView.addArrangedSubview(roleLabel)
        roleLabel.numberOfLines = 0
        roleLabel.textColor = UIColor(named: Resources.Colors.secondText)
        roleLabel.font = .jakartaMedium(size: 10)
        roleLabel.text = roleLabelText
    }
}

