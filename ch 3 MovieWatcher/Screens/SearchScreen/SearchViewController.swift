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
    
    
    // MARK: - VC LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubviews(searchTextField, collectionView, movieTableView)
        setupConstrains()
        
        movieTableView.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "SearchViewController")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegateForCell = self
        collectionView.delegateCollectionDidSelect = self
        view.backgroundColor = .white
        
//        popularMovie()
        searchMovie()
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
    func searchMovie() {
        let testQuery = "avatar the"
        let query = testQuery
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty,
                query.trimmingCharacters(in: .whitespaces).count >= 3 else { return }
        
        NetworkService.shared.search(with: query) { result in
            switch result {
            case .success(let data):
                self.movieTableView.listMovieNetwork = data.results
            case .failure(let failure):
                print("Fuck search")
            }
        }
    }
}



// MARK: - CoreData
extension SearchViewController {
    
    func saveCoreDataForSearchScreen(listMovieNetwork: [Movie]) {
        let categoryEntity = CategoryScreenEntity(context: CoreDataService.shared.viewContext)
        categoryEntity.name = "SearchViewController"
        CoreDataService.shared.save()
        
        for movie in listMovieNetwork {
            convertModelInMovieEntity(movie: movie, categoryEntity: categoryEntity)
        }
    }
    
    
    func convertModelInMovieEntity(movie: Movie, categoryEntity: CategoryScreenEntity) {
        // Если фильма с id = xxx, нет в хранилище, то тогда добавить.
        let isExistMovieWithId = CoreDataService.shared.fetchDataId(id: movie.id,
                                                                    parentCategory: categoryEntity.name!).isEmpty
        if isExistMovieWithId {
            print("Если фильма с id = xxx, нет в хранилище, то тогда добавить.")
            let movieEntity = MovieEntity(context: CoreDataService.shared.viewContext)
            let setParents = NSSet(objects: categoryEntity)
            movieEntity.parentCategory = setParents
            movieEntity.id = Int64(movie.id)
            movieEntity.title = movie.original_title!
            movieEntity.posterPath = movie.poster_path ?? "N/A"
            movieEntity.genreId = Int64(movie.genre_ids.first ?? 0)
            movieEntity.releaseDate = movie.release_date ?? "N/A"
            movieEntity.voteAverage = movie.vote_average
            movieEntity.voteCount = Int64(movie.vote_count)
        }
        CoreDataService.shared.save()
    }
}



// MARK: - Table View Delegate
extension SearchViewController: ReusableTableViewDelegate {
    func updateListMovieCoreData() {
        movieTableView.listMovieCoreData = CoreDataService.shared.fetchData(parentCategory: "SearchViewController")
    }
    
    func didSelectTableViewCell(_ cell: UITableViewCell) {
        let detailedVC = MovieDetailViewController()
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
