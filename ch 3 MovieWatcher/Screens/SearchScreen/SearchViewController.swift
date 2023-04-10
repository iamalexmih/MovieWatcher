//
//  ListMovieViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit


class SearchViewController: UIViewController {
    
    private var searchTextField = SearchTextField()
    private var collectionView = ReusableCollectionView()
    private lazy var tableView = ReusableTableView()
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubviews(searchTextField, collectionView, tableView)
        setupConstrains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegateForCell = self
        view.backgroundColor = .white
    }
    
    private func setupConstrains() {
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-15)
            make.height.equalTo(40)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(-15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
    }
}

extension SearchViewController: ReusableTableViewDelegate {
    func didSelectTableViewCell(_ cell: UITableViewCell) {
        let detailedVC = MovieDetailViewController()
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}
