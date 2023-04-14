//
//  HomeViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit

// swiftlint:disable all
class HomeViewController: UIViewController {
    
    private let topCollectionView = TopCollectionView()
    private let filmsCategoriesCollection = ReusableCollectionView()
    private let boxOfficeCollection = BottomCollectionView()
    
    lazy var userImage = UIImageView()
    lazy var personLabel = UILabel()
    lazy var streamingLoversLabel = UILabel()
    var userStack = UIStackView()
    lazy var categoryLabel = UILabel()
    lazy var boxOfficeLabel = UILabel()
    lazy var seeAllButton = UIButton(type: .system)
    
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        
        boxOfficeCollection.delegateForCell = self
        filmsCategoriesCollection.delegateCollectionDidSelect = self
        
        setupViews()
        setConstraints()
        // network -- kompot
        topRated()
        nowPlaying()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if topCollectionView.listMovieNetwork.isEmpty {
            topCollectionView.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "HomeScreenTopRated")
        } else {
            topCollectionView.topCollectionView.reloadData()
        }
        
        if boxOfficeCollection.listMovieNetwork.isEmpty {
        boxOfficeCollection.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "HomeScreenBoxOfficeCollection")
        } else {
            boxOfficeCollection.collectionBoxOfficeView.reloadData()
        }
    }
    
    
    // func for topRated - Network -- kompot - work
    func topRated() {
        NetworkService.shared.getTopRated { result in
            switch result {
            case .success(let data):
                self.topCollectionView.listMovieNetwork = data.results
                self.saveCoreDataForHomeScreenTopRated(listMovieNetwork: data.results)
            case .failure(let failure):
                print("fuck top rated \(failure)")
            }
        }
    }
    
    // func for nowPlaying -- Network -> work -- kompot
    func nowPlaying() {
        NetworkService.shared.getNowPlaying { result in
            switch result {
            case .success(let data):
                self.boxOfficeCollection.listMovieNetwork = data.results
                self.saveCoreDataForHomeScreenBoxOfficeCollection(listMovieNetwork: data.results)
            case .failure(let failure):
                print("fuck now playing \(failure)")
            }
        }
    }
    

}

// MARK: - CoreData
extension HomeViewController {
    
    func saveCoreDataForHomeScreenTopRated(listMovieNetwork: [Movie]) {
        CoreDataService.shared.saveCoreDataForHomeScreenTopRated(listMovieNetwork: listMovieNetwork)
    }
    
    func saveCoreDataForHomeScreenBoxOfficeCollection(listMovieNetwork: [Movie]) {
        CoreDataService.shared.saveCoreDataForHomeScreenBoxOfficeCollection(listMovieNetwork: listMovieNetwork)
    }
    
}

// MARK: - Table View Delegate
extension HomeViewController: TableAndCollectionViewProtocol {
    
    func updateListMovieCoreData() {
        if boxOfficeCollection.listMovieNetwork.isEmpty {
            boxOfficeCollection.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "HomeScreenBoxOfficeCollection")
        }
    }
    
    func didSelectCellOpenMovieDetailScreen(_ movieId: Int) {
        let detailedVC = MovieDetailViewController()
        detailedVC.id = movieId
        print("HomeViewController передает movieId")
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}


// MARK: - Выбор жанра. Collection view
extension HomeViewController: CollectionDidSelectProtocol {
    func getMoviesFromCategory(nameGenre: String) {
        if nameGenre == "All" {
            nowPlaying()
        } else {
            let nameId = NetworkService.shared.getIdGenreForOneMovie(movieGenresName: nameGenre, arrayGenres: StorageGenres.shared.listGenres)
            NetworkService.shared.getListMoviesForGenres(nameId) { result in
                switch result {
                case .success(let data):
                    self.boxOfficeCollection.listMovieNetwork = data.results
                    self.saveCoreDataForHomeScreenBoxOfficeCollection(listMovieNetwork: data.results)
                    DispatchQueue.main.async {
                        self.boxOfficeCollection.collectionBoxOfficeView.reloadData()
                    }
                case .failure(let failure):
                    print("Error receiving film by genre \(failure)")
                }
            }
        }
    }
}


    
    //MARK: - Configuring UI Elements

extension HomeViewController {
    
    private func setupViews() {
        configureUserImage()
        configurePersonLabel()
        configureStreamingLoversLabel()
        view.addSubviews(topCollectionView, filmsCategoriesCollection, boxOfficeCollection)
        configureUserSTack()
        configureCategoryLabel()
        configureBoxOfficeLabel()
        configureSeeAllButton()
    }
    
    func configureUserImage() {
        view.addSubview(userImage)
        userImage.image = UIImage(named: Resources.Image.tabBarSettingFill)
        userImage.layer.cornerRadius = 20
        userImage.layer.masksToBounds = true
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        userImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configurePersonLabel() {
        personLabel.text = "Hi, Vasya"
        personLabel.adjustsFontSizeToFitWidth = true
        personLabel.font = UIFont.jakartaBold(size: 18)
        personLabel.minimumScaleFactor = 0.5
        personLabel.numberOfLines = 1
        personLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStreamingLoversLabel() {
        streamingLoversLabel.adjustsFontSizeToFitWidth = true
        streamingLoversLabel.font = UIFont.jakartaRomanSemiBold(size: 12)
        streamingLoversLabel.text = "only streaming movie lovers"
        streamingLoversLabel.textColor = UIColor(named: Resources.Colors.secondText)
        streamingLoversLabel.minimumScaleFactor = 0.5
        streamingLoversLabel.numberOfLines = 1
        streamingLoversLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureUserSTack() {
        userStack = UIStackView(arrangedSubviews: [personLabel, streamingLoversLabel])
        userStack.axis = .vertical
        userStack.spacing = 5
        userStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userStack)
    }
    
    func configureCategoryLabel() {
        view.addSubview(categoryLabel)
        categoryLabel.text = "Category"
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.font = UIFont.jakartaBold(size: 18)
        categoryLabel.minimumScaleFactor = 0.5
        categoryLabel.numberOfLines = 1
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureBoxOfficeLabel() {
        view.addSubview(boxOfficeLabel)
        boxOfficeLabel.adjustsFontSizeToFitWidth = true
        boxOfficeLabel.font = UIFont.jakartaBold(size: 18)
        boxOfficeLabel.minimumScaleFactor = 0.7
        boxOfficeLabel.numberOfLines = 1
        boxOfficeLabel.text = "Box Office"
        boxOfficeLabel.textAlignment = .left
        boxOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureSeeAllButton() {
        view.addSubview(seeAllButton)
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.setTitleColor(UIColor(named: Resources.Colors.accent), for: .normal)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
    }
}


//MARK: - Constraints

extension HomeViewController {
    
    func setConstraints() {

        userImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
        
        userStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(userImage.snp.right).inset(-10)
            make.height.equalTo(40)
            make.right.equalToSuperview().inset(-5)
        }
        
        topCollectionView.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).inset(-15)
            make.height.equalTo(250)
            make.left.right.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(topCollectionView.snp.bottom).inset(-15)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        filmsCategoriesCollection.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        boxOfficeLabel.snp.makeConstraints { make in
            make.top.equalTo(filmsCategoriesCollection.snp.bottom).inset(-15)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(filmsCategoriesCollection.snp.bottom).inset(-15)
            make.width.equalTo(50)
        }
        
        boxOfficeCollection.snp.makeConstraints { make in
            make.top.equalTo(boxOfficeLabel.snp.bottom).inset(-15)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(-10)
            
        }
    }
}

