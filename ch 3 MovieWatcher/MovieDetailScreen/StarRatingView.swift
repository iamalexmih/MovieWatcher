//
//  StarRatingView.swift
//  ch 3 MovieWatcher
//
//  Created by Луиза Самойленко on 07.04.2023.
//

import UIKit
import SnapKit

class StarRatingView: UIView {

    private let stackView: UIStackView = {
        let stars = (1...5).map { _ in
            UIImageView(image: UIImage(named: Resources.Image.starRaitingImage))
        }
        let stackView = UIStackView(arrangedSubviews: stars)
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func configure(rating: Int) {
        for (index, star) in stackView.arrangedSubviews.enumerated() {
            star.tintColor = index < rating
                ? UIColor(named: Resources.Colors.yellowStar)
                : UIColor(named: Resources.Colors.secondText)
        }
    }

    private func commonInit() {
        configureUI()
    }

    private func configureUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

