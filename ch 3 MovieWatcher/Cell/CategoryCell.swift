//
//  CategoryCell.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-05.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"

     let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(named: Resources.Colors.categoryColour)
        label.font = UIFont(name: Resources.Font.jakartaFont, size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with title: String) {
        categoryLabel.text = title
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        categoryLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
