//
//  InteractivePageIndicator.swift
//  ch 3 MovieWatcher
//
//  Created by Луиза Самойленко on 10.04.2023.
//

import UIKit
import SnapKit

class InteractivePageIndicator: UIView {

    private let stackview = UIStackView()
    private let pages: Int
    private(set) var currentPage: Int

    init(pages: Int, currentPage: Int = 0) {
        self.pages = pages
        self.currentPage = currentPage
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubview(stackview)
        stackview.spacing = 8
        stackview.axis = .horizontal
        stackview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configureDots()
        setPage(Float(currentPage))
    }

    func setPage(_ page: Float) {
        var newIndex = page > Float(currentPage) ? currentPage + 1 : currentPage - 1
        if page == Float(currentPage) {
            newIndex = currentPage
        }
        let delta = abs(page - Float(currentPage))
        let oldProgress = 1 - delta
        let fullDotWidth: Float = 24
        let oldWidth = max(oldProgress * fullDotWidth, 8)
        let newWidth = max(delta * fullDotWidth, 8)
        let disabledColor = UIColor(named: Resources.Colors.secondText)!
        let activeColor = UIColor(named: Resources.Colors.accent)!

        for index in 0..<pages {
            let dot = stackview.arrangedSubviews[index]
            dot.backgroundColor = index == newIndex ? activeColor : disabledColor
            var width: CGFloat = 8
            if index == currentPage {
                width = CGFloat(oldWidth)
            } else if index == newIndex {
                width = CGFloat(newWidth)
            }
            dot.snp.remakeConstraints { make in
                make.height.equalTo(8)
                make.width.equalTo(width)
            }
        }
        if page == round(page) {
            currentPage = Int(page)
        }
    }

    private func configureDots() {
        for _ in 0..<pages {
            let dot = UIView()
            dot.layer.cornerRadius = 4
            dot.layer.masksToBounds = true
            dot.backgroundColor = .red
            dot.snp.makeConstraints { make in
                make.width.height.equalTo(8)
            }
            stackview.addArrangedSubview(dot)
        }
    }
}
