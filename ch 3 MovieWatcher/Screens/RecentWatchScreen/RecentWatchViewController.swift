//
//  RecantWatchViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit
import SnapKit

class RecentWatchViewController: UIViewController {
    
    private var collectionView = ReusableCollectionView()
    private lazy var tableView = ReusableTableView()
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubviews(collectionView, tableView)
        setupConstrains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegateForCell = self
        view.backgroundColor = .white
    }
    
    private func setupConstrains() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(15)
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

extension RecentWatchViewController: ReusableTableViewDelegate {
    func updateListMovieCoreData() {
        
    }
    
    func didSelectTableViewCell(_ cell: UITableViewCell) {
        let detailedVC = MovieDetailViewController()
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}
