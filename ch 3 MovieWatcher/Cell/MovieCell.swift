//
//  MovieCell.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit



class MovieCell: UITableViewCell {
    
    static let identifier = "RecipeCell"
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "max")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.text = "Mad Max Collection"
        label.textColor = .black
        label.font = UIFont(name: Resources.Font.jakartaFont, size: 18)
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: Resources.Colors.categoryColour)
        button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func favouriteButtonPressed() {
        print("Favourite PRESSED")
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.addSubview(movieImage)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(movieName)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            movieImage.widthAnchor.constraint(equalToConstant: self.frame.width / 3 + 10),
            
            movieName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            movieName.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -60),
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 17),
            favouriteButton.widthAnchor.constraint(equalToConstant: 19),
            favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            favouriteButton.leadingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 54)
            
        ])
    }
    
}
