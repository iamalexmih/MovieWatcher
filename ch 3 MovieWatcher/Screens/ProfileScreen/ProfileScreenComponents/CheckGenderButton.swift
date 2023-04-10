//
//  CheckGenderButton.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 09.04.2023.
//

import UIKit
import SnapKit



public enum HumanGender: String {
    case male = "Male"
    case female = "Female"
}



class CheckGenderButton: UIButton {
    private var type: HumanGender = .male
    
    let labelTitle = UILabel()
    let checkIcon = UIImageView()
    
        
    // MARK: - Init
    
    init(with type: HumanGender) {
        super.init(frame: .zero)
        self.type = type
        labelTitle.text = type.rawValue
        addViews()
        constraints()
        configAppearance()
        makeSystem(self)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        
        addViews()
        constraints()
    }
    
    
    func addViews() {
        addSubviews(labelTitle, checkIcon)
    }
    
    
    func constraints() {
        checkIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        labelTitle.snp.makeConstraints { make in
            make.leading.equalTo(checkIcon.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configAppearance() {
        layer.borderColor = UIColor(named: Resources.Colors.accent)?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 26
        layer.masksToBounds = true
        
        checkIcon.image = UIImage(systemName: "circle")
        checkIcon.tintColor = UIColor(named: Resources.Colors.accent)
        
        labelTitle.font = UIFont.jakartaRomanSemiBold(size: 16)
        labelTitle.textColor = UIColor(named: Resources.Colors.text)
    }
}
