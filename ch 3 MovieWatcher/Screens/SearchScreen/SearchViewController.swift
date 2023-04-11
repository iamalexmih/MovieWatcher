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
    private lazy var movieTableView = ReusableTableView()
    
    var movies: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubviews(searchTextField, collectionView, movieTableView)
        setupConstrains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegateForCell = self
        collectionView.delegateCollectionDidSelect = self
        view.backgroundColor = .white
        
        popularMovie()
    }
    
    func popularMovie() {
        NetworkService.shared.getPopularMovies { result in
            switch result {
            case .success(let data):
                self.movies = data.results
                self.movieTableView.movies = self.movies
                DispatchQueue.main.async {
                    self.movieTableView.tableView.reloadData()
                }
            case .failure(let failure):
                print("screen SearchVC \(failure)")
            }
        }
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
        
        movieTableView.snp.makeConstraints { make in
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

extension SearchViewController: CollectionDidSelectProtocol {
    func getMoviesFromCategory(nameGenre: String) {
        if nameGenre == "All" {
            popularMovie()
        } else {
            let nameId = NetworkService.shared.getIdGenreForOneMovie(movieGenresName: nameGenre, arrayGenres: StorageGenres.shared.listGenres)
            NetworkService.shared.getListMoviesForGenres(nameId) { result in
                switch result {
                case .success(let data):
                    self.movieTableView.movies = data.results
                    DispatchQueue.main.async {
                        self.movieTableView.tableView.reloadData()
                    }
                case .failure(let failure):
                    print("Error receiving film by genre \(failure)")
                }
            }
        }
    }
}
