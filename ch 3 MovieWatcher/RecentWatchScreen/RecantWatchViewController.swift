//
//  RecantWatchViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit


class RecentWatchViewController: UIViewController {
    
    private let recentWatchView = RecentWatchView()
    var selectedCategory = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        recentWatchView.collectionView.dataSource = self
        recentWatchView.collectionView.delegate = self
        recentWatchView.moviesTableView.dataSource = self
        recentWatchView.moviesTableView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.addSubview(recentWatchView)
        NSLayoutConstraint.activate([
            recentWatchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recentWatchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recentWatchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recentWatchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupUICell(cell: UICollectionViewCell, color: UIColor) {
        cell.backgroundColor = color
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: Resources.Colors.categoryColour)?.cgColor
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15
    }
}


extension RecentWatchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        recentWatchView.isSelected = false
        if recentWatchView.lastIndexActive != indexPath {
            
            let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
            if let cell = cell {
                if let selectedCellColour = UIColor(named: Resources.Colors.accent) {
                    setupUICell(cell: cell, color: selectedCellColour)
                    cell.categoryLabel.textColor = .white
                }
                selectedCategory = recentWatchView.categories[indexPath.row]
            }
            
            if let cell1 = collectionView.cellForItem(at: recentWatchView.lastIndexActive) as? CategoryCell {
                setupUICell(cell: cell1, color: .white)
                cell1.categoryLabel.textColor = UIColor(named: Resources.Colors.categoryColour)
            }
            recentWatchView.lastIndexActive = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if recentWatchView.isSelected && indexPath == [0, 0] {
            if let selectedCellColour = UIColor(named: Resources.Colors.accent) {
                setupUICell(cell: cell, color: selectedCellColour)
                recentWatchView.isSelected = false
                recentWatchView.lastIndexActive = [0, 0]
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentWatchView.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        setupUICell(cell: cell, color: .white)
        let category = recentWatchView.categories[indexPath.row]
        cell.configure(with: category)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = recentWatchView.categories[indexPath.row]
        let cellWidth = text.size(withAttributes: [.font: UIFont(name: Resources.Font.jakartaFont, size: 12) as Any]).width + 40
        return CGSize(width: cellWidth, height: 36)
    }
}

extension RecentWatchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
