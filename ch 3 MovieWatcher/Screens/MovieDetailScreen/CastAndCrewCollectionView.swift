//
//  CastAndCrewCollectionView.swift
//  Test
//
//  Created by Луиза Самойленко on 06.04.2023.
//

import UIKit

class CastAndCrewCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var listCastNetwork: [Cast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)

        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(CastAndCrewCell.self, forCellWithReuseIdentifier: CastAndCrewCell.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCastNetwork.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastAndCrewCell.reuseId,
                                                            for: indexPath) as? CastAndCrewCell else {
            return UICollectionViewCell()
        }
        cell.configureNetworkCell(cast: listCastNetwork[indexPath.row])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 42)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
}
