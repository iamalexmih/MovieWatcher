//
//  MoviewDetailViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    var rating = 1.9
    
    var id = 0
    var movieImage = UIImage(named: "filmPoster")
    var movieNameLabelText = "Movie name"
    var releaseDateText = "17 Sep 2020"
    var durationText = "148 minutes"
    var genreText = "Action"
    
    
    lazy var scrollView = UIScrollView()
    lazy var containerView = UIView()
    lazy var shadowView = UIView()
    lazy var movieImageView = UIImageView()
    lazy var movieNameLabel = UILabel()
    lazy var detailsStackView = UIStackView()
    lazy var releaseView = MovieDetailsView()
    lazy var timeView = MovieDetailsView()
    lazy var genreView = MovieDetailsView()
    lazy var ratingView = StarRatingView()
    lazy var storyLineLabel = UILabel()
    lazy var descriptionOfMovieLabel = UILabel()
    lazy var castAndCrewHeaderLabel = UILabel()
    lazy var participantCollectionView = CastAndCrewCollectionView()
    lazy var bottomView = UIView()
    lazy var watchButton = CustomButton(title: "Watch now")
    
    
    
    // MARK: - VC LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moview Detail"
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        configure()
        
        // запрос для получения инфы, который передает фильм в func configure -- kompot
        NetworkService.shared.getMovieInfo(with: id) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.configureNetworkInfo(movie: data)
                }
//                self.ratingView.configure(rating: Int(data.vote_average.rounded()))
            case .failure(let failure):
                print("Info of Movie not work in MovieDetailVC \(failure)")
            }
        }
        
        NetworkService.shared.getCastCrew(with: id) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.participantCollectionView.listCastNetwork = data.cast
                }
            case .failure(let failure):
                print("Cast in MovieDetail don't work")
            }
        }
    }
    
    // func for set info from movie model -- kompot -- work
    func configureNetworkInfo(movie: InfoMovie) {
        guard let urlPoster = NetworkService.shared.makeUrlForPoster(posterPath: movie.poster_path) else { return }
        self.movieImageView.kf.setImage(with: URL(string: urlPoster), placeholder: UIImage(systemName: "questionmark.square.dashed"))
        
        movieNameLabel.text = movie.original_title
        
        releaseView.detailTiTleLabel.text = movie.release_date
        
        guard let time = movie.runtime else { return }
        timeView.detailTiTleLabel.text = "\(time) minutes"
        
        guard let str = movie.genres?.last?.name else { return }
        genreView.detailTiTleLabel.text = str
        
        self.ratingView.configure(rating: (Int(movie.vote_average.rounded()) / 2 ))
        
        guard let description = movie.overview else { return }
        descriptionOfMovieLabel.text = description
    }
    
    @objc private func watchButtonPress() {
        print("watch Button Press")
        // По нажатию на кнопку, добавить этот фильм в Кор дату категорию просмотренно.
        for movie in CoreDataService.shared.fetchAllMovieWith(id) {
            movie.isViewed = true
        }
    }
}



// MARK: - Конфигурация лэйблов и констрейнтов
extension MovieDetailViewController {
   
