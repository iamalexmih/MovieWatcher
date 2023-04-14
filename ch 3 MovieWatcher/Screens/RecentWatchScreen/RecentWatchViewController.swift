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
        recentWatchTableView.listMovieCoreData = CoreDataService.shared.fetchRecentWatch()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentWatchTableView.delegateForCell = self
        collectionView.delegateCollectionDidSelect = self
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


extension RecentWatchViewController: TableAndCollectionViewProtocol {
    
    func updateListMovieCoreData() {
        
    }
    
    func didSelectCellOpenMovieDetailScreen(_ movieId: Int) {
        let detailedVC = MovieDetailViewController()
        detailedVC.id = movieId
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}


// MARK: - Протокол для  collection view Жанров.
extension RecentWatchViewController: CollectionDidSelectProtocol {
    func getMoviesFromCategory(nameGenre: String) {
        if nameGenre == "All" {
            recentWatchTableView.listMovieCoreData = CoreDataService.shared.fetchRecentWatch()
        } else {
            let genreId = NetworkService.shared.getIdGenreForOneMovie(movieGenresName: nameGenre, arrayGenres: StorageGenres.shared.listGenres)
            
            recentWatchTableView.listMovieCoreData = CoreDataService.shared.fetchRecentWatchWithGenge(genreId)
        }
    }
}
