//
//  MovieCell.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit



class MovieCell: UITableViewCell {
    
    static let identifier = "RecipeCell"
    
    var timeStack = UIStackView()
    var calendarStack = UIStackView()
    
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
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Resources.Image.clockImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "148 Minutes"
        label.font = UIFont(name: Resources.Font.montserratFont, size: 12)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Resources.Image.calendarImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.text = "17 Sep 2021"
        label.font = UIFont(name: Resources.Font.montserratFont, size: 12)
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filmstripView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Resources.Image.filmstripImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Resources.Colors.accent)
        button.setTitle("Action", for: .normal)
        button.titleLabel?.textColor = UIColor(named: Resources.Colors.text)
        button.titleLabel?.font = UIFont(name: Resources.Font.jakartaFont, size: 10)
        button.titleLabel?.contentMode = .center
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func actionTapped() {
        print("actionTapped")
    }
    
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
        
        timeStack = UIStackView(arrangedSubviews: [timeImageView, timeLabel])
        timeStack.axis = .horizontal
        timeStack.spacing = 5
        timeStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeStack)
        
        calendarStack = UIStackView(arrangedSubviews: [calendarImageView, calendarLabel])
        calendarStack.axis = .horizontal
        calendarStack.spacing = 5
        calendarStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(calendarStack)
        
        contentView.addSubview(filmstripView)
        contentView.addSubview(actionButton)
                
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            movieImage.widthAnchor.constraint(equalToConstant: self.frame.width / 3 + 10),
            
            movieName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
//            movieName.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -60),
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 17),
            favouriteButton.widthAnchor.constraint(equalToConstant: 19),
            favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            favouriteButton.leadingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 54),
            
            timeStack.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 13),
            timeStack.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15),
            
            calendarStack.topAnchor.constraint(equalTo: timeStack.bottomAnchor, constant: 13),
            calendarStack.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15),
            
            filmstripView.topAnchor.constraint(equalTo: calendarStack.bottomAnchor, constant: 13),
            filmstripView.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15),
            
            actionButton.topAnchor.constraint(equalTo: calendarStack.bottomAnchor, constant: 8),
            actionButton.leadingAnchor.constraint(equalTo: filmstripView.trailingAnchor, constant: 5),
            actionButton.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    
}
