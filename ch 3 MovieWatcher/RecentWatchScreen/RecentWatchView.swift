//
//  RecentWatchView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-05.
//

import UIKit

class RecentWatchView: UIView {

    var categories = ["All", "Action", "Adventure", "Animation", "Comedy", "Crime",
                      "Documentary", "Drama", "Family", "Fantasy", "History", "Horror",
                      "Music", "Romance", "Science Fiction", "TV Movie", "Thriller", "War", "Western"]
    
    var isSelected = true
    var lastIndexActive: IndexPath = [0, 1]
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.rowHeight = 184
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        moviesTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
                
        addSubviews(moviesTableView, collectionView)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.centerYAnchor.constraint(equalTo: topAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            moviesTableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            moviesTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27),
            moviesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            moviesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
            
        ])
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }

}
