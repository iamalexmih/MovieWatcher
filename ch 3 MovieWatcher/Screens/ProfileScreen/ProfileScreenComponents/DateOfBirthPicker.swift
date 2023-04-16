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
    private var dateOfBirth = ""

    var label = UILabel()
    var contentView = UIView()
    let dateStackView = UIStackView()
    let dateButton = UIButton()
    var datePicker = UIDatePicker()
    var dateLabel = UILabel()

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
        configureDatePicker()
        configureDateButton()
    }

    private func setupStackView() {
        self.axis = .vertical
        self.spacing = 8
        dateStackView.axis = .horizontal
        dateStackView.spacing = 8
        dateStackView.alignment = .trailing

        self.addArrangedSubview(label)
        self.addArrangedSubview(contentView)
        contentView.addSubview(dateStackView)
        contentView.addSubview(dateButton)
        contentView.addSubview(dateLabel)
    }

    private func setupLabelAndTexField() {
        label.text = labelText
        label.font = .jakartaMedium(size: 14)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false

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

        dateLabel.isHidden = true
        dateLabel.font = .jakartaMedium(size: 16)
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(dateButton).inset(-8)
        }
    }

    private func configureDatePicker() {
        datePicker.backgroundColor = .clear
        datePicker.datePickerMode = .date
        datePicker.contentHorizontalAlignment = .left
        datePicker.addTarget(self, action: #selector(getDate), for: .valueChanged)
        let loc = Locale(identifier: "en")
        datePicker.locale = loc
        var calendar = Calendar.current
        calendar.locale = loc
        self.datePicker.calendar = calendar
    }

    @objc
    private func getDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        let loc = Locale(identifier: "en")
        dateFormatter.locale = loc

        dateFormatter.dateStyle = DateFormatter.Style.long
        dateOfBirth = dateFormatter.string(from: datePicker.date)
        
        datePicker.isHidden = true
        if datePicker.isHidden {
            dateLabel.isHidden = false
            dateLabel.text = dateOfBirth
        }
        print(dateOfBirth)
    }


    private func configureDateButton() {
        dateButton.setImage(UIImage(named: Resources.Image.calendarImage), for: .normal)
        dateButton.tintColor = UIColor(named: Resources.Colors.accent)
        dateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
        dateButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
            make.width.height.equalTo(20)
        }
    }

    @objc
    private func addDate() {
        dateStackView.addArrangedSubview(datePicker)
        datePicker.isHidden = false
        dateLabel.isHidden = true
    }
}
