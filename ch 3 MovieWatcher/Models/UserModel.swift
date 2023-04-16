//
//  UserModel.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 12.04.2023.
//

import UIKit


class UserModel {
    
    let idUuid: String
    let firstName: String?
    let lastName: String?
    let email: String
    let dateBirth: Date?
    let gender: String?
    let location: String?
    let avatarImage: UIImage?
    
    init(idUuid: String,
         firstName: String?,
         lastName: String?,
         email: String,
         dateBirth: Date?,
         gender: String?,
         location: String?,
         avatarImage: UIImage?) {
        self.idUuid = idUuid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dateBirth = dateBirth
        self.gender = gender
        self.location = location
        self.avatarImage = avatarImage
    }
}
