//
//  GoogleButton.swift
//  Ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-03.
//

import UIKit

class GoogleButton: UIButton {
    
    var basicTitleColour: UIColor = UIColor(named: "textColor") ?? .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        setTitle("Continue with Google", for: .normal)
        titleLabel?.font = UIFont(name: "Plus Jakarta Sans", size: 16)
        setTitleColor(basicTitleColour, for: .normal)
        contentMode = .center
        setImage(UIImage(named: "googleSymbol"), for: .normal)
        imageEdgeInsets.left = -20
        backgroundColor = UIColor(named: "bgColor")
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        widthAnchor.constraint(equalToConstant: 327).isActive = true
    }
}
