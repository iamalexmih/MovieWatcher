//
//  HomeViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {
    
    var collectionView = MyCollectionView()
    var tableView = MyTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.addSubview(tableView)

        setupConstrains()
    }
    
    private func setupConstrains() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(-15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(-10)
            make.bottom.equalToSuperview().inset(-27)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
    }
    
}


