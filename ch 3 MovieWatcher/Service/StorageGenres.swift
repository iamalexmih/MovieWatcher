//
//  StorageGenres.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 06.04.2023.
//

import Foundation
 

class StorageGenres {
    static let shared = StorageGenres()
    private init() { }
    
    let listGenres: [GenreMovie] = [
        GenreMovie(id: 28, name: "Action"),
        GenreMovie(id: 12, name: "Adventure"),
        GenreMovie(id: 16, name: "Animation"),
        GenreMovie(id: 35, name: "Comedy"),
        GenreMovie(id: 80, name: "Crime"),
        GenreMovie(id: 99, name: "Documentary"),
        GenreMovie(id: 18, name: "Drama"),
        GenreMovie(id: 10751, name: "Family"),
        GenreMovie(id: 14, name: "Fantasy"),
        GenreMovie(id: 36, name: "History"),
        GenreMovie(id: 27, name: "Horror"),
        GenreMovie(id: 10402, name: "Music"),
        GenreMovie(id: 9648, name: "Mystery"),
        GenreMovie(id: 10749, name: "Romance"),
        GenreMovie(id: 878, name: "Science Fiction"),
        GenreMovie(id: 10770, name: "TV Movie"),
        GenreMovie(id: 53, name: "Thriller"),
        GenreMovie(id: 10752, name: "War"),
        GenreMovie(id: 37, name: "Western")
    ]
}
