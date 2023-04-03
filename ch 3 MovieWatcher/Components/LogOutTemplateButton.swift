//
//  LogOutTemplateButton.swift
//  ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 03.04.2023.
//

import UIKit

class LogOutTemplateButton: UIButton {

    var cornerRadius: CGFloat = 25
    var fontSize: CGFloat = 20
    
    var defaultText = "Log Out"
    var titleColor: UIColor = .purple
    var bgColor: UIColor = .clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupButton() {
       setTitleColor(titleColor, for: .normal)
       setTitle(defaultText, for: .normal)
       
       backgroundColor = bgColor
       titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
       
       layer.borderColor = titleColor.cgColor
       layer.borderWidth = 2
       layer.cornerRadius = cornerRadius
    }
    
    func customizeButton(title: String?, newTitleColor: UIColor?, newBackgroundColor: UIColor?) {
        
        if let title = title,
           let newTitleColor = newTitleColor,
           let newBackgroundColor = newBackgroundColor {
            defaultText = title
            titleColor = newTitleColor
            bgColor = newBackgroundColor
            
            setupButton()
        }
    }
}
