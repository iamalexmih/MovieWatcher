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
    
//    private let sections = MockData.shared.popularCategory
    var listMovieNetwork: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
            }
        }
    }
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    lazy var topCollectionView: GeminiCollectionView = {
        flowLayout.scrollDirection = .horizontal
        let collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeViewMovieCell.self, forCellWithReuseIdentifier: HomeViewMovieCell.identifier)
            return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = UIColor(named: Resources.Colors.accent)
        page.translatesAutoresizingMaskIntoConstraints = false
        return page

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
            .cornerRadius(15)
            .radius(1500)
            .rotateDirection(.anticlockwise)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topCollectionView.animateVisibleCells()
        let scrollPos = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(scrollPos)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
             self.topCollectionView.animateCell(cell)
         }
    }
}
