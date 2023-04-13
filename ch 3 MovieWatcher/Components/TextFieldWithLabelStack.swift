//
//  TextFieldWithLabelStack.swift
//  ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 05.04.2023.
//

import UIKit
import SnapKit

class TextFieldWithLabelStack: UIStackView {

    private var labelText: String = "First Name"
    private var placeholderText: String = "Enter your email address"
    private var isSecure = false
    
    var label = UILabel()
    var textField = UITextField()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupLabelAndTexField()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    init(labelText: String, placeholderText: String, isSecure: Bool) {
        super.init(frame: .zero)
        
        self.labelText = labelText
        self.placeholderText = placeholderText
        self.isSecure = isSecure
        
        setupStackView()
        setupLabelAndTexField()
    }
    
    private func setupStackView() {
        self.axis = .vertical
        self.spacing = 8
        
        self.addArrangedSubview(label)
        self.addArrangedSubview(textField)
    }
    
    private func setupLabelAndTexField() {
        label.text = labelText
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textField.isSecureTextEntry = isSecure
        textField.placeholder = placeholderText
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .secondaryLabel
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
    // TODO: Fix dark mode color bug (border doesn't change)
        let textfieldInset = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = textfieldInset
        textField.rightView = textfieldInset
        textField.leftViewMode = .always
        
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: Resources.Colors.textFieldBorder)?.cgColor
        textField.backgroundColor = UIColor(named: Resources.Colors.textFieldBackground)
    }
    
}
