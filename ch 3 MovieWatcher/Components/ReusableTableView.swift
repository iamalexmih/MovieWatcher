//
//  MyTableView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-07.
//

import UIKit
import SnapKit


protocol ReusableTableViewDelegate: AnyObject {
    func didSelectTableViewCell(_ cell: UITableViewCell)
    func updateListMovieCoreData()
}

class ReusableTableView: UIView {
    
    lazy var tableView = UITableView()
    weak var delegateForCell: ReusableTableViewDelegate?
    
    var listMovieNetwork: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var listMovieCoreData: [MovieEntity] = [] {
        didSet {
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
            print("setDataForCellCoreData")
            cell.setDataForCellCoreData(movieEntity: listMovieCoreData[indexPath.row])
        } else {
            print("configureForNetwork")
            cell.configureForNetwork(movie: listMovieNetwork[indexPath.row])
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: Resources.Colors.backGround)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        delegateForCell?.didSelectTableViewCell(cell)
    }
}

// MARK: - Делегат от кнопки Добавить в избранное
extension ReusableTableView: FavoriteMovieCellProtocol {
    func didPressFavoriteButton() {
        delegateForCell?.updateListMovieCoreData()
    }
}