    private func configure() {
        configureBottomView()
        configureWatchButton()
        configureScrollView()
        configureContainerView()
        configureShadowView()
        configureMovieImageView()
        configureMovieNameLabel()
        configureDetailStackView()
        configureRatingView()
        configureStoryLineLabel()
        configureDescriptionOfMovieLabel()
        configurecastAndCrewHeaderLabel()
        configureCollectionView()
    }

    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }

    private func configureContainerView() {
        scrollView.addSubview(containerView)
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func configureShadowView() {
        containerView.addSubview(shadowView)
        shadowView.layer.masksToBounds = false
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.25
        // уменьшил радиус тени. на нав баре появлялась белая видимая граница.
        shadowView.layer.shadowRadius = 30 // было 60
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 20)
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(224)
        }
    }

    private func configureMovieImageView() {
        shadowView.addSubview(movieImageView)
        movieImageView.image = movieImage
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 16
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.snp.makeConstraints { make in
            make.width.height.equalTo(shadowView)
            make.top.right.bottom.left.equalTo(shadowView)
        }
    }

    private func configureMovieNameLabel() {
        containerView.addSubview(movieNameLabel)
        movieNameLabel.text = movieNameLabelText
        movieNameLabel.textColor = UIColor(named: Resources.Colors.text)
        movieNameLabel.numberOfLines = 0
        movieNameLabel.textAlignment = .center
        movieNameLabel.font = .jakartaBold(size: 24)
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).inset(-24)
            make.centerX.equalToSuperview()
        }
    }

    private func configureDetailStackView() {
        containerView.addSubview(detailsStackView)
        detailsStackView.spacing = 24
        detailsStackView.axis = .horizontal
        detailsStackView.distribution = .fillProportionally
        detailsStackView.alignment = .center
        detailsStackView.addArrangedSubview(releaseView)
        releaseView.detailTiTleLabel.text = releaseDateText
        detailsStackView.addArrangedSubview(timeView)
        timeView.detailImageView.image = UIImage(named: Resources.Image.clockImage)
        timeView.detailTiTleLabel.text = durationText
        detailsStackView.addArrangedSubview(genreView)
        genreView.detailImageView.image = UIImage(named: Resources.Image.filmstripImage)
        genreView.detailTiTleLabel.text = genreText
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).inset(-16)
            make.centerX.equalToSuperview()
        }
    }

    private func configureRatingView() {
        containerView.addSubview(ratingView)
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(detailsStackView.snp.bottom).inset(-18)
            make.centerX.equalToSuperview()
        }
    }

    private func configureStoryLineLabel() {
        containerView.addSubview(storyLineLabel)
        storyLineLabel.text = "Story line"
        storyLineLabel.numberOfLines = 0
        storyLineLabel.textAlignment = .left
        storyLineLabel.font = .jakartaRomanSemiBold(size: 16) // изменить
        storyLineLabel.textColor = UIColor(named: Resources.Colors.text)
        storyLineLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(24)
        }
    }

    private func configureDescriptionOfMovieLabel() {
        containerView.addSubview(descriptionOfMovieLabel)
        descriptionOfMovieLabel.text = "Джон Уик - на первый взгляд,самый обычный среднестатистический американец," +
            "который ведет спокойную мирную жизнь. Однако мало кто знает, что он был наёмным."
        descriptionOfMovieLabel.numberOfLines = 0
        descriptionOfMovieLabel.textAlignment = .left
        descriptionOfMovieLabel.font = .jakartaMedium(size: 14)
        descriptionOfMovieLabel.textColor = UIColor(named: Resources.Colors.secondText)
        descriptionOfMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(storyLineLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview().inset(24)
        }
    }

    private func configurecastAndCrewHeaderLabel() {
        containerView.addSubview(castAndCrewHeaderLabel)
        castAndCrewHeaderLabel.text = "Cast and Crew"
        castAndCrewHeaderLabel.numberOfLines = 0
        castAndCrewHeaderLabel.textAlignment = .left
        castAndCrewHeaderLabel.font = .jakartaRomanSemiBold(size: 16) // изменить
        castAndCrewHeaderLabel.textColor = UIColor(named: Resources.Colors.text)
        castAndCrewHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionOfMovieLabel.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(24)
        }
    }

    private func configureCollectionView() {
        containerView.addSubview(participantCollectionView)
        participantCollectionView.backgroundColor = .clear
        participantCollectionView.showsHorizontalScrollIndicator = false
        participantCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(42)
            make.top.equalTo(castAndCrewHeaderLabel.snp.bottom).inset(-16)
            make.bottom.equalToSuperview().inset(50)
        }
    }

    private func configureBottomView() {
        view.addSubview(bottomView)
        bottomView.layer.masksToBounds = false
        bottomView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.25
        bottomView.layer.shadowRadius = 60
        bottomView.layer.shadowOffset = CGSize(width: 40, height: 0)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }

    private func configureWatchButton() {
        bottomView.addSubview(watchButton)
        watchButton.setTitle("Watch Now", for: .normal)
        watchButton.addTarget(self, action: #selector(watchButtonPress), for: .touchUpInside)
        watchButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalTo(181)
        }
    }
}
