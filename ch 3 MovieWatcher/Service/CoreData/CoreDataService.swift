//
//  CoreDataService.swift
//  reusebleTableViewAndCollection
//
//  Created by Алексей Попроцкий on 10.04.2023.
//

import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        loadPersistentStores()
    }
    
    
    func loadPersistentStores() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                print("ERROR loading Core Data: \(error!.localizedDescription)")
                return
            }
        }
    }
    
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("CoreDataService Save Context An ERROR occurred while save: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - Helpers funcs. общее назначение.

extension CoreDataService {
    
    func fetchData(parentCategory: String) -> [MovieEntity] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicateCategory = NSPredicate(format: "ANY parentCategory.name MATCHES %@", parentCategory)
        request.predicate = predicateCategory
        
        var movieEntitys: [MovieEntity] = []
        do {
            movieEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchData: \(error.localizedDescription)")
        }
        return movieEntitys
    }
    
    
    func fetchImageUseMovieId(id: Int) -> ImageEntity? {
        var imageEntitys: [ImageEntity] = []
        let request: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", id)
        request.predicate = predicate
        do {
            imageEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchImageUseMovieId: \(error.localizedDescription)")
        }
        let imageEntity = imageEntitys.first
        return imageEntity
    }
    
    
    // Нужна для проверки условия: Если фильма с id xxx нет в хранилище, то тогда добавить.
    func fetchDataId(id: Int, parentCategory: String) -> [MovieEntity] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicateCategory = NSPredicate(format: "ANY parentCategory.name MATCHES %@", parentCategory)
        let addtionalPredicate = NSPredicate(format: "id == %i", id)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateCategory, addtionalPredicate])
        
        var movieEntitys: [MovieEntity] = []
        do {
            movieEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchDataId: \(error.localizedDescription)")
        }
        return movieEntitys
    }
    
    
    // Глобальный запрос по всему хранилищю
    func fetchAllMovieWith(_ id: Int) -> [MovieEntity] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", id)
        request.predicate = predicate
        
        var movieEntitys: [MovieEntity] = []
        do {
            movieEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchDataId: \(error.localizedDescription)")
        }
        return movieEntitys
    }
    
    
    func deleteAllData() {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            let allMovieEntity = try viewContext.fetch(request)
            for movie in allMovieEntity {
                viewContext.delete(movie)
                print("Delete All Data for MovieEntity")
            }
        } catch let error {
            print("deleteAllData. Error load: \(error.localizedDescription)")
        }
        save()
    }
}



// MARK: - Частные функции
extension CoreDataService {
    
    func saveCoreDataForSearchScreen(listMovieNetwork: [Movie]) {
        let categoryEntity = CategoryScreenEntity(context: viewContext)
        categoryEntity.name = "SearchViewController"
        self.save()
        for movie in listMovieNetwork {
            convertModelInMovieEntity(movie: movie, categoryEntity: categoryEntity)
        }
    }
    
    
    func saveCoreDataForHomeScreenTopRated(listMovieNetwork: [Movie]) {
        let categoryEntity = CategoryScreenEntity(context: viewContext)
        categoryEntity.name = "HomeScreenTopRated"
        self.save()
        
        for movie in listMovieNetwork {
            convertModelInMovieEntity(movie: movie, categoryEntity: categoryEntity)
        }
    }
    
    
    func saveCoreDataForHomeScreenBoxOfficeCollection(listMovieNetwork: [Movie]) {
        let categoryEntity = CategoryScreenEntity(context: viewContext)
        categoryEntity.name = "HomeScreenBoxOfficeCollection"
        self.save()
        
        for movie in listMovieNetwork {
            convertModelInMovieEntity(movie: movie, categoryEntity: categoryEntity)
        }
    }
    
