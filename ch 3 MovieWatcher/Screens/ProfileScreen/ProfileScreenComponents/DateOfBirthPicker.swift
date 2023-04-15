//
//  DateOfBirthPicker.swift
//  ch 3 MovieWatcher
//
//  Created by Луиза Самойленко on 15.04.2023.
//

import UIKit

class DateOfBirthPicker: UIStackView {
    private var labelText: String = "Location"
    private var placeholderText: String = "Enter your location address"

    var label = UILabel()
    var contentView = UIView()
    let dateStackView = UIStackView()
    let dateImage = UIImageView()
    var datePicker = UIPickerView()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupStackView()
        setupLabelAndTexField()
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
        dateStackView.axis = .horizontal
        dateStackView.spacing = 8

        self.addArrangedSubview(label)
        self.addArrangedSubview(contentView)
        contentView.addSubview(dateStackView)
        dateStackView.addArrangedSubview(datePicker)
        dateStackView.addArrangedSubview(dateImage)
    }

    private func setupLabelAndTexField() {
        label.text = labelText
        label.font = .jakartaMedium(size: 14)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false

        dateImage.image = UIImage(systemName: "calendar")
        dateImage.tintColor = UIColor(named: Resources.Colors.accent)
        dateImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }

        datePicker.backgroundColor = .red

        contentView.snp.makeConstraints { make in
            make.height.equalTo(52)
        }

        contentView.layer.cornerRadius = 26
        contentView.layer.borderWidth = 1

        contentView.backgroundColor = .clear
        contentView.layer.borderColor = UIColor(named: Resources.Colors.accent)?.cgColor

        dateStackView.backgroundColor = .clear
        dateStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}

extension DateOfBirthPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return coinManager.currencyArray[row]
//    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selectedCurrency = coinManager.currencyArray[row]
//        coinManager.getCoinPrice(for: selectedCurrency)
//    }
}
