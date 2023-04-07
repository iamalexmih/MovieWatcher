//
//  HomeViewMovieCell.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 07.04.2023.
//

import UIKit

class HomeViewMovieCell: UICollectionViewCell {
    
    static let identifier = "HomeViewMovieCell"
    private let sections = MockData.shared.popularCategory

    
    private let filmImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.contentScaleFactor = 1.0
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "filmPoster")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filmNameLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.minimumScaleFactor = 0.7
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryFilmLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(filmImageView)
        addSubview(categoryFilmLabel)
        addSubview(filmNameLabel)
    }
    
    func configureCell(filmImage: String, categoryFilmName: String, filmName: String) {
        filmImageView.image = UIImage(named: filmImage)
        categoryFilmLabel.text = categoryFilmName
        filmNameLabel.text = filmName
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            filmImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            filmImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            filmNameLabel.leadingAnchor.constraint(equalTo: filmImageView.leadingAnchor, constant: 15),
            filmNameLabel.trailingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: -5),
            filmNameLabel.bottomAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: -15),
            
            categoryFilmLabel.leadingAnchor.constraint(equalTo: filmImageView.leadingAnchor, constant: 15),
            categoryFilmLabel.trailingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: -5),
            categoryFilmLabel.bottomAnchor.constraint(equalTo: filmNameLabel.topAnchor, constant: -5)
                        
        ])
    }
    
}
