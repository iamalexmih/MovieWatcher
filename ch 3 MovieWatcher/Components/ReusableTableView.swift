//
//  MyTableView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-07.
//

import UIKit
import SnapKit


protocol TableAndCollectionViewProtocol: AnyObject {
    func didSelectCellOpenMovieDetailScreen(_ cell: Int)
    func updateListMovieCoreData()
}

class ReusableTableView: UIView {
    
    var tableView = UITableView()
    weak var delegateForCell: TableAndCollectionViewProtocol?
    
    var listMovieNetwork: [Movie] = [] {
        didSet {
            print("listMovieNetwork")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var listMovieCoreData: [MovieEntity] = [] {
        didSet {
            print("listMovieCoreData")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTable()
        setTableDelegates()
        self.addSubview(tableView)
        setupConstraints()
    }
    
    func configureTable() {
        tableView.rowHeight = 184
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
    }
    
    func setTableDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView Delegate
extension ReusableTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listMovieNetwork.isEmpty {
            return listMovieCoreData.count
        } else {
            return listMovieNetwork.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.delegateFavoriteButton = self
        
        if listMovieNetwork.isEmpty {
            cell.configureCellCoreData(movieEntity: listMovieCoreData[indexPath.row])
        } else {
            cell.configureForNetwork(movie: listMovieNetwork[indexPath.row])
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: Resources.Colors.backGround)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listMovieNetwork.isEmpty {
            let movie = listMovieCoreData[indexPath.row]
        } else {
            let movie = listMovieNetwork[indexPath.row]
            delegateForCell?.didSelectCellOpenMovieDetailScreen(movie.id)
        }
    }
}

// MARK: - Делегат от кнопки Добавить в избранное
extension ReusableTableView: FavoriteButtonProtocol {
    func didPressFavoriteButton() {
        delegateForCell?.updateListMovieCoreData()
        tableView.reloadData()
    }
}
