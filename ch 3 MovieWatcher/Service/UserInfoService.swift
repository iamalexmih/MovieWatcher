//
//  UserInfoService.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 12.04.2023.
//

import Foundation


class UserInfoService {
    
    static let shared = UserInfoService()
    private init() { }
    
    private var currenUserId = ""
    var currenUserEmail = ""
    
    func saveInfoInCoreData(for user: UserModel) {
        let userEntity = UserEntity(context: CoreDataService.shared.viewContext)
        userEntity.idUser = user.idUuid
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.email = user.email.lowercased()
        userEntity.dateBirth = user.dateBirth
        userEntity.gender = user.gender
        userEntity.location = user.location
        
        CoreDataService.shared.save()
    }
    
    func fetchCurrentUserCoreData() -> UserModel? {
        guard let userEntity = CoreDataService.shared.fetchUser(currenUserEmail) else {
           print("fetchUserCoreData. User not found")
            return nil
        }
        let userModel = UserModel(idUuid: userEntity.idUser!,
                                  firstName: userEntity.firstName,
                                  lastName: userEntity.lastName,
                                  email: userEntity.email!,
                                  dateBirth: userEntity.dateBirth,
                                  gender: userEntity.gender,
                                  location: userEntity.location)
        return userModel
    }
    
    func fetchUserCoreData(userId: String) -> UserModel? {
        guard let userEntity = CoreDataService.shared.fetchUser(userId) else {
           print("fetchUserCoreData. User not found")
            return nil
        }
        let userModel = UserModel(idUuid: userEntity.idUser!,
                                  firstName: userEntity.firstName!,
                                  lastName: userEntity.lastName!,
                                  email: userEntity.email!,
                                  dateBirth: userEntity.dateBirth,
                                  gender: userEntity.gender,
                                  location: userEntity.location)
        return userModel
    }
    
    func editingUserInCoreData(userModel: UserModel) {
            guard let userEntity = CoreDataService.shared.fetchUser(currenUserEmail) else {
               print("fetchUserCoreData. User not found")
                return
            }
            
            userEntity.firstName = userModel.firstName
            userEntity.lastName = userModel.lastName
            userEntity.dateBirth = userModel.dateBirth
            userEntity.gender = userModel.gender
            userEntity.location = userModel.location
            
            CoreDataService.shared.save()
        }
    
    func deleteOutCoreData(user id: String) {
        CoreDataService.shared.deleteOutCoreData(user: id)
    }
}