    func convertModelInMovieEntity(movie: Movie, categoryEntity: CategoryScreenEntity) {
        // Если фильма с id = xxx, нет в хранилище, то тогда добавить.
        let listExistMoviesWithIdInGlobalCategory = fetchDataId(id: movie.id, parentCategory: "GlobalCategory")
        let isNotExistMovieWithId = listExistMoviesWithIdInGlobalCategory.isEmpty
        if isNotExistMovieWithId {
//            print("Если фильма с id = xxx, нет в хранилище, то тогда добавить.")
            let globalCategory = CategoryScreenEntity(context: viewContext)
            globalCategory.name = "GlobalCategory"
            let setParents = NSSet(objects: categoryEntity, globalCategory)
            let newMovieEntity = MovieEntity(context: viewContext)
            newMovieEntity.parentCategory = setParents
            newMovieEntity.id = Int64(movie.id)
            newMovieEntity.title = movie.original_title!
            newMovieEntity.posterPath = movie.poster_path ?? "N/A"
            newMovieEntity.genreId = Int64(movie.genre_ids.first ?? 0)
            newMovieEntity.releaseDate = movie.release_date ?? "N/A"
            newMovieEntity.voteAverage = movie.vote_average
            newMovieEntity.voteCount = Int64(movie.vote_count)
        }
//        else {
//            let existingMovie = listExistMoviesWithIdInGlobalCategory.first!
//            print(existingMovie)
//            existingMovie.addToParentCategory(categoryEntity)
//        }
        self.save()
    }
    
//    func convertModelInMovieEntity(movie: Movie, categoryEntity: CategoryScreenEntity) {
//        // Если фильма с id = xxx, нет в хранилище, то тогда добавить.
//        let isExistMovieWithId = fetchDataId(id: movie.id, parentCategory: categoryEntity.name!).isEmpty
//        if isExistMovieWithId {
////            print("Если фильма с id = xxx, нет в хранилище, то тогда добавить.")
//            let movieEntity = MovieEntity(context: viewContext)
////            let globalCategory = CategoryScreenEntity(context: viewContext)
////            globalCategory.name = "GlobalCategory"
//            let setParents = NSSet(objects: categoryEntity)
//            movieEntity.parentCategory = setParents
//            movieEntity.id = Int64(movie.id)
//            movieEntity.title = movie.original_title!
//            movieEntity.posterPath = movie.poster_path ?? "N/A"
//            movieEntity.genreId = Int64(movie.genre_ids.first ?? 0)
//            movieEntity.releaseDate = movie.release_date ?? "N/A"
//            movieEntity.voteAverage = movie.vote_average
//            movieEntity.voteCount = Int64(movie.vote_count)
//        }
//        self.save()
//    }
    
    
    func fetchRecentWatch() -> [MovieEntity] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "isViewed == %i", true)
        request.predicate = predicate
        
        var movieEntitys: [MovieEntity] = []
        do {
            movieEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchDataId: \(error.localizedDescription)")
        }
        return movieEntitys
    }
}

// MARK: - Работа с Favorite
extension CoreDataService {
    
    func addFavorite(id: Int) {
        // Добавить в Избранное
        for movie in fetchAllMovieWith(id) {
            movie.favorite = true
            let favoriteCategory = CategoryScreenEntity(context: viewContext)
            movie.addToParentCategory(favoriteCategory)
        }
        self.save()
    }
    
    
    func deleteFavorite(id: Int) {
        for movie in fetchAllMovieWith(id) {
            movie.favorite = false
            let favoriteCategory = CategoryScreenEntity(context: viewContext)
            movie.removeFromParentCategory(favoriteCategory)
        }
        self.save()
    }
    
    
    func fetchAllFavorite() -> [MovieEntity] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicateCategory = NSPredicate(format: "ANY parentCategory.name MATCHES %@", "GlobalCategory")
        let addtionalPredicate = NSPredicate(format: "favorite == %i", true)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateCategory, addtionalPredicate])
        
        var movieEntitys: [MovieEntity] = []
        do {
            movieEntitys = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchDataId: \(error.localizedDescription)")
        }
        return movieEntitys
    }
}


// MARK: - User
extension CoreDataService {
    func fetchUser(_ userId: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let predicate = NSPredicate(format: "idUser MATCHES %@", userId)
        request.predicate = predicate
        
        var usersArray: [UserEntity] = []
        do {
            usersArray = try viewContext.fetch(request)
        } catch let error {
            print("fetchUser. Error load: \(error.localizedDescription)")
        }
        let user = usersArray.first
        return user
    }
    
    func deleteOutCoreData(user id: String) {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let predicate = NSPredicate(format: "idUser MATCHES %@", id)
        request.predicate = predicate
        do {
            let allUsersWithId = try viewContext.fetch(request)
            for user in allUsersWithId {
                viewContext.delete(user)
                print("Delete data for UserEntity")
            }
        } catch let error {
            print("deleteOutCoreData. Error load fetchTask: \(error.localizedDescription)")
        }
        save()
    }
}
