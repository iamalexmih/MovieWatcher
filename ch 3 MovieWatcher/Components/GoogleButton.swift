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
        titleLabel?.font = UIFont(name: "Plus Jakarta Sans", size: 16)
        setTitleColor(.black, for: .normal)
        contentMode = .center
        setImage(UIImage(named: "googleSymbol"), for: .normal)
        imageEdgeInsets.left = -20
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
}
