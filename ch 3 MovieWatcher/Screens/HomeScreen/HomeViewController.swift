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
    
    // WelcomeUser
    var userStack = UIStackView()
    
    private let sections = MockData.shared.popularCategory
    
    private let topCollectionView = TopCollectionView()
    private let collectionButtonView = ReusableCollectionView()
    private let collectionBoxOfficeView = BottomCollectionView()
    
    private let userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Resources.Image.tabBarSettingFill)
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let personLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, Vasya"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.jakartaBold(size: 18)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.jakartaRomanSemiBold(size: 12)
        label.text = "only streaming movie lovers"
        label.textColor = UIColor(named: Resources.Colors.secondText)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.jakartaBold(size: 18)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.jakartaBold(size: 18)
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.text = "Box Office"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(userImage)
        
        userStack = UIStackView(arrangedSubviews: [personLabel, label])
        userStack.axis = .vertical
        userStack.spacing = 5
        userStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userStack)
        view.addSubview(categoryLabel)
        
        view.addSubviews(topCollectionView, collectionButtonView, collectionBoxOfficeView)
        
        view.addSubview(boxOfficeLabel)
        view.addSubview(seeAllButton)
    }
    
    //MARK: - UI Elements
    
    
    //MARK: - Constraints
    
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
            make.left.right.equalToSuperview().inset(20)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(topCollectionView.snp.bottom).inset(-15)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        
        collectionButtonView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        boxOfficeLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionButtonView.snp.bottom).inset(-15)
            make.left.right.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(collectionButtonView.snp.bottom).inset(-15)
            make.width.equalTo(50)
        }
        
        collectionBoxOfficeView.snp.makeConstraints { make in
            make.top.equalTo(boxOfficeLabel.snp.bottom).inset(-15)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(-10)
            
        }
    }
}

