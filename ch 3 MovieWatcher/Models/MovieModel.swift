//
//  MovieModel.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 05.04.2023.
//

import Foundation


struct ListMovies: Codable {
    let results: [Movie]
}

// swiftlint:disable all
struct Movie: Codable {
    let id: Int
    let original_title: String?
    let poster_path: String?
    let genre_ids: [Int]
    let release_date: String?
    let vote_count: Int // указывается в скобках после рейтинга фильма
    let vote_average: Double
    // Не могу найти  длительность фильма в API
    let runtime: Int?
    let overview: String? 
}


struct GenreMovie: Codable {
    let id: Int
    let name: String
}


struct InfoMovie: Codable {
    let id: Int
    let original_title: String?
    let poster_path: String?
    let vote_average: Double
    let release_date: String?
    let runtime: Int?
    let overview: String?
    let genres: [GenreInfoMovie]?
}

struct GenreInfoMovie: Codable {
    let id: Int?
    let name: String?
}
