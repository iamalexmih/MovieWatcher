//
//  MoviewDetailViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {

    let rating = 1.9

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
//        self.hidesBottomBarWhenPushed = true
//        CustomTabBarController().tabBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        // TODO: Теперь tabBar надо снова показать при возврате назад
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        configure()
    }
    
    
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
            make.topMargin.left.right.equalToSuperview()
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
        shadowView.layer.shadowRadius = 60
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 20)
        shadowView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(44)
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
        ratingView.configure(rating: Int(rating.rounded()))
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
        descriptionOfMovieLabel.text = "Джон Уик - на первый взгляд, самый обычный среднестатистический американец, который ведет спокойную мирную жизнь. Однако мало кто знает, что он был наёмным."
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
        watchButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalTo(181)
        }
    }
}
