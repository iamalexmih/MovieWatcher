//
//  TopCollectionView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-11.
//

import UIKit
import SnapKit
import Gemini

class TopCollectionView: UIView {
    
    var listMovieNetwork: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
            }
        }
    }
    
    var listMovieCoreData: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
            }
        }
    }
    
    private let flowLayout = UICollectionViewFlowLayout()
    lazy var pageControl = InteractivePageIndicator(pages: 3)
    
    
    lazy var topCollectionView: GeminiCollectionView = {
        flowLayout.scrollDirection = .horizontal
        let collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeViewMovieCell.self, forCellWithReuseIdentifier: HomeViewMovieCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionDelegates()
        self.addSubview(topCollectionView)
        self.addSubview(pageControl)
        setupConstraints()
        configureAnimation()
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
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(topCollectionView.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureAnimation() {
        topCollectionView.gemini
            .circleRotationAnimation()
            .cornerRadius(10)
            .radius(1500)
            .rotateDirection(.anticlockwise)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topCollectionView.animateVisibleCells()
    }
}


extension TopCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.2,
                      height: collectionView.frame.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.topCollectionView.animateCell(cell)
        }
        // анимация для page controll
        let pagesCount = listMovieNetwork.count / 3
        if indexPath.item < pagesCount {
            pageControl.setPage(0)
        } else if indexPath.item < pagesCount * 2 {
            pageControl.setPage(1)
        } else {
            pageControl.setPage(2)
        }
    }
}
