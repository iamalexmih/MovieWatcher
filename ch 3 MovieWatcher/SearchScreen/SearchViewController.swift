//
//  ListMovieViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit


class SearchViewController: UIViewController {

    private let searchView = SearchView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.moviesTableView.dataSource = self
        searchView.moviesTableView.delegate = self
    }
    
    private func setupView() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchView.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let category = searchView.categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = searchView.categories[indexPath.row]
        let cellWidth = text.size(withAttributes: [.font: UIFont.jakartaRomanSemiBold(size: 16) as Any]).width + 40
        return CGSize(width: cellWidth, height: 36)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

