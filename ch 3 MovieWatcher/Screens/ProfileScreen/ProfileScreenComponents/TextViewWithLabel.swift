//
//  TextViewWithLabel.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 09.04.2023.
//

import UIKit
import SnapKit

class TextViewWithLabel: UIStackView {

    private var labelText: String = "Location"
    private var placeholderText: String = "Enter your location address"
    
    var label = UILabel()
    var textView = UITextView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupLabelAndTexField()
        textView.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    init(labelText: String, placeholderText: String) {
        super.init(frame: .zero)
        
        self.labelText = labelText
        self.placeholderText = placeholderText
        
        setupStackView()
        setupLabelAndTexField()
    }
    
    private func setupStackView() {
        self.axis = .vertical
        self.spacing = 8
        
        self.addArrangedSubview(label)
        self.addArrangedSubview(textView)
    }
    
    private func setupLabelAndTexField() {
        label.text = labelText
        label.font = .jakartaMedium(size: 14)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .secondaryLabel
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.snp.makeConstraints { make in
            make.height.equalTo(130)
        }
                
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1
        
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor(named: Resources.Colors.accent)?.cgColor
    }
    
}


// MARK: - add Placeholder for textView
extension TextViewWithLabel: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {

        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // placeholderText
        if updatedText.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor(named: Resources.Colors.secondText)
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument,
                                                            to: textView.beginningOfDocument)
        }

        // Text
         else if textView.textColor == UIColor(named: Resources.Colors.secondText) && !text.isEmpty {
            textView.textColor = UIColor(named: Resources.Colors.text)
            textView.text = text
        } else {
            return true
        }

        return false
    }
}
