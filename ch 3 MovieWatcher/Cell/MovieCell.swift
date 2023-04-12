//
//  MovieCell.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit
import Kingfisher



protocol FavoriteMovieCellProtocol: AnyObject {
    func didPressFavoriteButton()
}


class MovieCell: UITableViewCell {
    
    static let identifier = "RecipeCell"
    
    private var movieId: Int = 0
    weak var delegateFavoriteButton: FavoriteMovieCellProtocol?
    
    var timeStack = UIStackView()
    var calendarStack = UIStackView()
    
    private var movieImage: UIImageView = UIImageView()
    private var movieName: UILabel = UILabel()
    private let timeImageView: UIImageView = UIImageView()
    private let timeLabel: UILabel = UILabel()
    private let calendarImageView: UIImageView = UIImageView()
    private let calendarLabel: UILabel = UILabel()
    private let filmstripView: UIImageView = UIImageView()
    private let categoryLabel: UILabel = UILabel()
    private var favouriteButton: UIButton = UIButton(type: .system)

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        configureElementUI()
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureForNetwork(movie: Movie) {
        movieName.text = movie.original_title
        calendarLabel.text = movie.release_date
        categoryLabel.text = NetworkService.shared.getNameGenreForOneMovie(
            movieGenresId: movie.genre_ids.first ?? 7777,
            arrayGenres: StorageGenres.shared.listGenres
        )
        movieId = movie.id
        synchFavoriteWithNetwork(movieId)
        guard let posterPath = NetworkService.shared.makeUrlForPoster(posterPath: movie.poster_path) else { return }
        let urlPoster = URL(string: posterPath)
        movieImage.kf.setImage(with: urlPoster) { result in
            switch result {
            case .success(let value):
                let imageData = value.image.pngData()
                self.saveImageCoreData(imageData: imageData, movie: movie)
            case .failure(let error):
                print("Error kf: \(error)")
            }
        }
    }
    
    
    @objc func favouriteButtonPressed() {
        print("Favourite PRESSED")
        if CoreDataService.shared.fetchDataId(id: movieId, parentCategory: "FavoriteViewController").isEmpty {
           // Добавить в Избранное
            let selectedMovieInCommonList = CoreDataService.shared.fetchDataId(id: movieId, parentCategory: "SearchViewController").first!
            let categoryEntityFavorite = CategoryScreenEntity(context: CoreDataService.shared.viewContext)
            categoryEntityFavorite.name = "FavoriteViewController"
            let categoryEntitySearch = CategoryScreenEntity(context: CoreDataService.shared.viewContext)
            categoryEntitySearch.name = "SearchViewController"
            
            let setParents = NSSet(objects: categoryEntityFavorite, categoryEntitySearch)
            selectedMovieInCommonList.parentCategory = setParents
            selectedMovieInCommonList.favorite = !selectedMovieInCommonList.favorite
            CoreDataService.shared.save()
            setImageButtonFavorite(isFavorite: selectedMovieInCommonList.favorite)
        } else {
            // Удалить из избранного
            let selectedMovieInFavoriteList = CoreDataService.shared.fetchDataId(id: movieId, parentCategory: "FavoriteViewController").first!
            let categoryEntity = CategoryScreenEntity(context: CoreDataService.shared.viewContext)
            categoryEntity.name = "SearchViewController"
            let setParents = NSSet(objects: categoryEntity)
            selectedMovieInFavoriteList.parentCategory = setParents
            selectedMovieInFavoriteList.favorite = !selectedMovieInFavoriteList.favorite
            CoreDataService.shared.save()
            setImageButtonFavorite(isFavorite: selectedMovieInFavoriteList.favorite)
        }
        delegateFavoriteButton?.didPressFavoriteButton()
    }
    
    
    func synchFavoriteWithNetwork(_ movieId: Int) {
        // Если массив содержит элемент, то значит кино в избранном. значить поставить сердечко
        if !CoreDataService.shared.fetchDataId(id: movieId, parentCategory: "FavoriteViewController").isEmpty {
            setImageButtonFavorite(isFavorite: true)
        }
    }
    
}



// MARK: - Core Data
extension MovieCell {
    
    func setDataForCellCoreData(movieEntity: MovieEntity) {
        calendarLabel.text = movieEntity.releaseDate
        movieName.text = movieEntity.title
        movieId = Int(movieEntity.id)
        setImageButtonFavorite(isFavorite: movieEntity.favorite)
        let imageDataDefault = UIImage(systemName: "questionmark")?.pngData()
        let imageEntity = CoreDataService.shared.fetchImageUseMovieId(id: Int(movieEntity.id))
        if let imageEntity = imageEntity {
            movieImage.image = UIImage(data: imageEntity.imageData ?? imageDataDefault!)
        }
    }
    
    
    func saveImageCoreData(imageData: Data?, movie: Movie) {
        // Если фильма с id xxx нет в хранилище, то тогда добавить.
        let imageEntity = CoreDataService.shared.fetchImageUseMovieId(id: movie.genre_ids.first!)
        if imageEntity == nil {
            let imageDataDefault = UIImage(systemName: "questionmark")?.pngData()
            
            let newImageEntity = ImageEntity(context: CoreDataService.shared.viewContext)
            newImageEntity.id = Int64(movie.id)
            newImageEntity.imageData = imageData ?? imageDataDefault
            
            CoreDataService.shared.save()
        }
    }
    
}



// MARK: - Configure element UI
extension MovieCell {
    
    private func setImageButtonFavorite(isFavorite: Bool) {
        if isFavorite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func configureElementUI() {
        movieImage.image = UIImage(named: "questionmark")
        movieImage.contentMode = .scaleAspectFill
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.layer.cornerRadius = 10
        movieImage.layer.masksToBounds = true
        movieImage.clipsToBounds = true
        
        movieName.text = "Mad Max Collection"
        movieName.textColor = .black
        movieName.font = UIFont.jakartaBold(size: 18)
        movieName.font = .systemFont(ofSize: 18)
        movieName.numberOfLines = 0
        movieName.textAlignment = .left
        movieName.translatesAutoresizingMaskIntoConstraints = false
        
        timeImageView.image = UIImage(named: Resources.Image.clockImage)
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.text = "148 Minutes"
        timeLabel.font = UIFont.montserratRomanMedium(size: 12)
        timeLabel.textColor = UIColor(named: Resources.Colors.secondText)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        calendarImageView.image = UIImage(named: Resources.Image.calendarImage)
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarLabel.text = "17 Sep 2021"
        calendarLabel.font = UIFont.montserratRomanMedium(size: 12)
        calendarLabel.textColor = UIColor(named: Resources.Colors.secondText)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        filmstripView.image = UIImage(named: Resources.Image.filmstripImage)
        filmstripView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = "Action"
        categoryLabel.font = UIFont.montserratRomanMedium(size: 12)
        categoryLabel.contentMode = .center
        categoryLabel.textColor = UIColor(named: Resources.Colors.secondText)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favouriteButton.tintColor = UIColor(named: Resources.Colors.categoryColour)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
    }
}



// MARK: - Set Layout
extension MovieCell {

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
            make.right.equalTo(favouriteButton.snp.left).inset(-5)
        }
        
        favouriteButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(23)
            make.top.equalTo(contentView)
            make.right.equalTo(-7)
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
