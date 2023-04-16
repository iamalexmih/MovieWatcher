//
//  ImageLabelButton.swift
//  ch 3 MovieWatcher
//
//  Created by Nikita Zubov on 16.04.2023.
//

import UIKit

class ImageLabelButton: UIButton {

    init(image: String, title: String) {
        super.init(frame: .zero)
        
        setImage(UIImage(systemName: image), for: .normal)
        setTitle(title, for: .normal)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        contentHorizontalAlignment = .left
        titleLabel?.font = UIFont.jakartaRomanSemiBold(size: 14)
        setTitleColor(UIColor(named: Resources.Colors.text), for: .normal)
        contentMode = .left
        backgroundColor = UIColor(named: Resources.Colors.buttonPhoto)
        tintColor = UIColor(named: Resources.Colors.text)
        layer.cornerRadius = 8
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 38, bottom: 0, right: 0)
        translatesAutoresizingMaskIntoConstraints = false
        makeSystem(self)
    }
}
