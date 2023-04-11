//
//  TopCollectionView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-11.
//

import UIKit
import SnapKit

class TopCollectionView: UIView {
    
    private let sections = MockData.shared.popularCategory
    
    lazy var topCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeViewMovieCell.self, forCellWithReuseIdentifier: HomeViewMovieCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionDelegates()
        self.addSubview(topCollectionView)
        setupConstraints()
    }
    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//        setCollectionDelegates()
//        self.addSubview(topCollectionView)
//        setupConstraints()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionDelegates() {
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
    }
    
    private func setupConstraints() {
        topCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension TopCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewMovieCell.identifier,
                                                            for: indexPath) as? HomeViewMovieCell else {
            return UICollectionViewCell()
        }
        let model = sections.items[indexPath.row]
        cell.configureCell(filmImage: model.image, categoryFilmName: model.category, filmName: model.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2,
                      height: collectionView.frame.height)
    }
}
