//
//  FavoriteViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit
import SnapKit


class FavoriteViewController: UIViewController {
    
    private let favouriteView = FavouriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favouriteView.moviesTableView.dataSource = self
        favouriteView.moviesTableView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.addSubview(favouriteView)
        
        favouriteView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}


extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
