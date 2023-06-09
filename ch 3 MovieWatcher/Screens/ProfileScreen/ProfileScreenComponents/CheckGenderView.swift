//
//  CheckGenderView.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 10.04.2023.
//

import UIKit


class CheckGenderView: UIView {
    private let titleLabel = UILabel()
    private let maleButton = CheckGenderButton(with: .male)
    private let femaleButton = CheckGenderButton(with: .female)
    
    private let stackViewHorizontal = UIStackView()
    
    var selectedGender: HumanGender?
//    {
//        if self.maleButton.isTapped {
//            self.femaleButton.isTapped = false
//            // self.femaleButton.updateImage()
//            return HumanGender.male
//        } else {
//            self.maleButton.isTapped = false
//            // self.maleButton.updateImage()
//                return HumanGender.female
//            }
//    }
    
    func manageGender() {
        if maleButton.isTapped {
            selectedGender = .male
            femaleButton.isTapped = false
            femaleButton.updateImage()
        } else if femaleButton.isTapped {
            selectedGender = .female
            maleButton.isTapped = false
            maleButton.updateImage()
        }
    }
    
    func loadUserGender(_ gender: HumanGender) {
        if gender == .male {
            maleButton.isTapped = true
            manageGender()
        } else {
            femaleButton.isTapped = true
            manageGender()
        }
    }
    
    @objc func genderButtonTapped(_ sender: CheckGenderButton) {
        sender.isTapped.toggle()
        manageGender()
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addViews()
        constraints()
        configAppearance()
        
        maleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        
        addViews()
        constraints()
    }
    
    
    func addViews() {
        self.addSubviews(titleLabel, stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(maleButton)
        stackViewHorizontal.addArrangedSubview(femaleButton)
    }
    
    
    func constraints() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
        }
        stackViewHorizontal.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).inset(-8)
        }
    }
    
    private func configAppearance() {
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 16
        stackViewHorizontal.distribution = .fillEqually
        
        titleLabel.text = "Gender"
        titleLabel.font = .jakartaMedium(size: 14)
        titleLabel.textColor = UIColor(named: Resources.Colors.secondText)
    }
}

