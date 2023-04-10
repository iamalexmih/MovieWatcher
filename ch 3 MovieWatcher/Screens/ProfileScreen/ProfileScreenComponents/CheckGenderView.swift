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
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addViews()
        constraints()
        configAppearance()
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
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    private func configAppearance() {
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 16
        stackViewHorizontal.distribution = .fillEqually
        
        titleLabel.text = "123"
    }
}

