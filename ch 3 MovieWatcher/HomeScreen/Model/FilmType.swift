//
//  FilmType.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 06.04.2023.
//

import Foundation

enum FilmType: String, CaseIterable {
    case all = "All"
    case action = "Action"
    case adventure = "Adventure"
    case animation = "Animation"
    case comedy = "Comedy"
    case crime = "Crime"
    case documentary = "Documentary"
    case drama = "Drama"
    case family = "Family"
    case fantasy = "Fantasy"
    case history = "History"
    case horror = "Horror"
    case music = "Music"
    case romance = "Romance"
    case scienceFiction = "Science Fiction"
    case tvMovie = "TV Movie"
    case thriller = "Thriller"
    case war = "War"
    case western = "Western"
    
    static var filmArray: [String] = {
        return FilmType.allCases.map { $0.rawValue }
    }()
    
}
