//
//  RecentWatchView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-05.
//

import UIKit
import SnapKit

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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerY.equalTo(self.snp.top).inset(30)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(-15)
        }
        
        moviesTableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(-10)
            make.bottom.equalToSuperview().inset(-27)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
    }
}
