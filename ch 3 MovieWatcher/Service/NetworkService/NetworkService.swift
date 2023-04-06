//
//  NetworkService.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import Foundation


struct ApiConstants {
    static let baseUrl = "https://api.themoviedb.org"
    static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
    static let posterUrl = "https://image.tmdb.org"
    
}



final class NetworkService {
    
    static let shared = NetworkService()
    private init() { }
    

    
    // Cписок популярных фильмов с помощью Discover.
    func getDiscoverMovies(completion: @escaping (Result<ListMovies, Error>) -> Void) {
        let urlString =
        ApiConstants.baseUrl +
        "/3/discover/movie?" +
        "api_key=" + apiKey +
        "&language=en-US" +
        "&sort_by=popularity.desc" +
        "&include_adult=false" +
        "&include_video=false" +
        "&page=1" +
        "&with_watch_monetization_types=flatrate"
        
        performRequest(with: urlString, type: ListMovies.self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // Постер к фильму.
    func makeUrlForPoster(posterPath: String?) -> String? {
        guard let posterPath = posterPath else { return nil }
        let posterURL =
        "\(ApiConstants.posterUrl)" +
        "/t/p/w\(200)/" +
        "\(posterPath)"
        return posterURL
    }
    
    
    // Получить список всех жанров фильмов.
    func getListGenre(completion: @escaping (Result<[GenreMovie], Error>) -> Void) {
        let urlString = "\(ApiConstants.baseUrl)/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        performRequest(with: urlString, type: [GenreMovie].self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Получить Название жанра к одному Фильму из его Id.
    func getNameGenreForOneMovie(movieGenresId: [Int], arrayGenres: [GenreMovie]) -> [String] {
        var arrayGengeName: [String] = []
//        for genre in arrayGenres {
//            if movie.genre_ids.contains(genre.id) {
//                arrayGengeName.append(genre.name)
//            }
//        }
        for genre in arrayGenres where movieGenresId.contains(genre.id) {
            arrayGengeName.append(genre.name)
        }
        
        return arrayGengeName
    }
    
    
    // Получить список популярных фильмов По категории.
    func getListMoviesForGenres(_ genreId: String, completion: @escaping (Result<ListMovies, Error>) -> Void) {
        let urlString =
        ApiConstants.baseUrl +
        "/3/discover/movie?" +
        "api_key=" + apiKey +
        "&language=en-US" +
        "&sort_by=popularity.desc" +
        "&include_adult=false" +
        "&include_video=false" +
        "&page=1" +
        "&with_watch_monetization_types=flatrate" +
        "&with_genres=\(genreId)"
        performRequest(with: urlString, type: ListMovies.self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // Получить подробную информацию по фильму.

    
    
    
    
    // Общий запрос с дженерик JSONDecoder.
    private func performRequest<T: Decodable>(with urlString: String,
                                              type: T.Type,
                                              completion: @escaping (Result<T, RecipeError>) -> Void) {
        let newUrl = urlString.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: newUrl) else {
            completion(.failure(.urlNotCreate))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            let statusCode = response.statusCode
            print("statusCode: ", statusCode)
            guard error == nil else {
                completion(.failure(.internetConnectionLost))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                if let decodedData = try? JSONDecoder().decode(type.self, from: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.decodeError))
                }
            }
        }
        task.resume()
    }
    
    // За место него использовать getDiscoverMovies. Список популярных фильмов.
    func getPopularMovies(completion: @escaping (Result<ListMovies, Error>) -> Void) {
        let urlString = "\(ApiConstants.baseUrl)/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        performRequest(with: urlString, type: ListMovies.self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
