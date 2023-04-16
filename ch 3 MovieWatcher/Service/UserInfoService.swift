//
//  UserInfoService.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 12.04.2023.
//

import UIKit


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
        var avatar = UIImage(systemName: "person")
        if let avatarImageData = userEntity.avatarImageData {
            avatar = UIImage(data: avatarImageData)
        }
        let userModel = UserModel(idUuid: userEntity.idUser!,
                                  firstName: userEntity.firstName,
                                  lastName: userEntity.lastName,
                                  email: userEntity.email!,
                                  dateBirth: userEntity.dateBirth,
                                  gender: userEntity.gender,
                                  location: userEntity.location,
                                  avatarImage: avatar)
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
    
    
    func fetchCurrentAvatarCoreData() -> UIImage? {
        guard let userEntity = CoreDataService.shared.fetchUser(currenUserEmail) else {
           print("fetchUserCoreData. User not found")
            return nil
        }
        var avatar = UIImage(systemName: "person")
        if let avatarImageData = userEntity.avatarImageData {
            avatar = UIImage(data: avatarImageData)
        }
        
        return avatar
    }
    
    
    func editingAvatarUserInCoreData(avatar: UIImage?) {
        guard let userEntity = CoreDataService.shared.fetchUser(currenUserEmail) else {
            print("fetchUserCoreData. User not found")
            return
        }
        guard let avatar = avatar else { return }
        let avatarDate = avatar.pngData()
        userEntity.avatarImageData = avatarDate
        
        CoreDataService.shared.save()
    }
    
    
    func deleteOutCoreData(user id: String) {
        CoreDataService.shared.deleteOutCoreData(user: id)
    }
    
//    func fetchUserCoreData(userId: String) -> UserModel? {
//        guard let userEntity = CoreDataService.shared.fetchUser(userId) else {
//           print("fetchUserCoreData. User not found")
//            return nil
//        }
//        let userModel = UserModel(idUuid: userEntity.idUser!,
//                                  firstName: userEntity.firstName!,
//                                  lastName: userEntity.lastName!,
//                                  email: userEntity.email!,
//                                  dateBirth: userEntity.dateBirth,
//                                  gender: userEntity.gender,
//                                  location: userEntity.location)
//        return userModel
//    }
    
    
}
