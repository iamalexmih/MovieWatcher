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
    
    private func setupUICell(cell: UICollectionViewCell, color: UIColor) {
        cell.backgroundColor = color
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: Resources.Colors.categoryColour)?.cgColor
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        searchView.isSelected = false
        if searchView.lastIndexActive != indexPath {
            
            let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
            if let cell = cell {
                if let selectedCellColour = UIColor(named: Resources.Colors.accent) {
                    setupUICell(cell: cell, color: selectedCellColour)
//                    cell.categoryLabel.textColor = .white
                }
            }
            
            if let previousCell = collectionView.cellForItem(at: searchView.lastIndexActive) as? CategoryCell {
                setupUICell(cell: previousCell, color: .white)
                previousCell.categoryLabel.textColor = UIColor(named: Resources.Colors.categoryColour)
            }
            searchView.lastIndexActive = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Делаем выбранной первую категорию при переходе на экран
        
        // TODO: - Как-то сделать белым текст ячейки
            guard let selectedCellColour = UIColor(named: Resources.Colors.accent) else { return }
            if searchView.isSelected && indexPath == [0, 0] {
                setupUICell(cell: cell, color: selectedCellColour)
                searchView.isSelected = false
                searchView.lastIndexActive = [0, 0]
        }
    }
    
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
        setupUICell(cell: cell, color: .white)
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

