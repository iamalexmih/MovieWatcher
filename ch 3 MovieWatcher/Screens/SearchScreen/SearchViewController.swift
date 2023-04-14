//
//  ListMovieViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit


class SearchViewController: UIViewController, UITextFieldDelegate {
    
    private var searchTextField = SearchTextField()
    private var collectionView = ReusableCollectionView()
    private lazy var movieTableView = ReusableTableView()
    
    
    // MARK: - VC LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubviews(searchTextField, collectionView, movieTableView)
        setupConstrains()
        
        if movieTableView.listMovieNetwork.isEmpty {
            movieTableView.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "SearchViewController")
        } else {
            movieTableView.tableView.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search network
        searchTextField.searchTextField.delegate = self
        
        movieTableView.delegateForCell = self
        collectionView.delegateCollectionDidSelect = self
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)        
        searchTextField.cancelButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        popularMovie()
//        searchMovie()
    }
    
    // заканичвает редактирование после нажатия ретерн
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        searchMovie(with: searchTextField.searchTextField.text)
        return true
    }
    
    @objc func clearButtonPressed() {
        searchTextField.searchTextField.text = ""
    }
    
    // MARK: - other funcs
    
    func popularMovie() {
        NetworkService.shared.getPopularMovies { result in
            switch result {
            case .success(let data):
                self.movieTableView.listMovieNetwork = data.results
                self.saveCoreDataForSearchScreen(listMovieNetwork: data.results)
            case .failure(let failure):
                print("screen SearchVC \(failure)")
            }
        }
    }
    
    // network for search -- kompot -- work
    func searchMovie(with: String?) {
        guard let query = with,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
                query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            popularMovie()
            return
        }
        
        if query.isEmpty {
            popularMovie()
        } else {
            NetworkService.shared.search(with: query) { result in
                switch result {
                case .success(let data):
                    self.movieTableView.listMovieNetwork = data.results
                    self.saveCoreDataForSearchScreen(listMovieNetwork: data.results)
                case .failure(let failure):
                    print("searchMovie in searchVC \(failure)")
                }
            }
        }
    }
}



// MARK: - CoreData
extension SearchViewController {
    func saveCoreDataForSearchScreen(listMovieNetwork: [Movie]) {
        if !listMovieNetwork.isEmpty {
            CoreDataService.shared.saveCoreDataForSearchScreen(listMovieNetwork: listMovieNetwork)
        }
    }
}



// MARK: - Table View Delegate
extension SearchViewController: TableAndCollectionViewProtocol {
    
    func updateListMovieCoreData() {
        if movieTableView.listMovieNetwork.isEmpty {
            movieTableView.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "SearchViewController")
        }
    }
    
    func didSelectCellOpenMovieDetailScreen(_ movieId: Int) {
        let detailedVC = MovieDetailViewController()
        detailedVC.id = movieId
        print("передает id ")
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}



// MARK: - Протокол для  collection view Жанров.
extension SearchViewController: CollectionDidSelectProtocol {
    func getMoviesFromCategory(nameGenre: String) {
        if nameGenre == "All" {
            popularMovie()
        } else {
            let nameId = NetworkService.shared.getIdGenreForOneMovie(movieGenresName: nameGenre, arrayGenres: StorageGenres.shared.listGenres)
            NetworkService.shared.getListMoviesForGenres(nameId) { result in
                switch result {
                case .success(let data):
                    self.movieTableView.listMovieNetwork = data.results
                    print(data.results.isEmpty)
                    self.saveCoreDataForSearchScreen(listMovieNetwork: data.results)
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



// MARK: - Setup constrains
extension SearchViewController {
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
