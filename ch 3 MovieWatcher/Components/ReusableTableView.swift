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
}

class ReusableTableView: UIView {
    
    lazy var tableView = UITableView()
    weak var delegateForCell: ReusableTableViewDelegate?
    var movies: [Movie] = []
    
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

extension ReusableTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(movie: movie)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        delegateForCell?.didSelectTableViewCell(cell)
    }
}
