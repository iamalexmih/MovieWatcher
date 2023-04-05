//
//  GoogleButton.swift
//  Ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-03.
//

import UIKit

class GoogleButton: UIButton {
        
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
        titleLabel?.font = UIFont(name: Resources.Font.jakartaFontSemiBold, size: 16)
        setTitleColor(UIColor(named: Resources.Colors.text), for: .normal)
        contentMode = .center
        setImage(UIImage(named: Resources.Image.googleSymbol), for: .normal)
        imageEdgeInsets.left = -20
        backgroundColor = UIColor(named: Resources.Colors.backGround)
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        makeSystem(self)
    }
}
