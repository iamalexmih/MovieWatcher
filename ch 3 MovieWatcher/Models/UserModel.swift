//
//  UserModel.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 12.04.2023.
//

import Foundation


class UserModel {
    
    let idUuid: String
    let firstName: String?
    let lastName: String?
    let email: String
    let dateBirth: Date?
    let gender: String?
    let location: String?
    
    init(idUuid: String,
         firstName: String?,
         lastName: String?,
         email: String,
         dateBirth: Date?,
         gender: String?,
         location: String?) {
        self.idUuid = idUuid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dateBirth = dateBirth
        self.gender = gender
        self.location = location
    }
}
