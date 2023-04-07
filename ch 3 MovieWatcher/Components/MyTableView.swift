//
//  MyTableView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-07.
//

import UIKit

class MyTableView: UIView {

    private lazy var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.rowHeight = 184
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.backgroundColor = .white
        
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
