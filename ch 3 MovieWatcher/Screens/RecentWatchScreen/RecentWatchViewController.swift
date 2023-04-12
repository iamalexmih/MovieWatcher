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
    private var recentWatchTableView = ReusableTableView()
    
    
    // MARK: - VC LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubviews(collectionView, recentWatchTableView)
        setupConstrains()
        recentWatchTableView.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "RecentWatchViewController")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentWatchTableView.delegateForCell = self
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
    }
    
  // MARK: - Setup constrains
    private func setupConstrains() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(40)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(-15)
        }
        
        recentWatchTableView.snp.makeConstraints { make in
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
