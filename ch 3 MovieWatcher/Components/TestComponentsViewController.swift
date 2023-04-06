//
//  TestComponentsViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 04.04.2023.
//

import UIKit
import SnapKit



class TestComponentsViewController: UIViewController {
    
    let googleButton = GoogleButton()
    let textFieldWithLabel = TextFieldWithLabel(labelText: "Last name",
                                                textFieldPlaceHolder: "Enter last name")
    let searchTextField = SearchTextField()
    let logOutTemplateButton = LogOutTemplateButton()
    let customButton = CustomButton(title: "Custom Button")
    let textFieldWithLabelStack = TextFieldWithLabelStack(labelText: "First Name",
                                                          placeholderText: "Enter your name",
                                                          isSecure: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: Resources.Colors.backGround)

        addGoogleButtonOnView()
        addTextFieldWithLabel()
        addSearchTextField()
        addLogOutTemplateButton()
        addCustomButton()
        addTextFieldWithLabelStack()
        
        getPopularMovies()
    }
    
    // Посмотреть доступные шрифты в Xcode
    func printFonts() {
        for family in UIFont.familyNames.sorted() {
            let name = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font name: \(name)")
        }
    }
    
    // MARK: - Сетевые запросы
    func getPopularMovies() {
        NetworkService.shared.getDiscoverMovies { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data.results)
                    let movie = data.results[0]
                    let genreIds =  movie.genre_ids
                    let namesGenre = NetworkService.shared.getNameGenreForOneMovie(movieGenresId: genreIds,
                                                                  arrayGenres: StorageGenres.shared.listGenres)
                    
                    print("Жанры Фильма \(movie.original_title): ", namesGenre)
                }
            case .failure(_):
                print("Error, .....")
            }
        }
    }
    
    
    // MARK: - Компоненты
    func addGoogleButtonOnView() {
        view.addSubview(googleButton)
        
        googleButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(view.snp.top).offset(50)
            make.height.equalTo(60)
        }
    }
    
    func addTextFieldWithLabel() {
        view.addSubview(textFieldWithLabel)
        
        textFieldWithLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(googleButton.snp.bottom).offset(50)
            make.height.equalTo(100)
        }
    }
    
    func addSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(textFieldWithLabel.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
    }
    
    
    func addLogOutTemplateButton() {
        view.addSubview(logOutTemplateButton)
        
        logOutTemplateButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(searchTextField.snp.bottom).offset(50)
            make.height.equalTo(60)
        }
    }
    
    func addCustomButton() {
        view.addSubview(customButton)
        
        customButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(logOutTemplateButton.snp.bottom).offset(50)
            make.height.equalTo(60)
        }
    }
    
    
    func addTextFieldWithLabelStack() {
        view.addSubview(textFieldWithLabelStack)
        
        textFieldWithLabelStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(customButton.snp.bottom).offset(50)
            make.height.equalTo(90)
        }
    }
    
}
