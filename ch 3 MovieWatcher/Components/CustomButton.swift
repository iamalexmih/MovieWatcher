//
//  ButtonContinueView.swift
//  ch 3 MovieWatcher
//
//  Created by Василий Васильевич on 04.04.2023.
//

import UIKit

class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 16)
        setTitleColor(.white, for: .normal)
        contentMode = .center
        backgroundColor = UIColor(named: Resources.Colors.accent)
        layer.cornerRadius = 26
        translatesAutoresizingMaskIntoConstraints = false
        makeSystem(self)
    }
}
