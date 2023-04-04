//
//  TextFieldWithLabel.swift
//  ch 3 MovieWatcher
//
//  Created by Nikita Zubov on 04.04.2023.
//

import UIKit
import SnapKit

class TextFieldWithLabel: UIView {
    
    var textFieldPlaceHolder = "Enter name"
    var labelText = "First Name"
    
    lazy var containerView = UIView()
    lazy var label = UILabel()
    lazy var textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setup()
    }
    
    private func setup() {
        addSubview(containerView)
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(label)
        label.text = labelText
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.font = .systemFont(ofSize: 14)
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.left.equalTo(containerView)
            make.top.equalTo(containerView)
        }
        
        containerView.addSubview(textField)
        textField.backgroundColor = UIColor(named: Resources.Colors.backGround)
        textField.placeholder = textFieldPlaceHolder
        textField.layer.borderColor = UIColor(named: Resources.Colors.accent)?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 24
        let paddingTextField = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingTextField
        textField.leftViewMode = .always
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).inset(-8)
            make.height.equalTo(52)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
    }
}
