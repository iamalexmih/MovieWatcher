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


// MARK: - Helpers funcs

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
        let prdedicate = NSPredicate(format: "id == %i", id)
        request.predicate = prdedicate
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
        let addtionalPrdedicate = NSPredicate(format: "id == %i", id)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateCategory, addtionalPrdedicate])
        
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