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
    
    // посмотреть используются ли нижние двое через модель Movie 
    let runtime: Int?
    let overview: String? 
}


struct GenreMovie: Codable {
    let id: Int
    let name: String
}

// model for info of movie
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


// model for cast and crew of movie
struct CastCrew: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
    let name: String?
    let profile_path: String?
    let known_for_department: String?
}

struct Crew: Codable {
    let name: String?
    let profile_path: String?
    let known_for_department: String?
}


struct Castd: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String
    let castID: Int
    let character, creditID: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}
