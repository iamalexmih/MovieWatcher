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
    var categories = ["All", "Action", "Adventure", "Animation",
                      "Comedy", "Crime", "Documentary", "Drama",
                      "Family", "Fantasy", "History", "Horror",
                      "Music", "Romance", "Science Fiction",
                      "TV Movie", "Thriller", "War", "Western"]
    
    private let buttonCategoryView = ButtonCollectionView()
//    private let boxOfficeView = BoxOfficeCollectionViewCell()
    private let sections = MockData.shared.popularCategory
    
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
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
                
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
    
    lazy var collectionButtonView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
    
    lazy var collectionBoxOfficeView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionButtonView.dataSource = self
        collectionButtonView.delegate = self
        collectionBoxOfficeView.dataSource = self
        collectionBoxOfficeView.delegate = self
        
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
        
        collectionView.register(HomeViewMovieCell.self, forCellWithReuseIdentifier: HomeViewMovieCell.identifier)
        collectionButtonView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionBoxOfficeView.register(BoxViewCell.self, forCellWithReuseIdentifier: BoxViewCell.identifier)
        view.addSubviews(collectionView, collectionButtonView, collectionBoxOfficeView)
        
        view.addSubview(boxOfficeLabel)
        view.addSubview(seeAllButton)
    }
    
    private func setupUICell(cell: UICollectionViewCell, color: UIColor) {
        cell.backgroundColor = color
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: Resources.Colors.categoryColour)?.cgColor
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            userImage.widthAnchor.constraint(equalToConstant: 40),
            
            userStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userStack.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userStack.heightAnchor.constraint(equalToConstant: 40),
            userStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            collectionView.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            categoryLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 100),
            
            collectionButtonView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            collectionButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionButtonView.heightAnchor.constraint(equalToConstant: 36),
            
            boxOfficeLabel.topAnchor.constraint(equalTo: collectionButtonView.bottomAnchor, constant: 15),
            boxOfficeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boxOfficeLabel.widthAnchor.constraint(equalToConstant: 100),
            
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            seeAllButton.topAnchor.constraint(equalTo: collectionButtonView.bottomAnchor, constant: 15),
            seeAllButton.widthAnchor.constraint(equalToConstant: 50),
            
            collectionBoxOfficeView.topAnchor.constraint(equalTo: boxOfficeLabel.bottomAnchor, constant: 15),
            collectionBoxOfficeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionBoxOfficeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionBoxOfficeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt
                        indexPath: IndexPath) {
        if collectionView == self.collectionView {
        } else if collectionView == self.collectionButtonView {
            
            buttonCategoryView.isSelected = false
            if buttonCategoryView.lastIndexActive != indexPath {
                
                let cell = collectionButtonView.cellForItem(at: indexPath) as? CategoryCell
                if let cell = cell {
                    if let selectedCellColor = UIColor(named: Resources.Colors.accent) {
                        setupUICell(cell: cell, color: selectedCellColor)
                        //                    cell.categoryLabel.textColor = .white
                    }
                }
                
                if let previousCell = collectionButtonView.cellForItem(at: buttonCategoryView.lastIndexActive) as? CategoryCell {
                    setupUICell(cell: previousCell, color: .white)
                    previousCell.categoryLabel.textColor = UIColor(named: Resources.Colors.categoryColour)
                }
                buttonCategoryView.lastIndexActive = indexPath
            }
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
        } else if collectionView == self.collectionButtonView {
            // Делаем выбранной первую категорию при переходе на экран
            
            // TODO: - Как-то сделать белым текст ячейки
            guard let selectedCellColour = UIColor(named: Resources.Colors.accent) else { return }
            if buttonCategoryView.isSelected && indexPath == [0, 0] {
                setupUICell(cell: cell, color: selectedCellColour)
                buttonCategoryView.isSelected = false
                buttonCategoryView.lastIndexActive = [0, 0]
            }
        } else {
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return sections.count
        } else if collectionView == self.collectionButtonView {
            return buttonCategoryView.categories.count
        } else {
            return 2
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewMovieCell.identifier, for: indexPath) as? HomeViewMovieCell else {
                return UICollectionViewCell()
            }
            let model = sections.items[indexPath.row]
            cell.configureCell(filmImage: model.image, categoryFilmName: model.category, filmName: model.name)
            return cell
        } else if collectionView == self.collectionButtonView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            setupUICell(cell: cell, color: .white)
            let category = buttonCategoryView.categories[indexPath.row]
            cell.configure(with: category)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxViewCell.identifier, for: indexPath) as? BoxViewCell else {
                return UICollectionViewCell()
            }
            let model = sections.items[indexPath.row]
            cell.configureCell(filmImage: model.image, categoryFilmName: model.category, filmName: model.name, time: model.time)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.frame.width / 2,
                   height: collectionView.frame.height)
        } else if collectionView == self.collectionButtonView {
            let text = buttonCategoryView.categories[indexPath.row]
            let cellWidth = text.size(withAttributes: [.font: UIFont.jakartaRomanSemiBold(size: 16) as Any]).width + 40
            return CGSize(width: cellWidth, height: 36)
        } else {
            return CGSize(width: collectionView.frame.width,
                          height: collectionView.frame.height / 2.1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
