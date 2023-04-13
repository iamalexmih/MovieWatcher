//
//  BottomCollectionView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-11.
//

import UIKit

class BottomCollectionView: UIView {
    
    //    private let sections = MockData.shared.popularCategory
    
    // for Network in BoxOffice -- kompot
    var listMovieNetwork: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionBoxOfficeView.reloadData()
            }
        }
    }
    
    lazy var collectionBoxOfficeView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BoxViewCell.self, forCellWithReuseIdentifier: BoxViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionDelegates()
        self.addSubview(collectionBoxOfficeView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionDelegates() {
        collectionBoxOfficeView.dataSource = self
        collectionBoxOfficeView.delegate = self
    }
    
    private func setupConstraints() {
        collectionBoxOfficeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension BottomCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt
                        indexPath: IndexPath) {
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
        return listMovieNetwork.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxViewCell.identifier, for: indexPath) as? BoxViewCell else {
            return UICollectionViewCell()
        }
        
//        cell.configureCell(filmImage: "filmPoster", categoryFilmName: "Action", filmName: "Luck", time: 149)
        
        // for Network -- kompot
        cell.configureNetworkCell(movie: listMovieNetwork[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height / 2.1)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
