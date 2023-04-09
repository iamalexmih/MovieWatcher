//
//  FavoriteViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit
import SnapKit


class FavoriteViewController: UIViewController {
    
    var tableView = ReusableTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegateForCell = self
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstrains()
    }
        
    private func setupConstrains() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
    }
}

extension FavoriteViewController: ReusableTableViewDelegate {
    func didSelectTableViewCell(_ cell: UITableViewCell) {
        let detailedVC = MovieDetailViewController()
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

