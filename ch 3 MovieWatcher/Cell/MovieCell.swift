//
//  MovieCell.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit
import Kingfisher


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
        label.font = UIFont.jakartaBold(size: 18)
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
        label.font = UIFont.montserratRomanMedium(size: 12)
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
        label.font = UIFont.montserratRomanMedium(size: 12)
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
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Action"
        label.font = UIFont.montserratRomanMedium(size: 12)
        label.contentMode = .center
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton(type: .system)
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
    
    func configure(movie: Movie) {
        movieName.text = movie.original_title
        calendarLabel.text = movie.release_date
        categoryLabel.text = NetworkService.shared.getNameGenreForOneMovie(
            movieGenresId: movie.genre_ids.first ?? 7777,
            arrayGenres: StorageGenres.shared.listGenres
        )
        
        guard let urlPoster = NetworkService.shared.makeUrlForPoster(posterPath: movie.poster_path) else { return }
        movieImage.kf.setImage(with: URL(string: urlPoster))
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
        contentView.addSubview(categoryLabel)
                
    }
    
    private func setupConstraints() {
        
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).inset(24)
            make.width.equalTo(self.frame.width / 3 + 10)
        }
        
        movieName.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(movieImage.snp.right).inset(-10)
        }
        
        favouriteButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.width.equalTo(19)
            make.top.equalToSuperview()
            make.left.equalTo(movieName.snp.right).inset(-54)
        }
        
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(movieName.snp.bottom).inset(-13)
            make.left.equalTo(movieImage.snp.right).inset(-15)
        }
        
        calendarStack.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).inset(-13)
            make.left.equalTo(movieImage.snp.right).inset(-15)
        }
        
        filmstripView.snp.makeConstraints { make in
            make.top.equalTo(calendarStack.snp.bottom).inset(-13)
            make.left.equalTo(movieImage.snp.right).inset(-15)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(filmstripView.snp.centerY)
            make.left.equalTo(filmstripView.snp.right).inset(-6)
        }
    }
}
