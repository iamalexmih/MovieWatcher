//
//  FavouriteView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-06.
//

import UIKit
import SnapKit

class FavouriteView: UIView {
    
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 184
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        moviesTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        
        addSubview(moviesTableView)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrains() {
        
        moviesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
    }
}
