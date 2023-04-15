//
//  MoviewDetails.swift
//  ch 3 MovieWatcher
//
//  Created by Луиза Самойленко on 06.04.2023.
//

import UIKit
import SnapKit

class MovieDetailsView: UIView {
    var detailImageView = UIImageView()
    var detailTiTleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure() {
        configureDetailImageView()
        configureDetailTiTleLabel()
    }

    func configureDetailImageView() {
        addSubview(detailImageView)
        detailImageView.image = UIImage(named: Resources.Image.calendarImage)?.withRenderingMode(.alwaysTemplate)
        detailImageView.tintColor = UIColor(named: Resources.Colors.cellIcon)
        detailImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(16)
        }
    }

    func configureDetailTiTleLabel() {
        addSubview(detailTiTleLabel)
        detailTiTleLabel.text = "Some Text"
        detailTiTleLabel.textColor = UIColor(named: Resources.Colors.secondText)
        detailTiTleLabel.numberOfLines = 0
        detailTiTleLabel.font = .jakartaRomanMedium(size: 12) // изменить
        detailTiTleLabel.snp.makeConstraints { make in
            make.left.equalTo(detailImageView.snp.right).inset(-6)
            make.right.equalToSuperview()
            make.centerY.equalTo(detailImageView)
        }
    }
}
