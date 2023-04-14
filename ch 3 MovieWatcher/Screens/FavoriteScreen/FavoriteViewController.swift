//
//  FavoriteViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit
import SnapKit


class FavoriteViewController: UIViewController {
    
    private var movieTableView = ReusableTableView()
    
    // MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegateForCell = self
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)
        view.addSubview(movieTableView)
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTableView.listMovieCoreData = CoreDataService.shared.fetchAllFavorite()
    }
    
        
    private func setupConstrains() {
        
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
    }
}


extension FavoriteViewController: TableAndCollectionViewProtocol {
    func updateListMovieCoreData() {
        movieTableView.listMovieCoreData = CoreDataService.shared.fetchAllFavorite()
    }
    
    func didSelectCellOpenMovieDetailScreen(_ cell: Int) {
        let detailedVC = MovieDetailViewController()
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

