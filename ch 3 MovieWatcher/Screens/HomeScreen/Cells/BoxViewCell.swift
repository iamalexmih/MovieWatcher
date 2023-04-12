//
//  BoxViewCell.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 08.04.2023.
//

import UIKit
import SnapKit

class BoxViewCell: UICollectionViewCell {
    
    static let identifier = "BoxViewCell"
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Resources.Image.favourites)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor(named: Resources.Colors.categoryColour)
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let filmImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.contentScaleFactor = 1.0
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryFilmLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.montserratRomanMedium(size: 12)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filmNameLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.jakartaBold(size: 18)
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: Resources.Image.clockImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.montserratRomanMedium(size: 12)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Resources.Image.starRaitingImage)?.withRenderingMode(.alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let starRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.jakartaBold(size: 12)
        label.text = "4.4"
        label.textColor = UIColor(named: Resources.Colors.yellowStar)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let votesNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.jakartaRegular(size: 12)
        label.text = "(54)"
        label.textColor = UIColor(named: Resources.Colors.categoryColour)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private var ratingStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favouriteButtonTapped() {
        print("TAPPED")
    }
    
    func setupView() {
        addSubview(filmImageView)
        addSubview(categoryFilmLabel)
        addSubview(filmNameLabel)
        addSubview(timeImageView)
        addSubview(timeLabel)
        addSubview(favoriteButton)
        ratingStack.addArrangedSubview(starImage)
        ratingStack.addArrangedSubview(starRating)
        ratingStack.addArrangedSubview(votesNumber)
        addSubview(ratingStack)
    }
    
    func configureCell(filmImage: String, categoryFilmName: String, filmName: String, time: Int) {
        filmImageView.image = UIImage(named: filmImage)
        categoryFilmLabel.text = categoryFilmName
        filmNameLabel.text = filmName
        timeLabel.text = "\(time) minutes"
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            
            filmImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            filmImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            filmImageView.widthAnchor.constraint(equalToConstant: 100),
            
            categoryFilmLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            categoryFilmLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
            categoryFilmLabel.heightAnchor.constraint(equalToConstant: 15),
            
            filmNameLabel.topAnchor.constraint(equalTo: categoryFilmLabel.bottomAnchor, constant: 15),
            filmNameLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
            filmNameLabel.heightAnchor.constraint(equalToConstant: 20),

            timeImageView.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 15),
            timeImageView.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
            timeImageView.heightAnchor.constraint(equalToConstant: 13),
            timeImageView.widthAnchor.constraint(equalToConstant: 13),
            
            timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 3),
            timeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            ratingStack.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            ratingStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)

        ])
    }
    
}
