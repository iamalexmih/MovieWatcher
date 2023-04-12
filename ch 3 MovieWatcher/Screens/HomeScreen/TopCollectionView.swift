//
//  TopCollectionView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-11.
//

import UIKit
import SnapKit

class TopCollectionView: UIView {
    
//    private let sections = MockData.shared.popularCategory
    var listMovieNetwork: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
            }
        }
    }
    
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
//        return 10
        // kompot - Network
        return listMovieNetwork.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewMovieCell.identifier,
                                                            for: indexPath) as? HomeViewMovieCell else {
            return UICollectionViewCell()
        }
        // kompot -- Network
        cell.configureNetworkCell(movie: listMovieNetwork[indexPath.row])
        
//        cell.configureCell(filmImage: "filmPoster", categoryFilmName: "Adventure", filmName: "Die Hard")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2,
                      height: collectionView.frame.height)
    }
}
