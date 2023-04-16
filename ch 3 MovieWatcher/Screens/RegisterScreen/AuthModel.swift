//
//  AuthModel.swift
//  ch 3 MovieWatcher
//
//  Created by Андрей Бородкин on 08.04.2023.
//



import Foundation
import UIKit
import Firebase

// Possible bug with password confirmation
// Add user Profile Model

// Пароль больше 6 символов. Почта должна содержать @.
// При регистрации все поля должны быть заполнены. First и Last name

enum Errors: String {
    case empty = "Please don't leave empty fields"
    case short = "Your entry is too short. Minimal length is 3 symbols"
    case missingAt = "E-mail has invalid format"
    case weakPassword = "Your password should be at least 6 digits long and contain special symbols"
    case psswrdNoMatch = "Your confirmation password should match the original"
}

class AuthModel {
    
    // MARK: - Modelt variables
    var firstName: String?
    var lastName: String?
    var unValidatedEmail: String?
    var validatedEmail: String?
    var validatedPassword: String?
    var tempPassword: String?
    
    // var profile: Profile?
    
    var registrationIsComplete = false
    
    var errorSet: Set<String> = []
    var errorDescription = ""
    
    // MARK: - Firebase Authentication
    
    private func createNewUser(inCaseOfAlert controller: UIViewController) {
        if let email = validatedEmail,
           let password = validatedPassword {
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                guard let self = self else { return }
                if let error = error {
                    let alert = UIAlertController(title: "Create User Error",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    controller.present(alert, animated: true)
                    print(error.localizedDescription)
                }
                if user != nil {
                    let newUser = UserModel(idUuid: UUID().uuidString,
                                            firstName: self.firstName,
                                            lastName: self.lastName,
                                            email: email,
                                            dateBirth: nil,
                                            gender: nil,
                                            location: nil,
                                            avatarImage: nil)
                    UserInfoService.shared.currenUserEmail = email
                    UserInfoService.shared.saveInfoInCoreData(for: newUser)
                    self.openTabBarController(controller)
                }
            }
        }
        registrationIsComplete = true
    }
    
    
    private func loginWithExistingUser(controller: UIViewController) {
        
        if let email = validatedEmail,
           let password = validatedPassword {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                guard let self = self else { return }
                if let error = error {
                    let alert = UIAlertController(title: "SignIn Error",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    controller.present(alert, animated: true)
                    print(error.localizedDescription)
                }
                if user != nil {
                    UserInfoService.shared.currenUserEmail = email
                    self.openTabBarController(controller)
                }
            }
        }
    }
    
    
    private func openTabBarController(_ controller: UIViewController) {
        let rootTabBar = CustomTabBarController()
        rootTabBar.modalTransitionStyle = .flipHorizontal
        rootTabBar.modalPresentationStyle = .fullScreen
        controller.present(rootTabBar, animated: true)
    }
    
    
    // MARK: - Public funcs
        
    func checkFields(_ fields: [UIView], isRegistration: Bool) {
        let fieldArray = prepareField(fields: fields, isRegistration)
        for field in fieldArray {
            
            guard let label = field.label.text else { return }
            guard let text = field.textField.text else { return }
            
            emptyShortTest(text: text)
            specificTextTest(text: text, label: label)
        }
        
        convertSetToDescription()
        
        if errorDescription.isEmpty {
            saturateUserData(with: fieldArray, isRegistration)
        }
        print(errorDescription)
    }
    
    func transitionToMainScreen(controller: UIViewController, isRegistration: Bool) {
        if errorDescription.isEmpty {
            if isRegistration {
                createNewUser(inCaseOfAlert: controller)
            } else {
                loginWithExistingUser(controller: controller)
            }  
        } else {
            presentAlert(inCaseOfAlert: controller)
            errorDescription = ""
        }
    }
    
    func destroyNavigationStack(in controller: UINavigationController?) {
        guard let navArray = controller?.viewControllers else {return}
        if navArray.count > 2 {
            controller?.viewControllers.remove(at: 1)
        }
        
        if registrationIsComplete {
            controller?.viewControllers.removeAll()
        }
    }
    
    // MARK: - Internal funcs
    
    private func prepareField(fields: [UIView], _ isRegistration: Bool) -> [TextFieldWithLabelStack] {
       var importedFields = fields
        let count = isRegistration ? 4 : 2
        
        if importedFields.count > count {
            importedFields.removeLast()
        }
        let fieldArray = (importedFields as? [TextFieldWithLabelStack])!
        
        return fieldArray
    }
    
    private  func emptyShortTest(text: String) {
        if text.isEmpty {
            errorSet.insert(Errors.empty.rawValue)
            // errorDescription += (Errors.empty.rawValue + "\n")
        } else if text.count < 3 {
            errorSet.insert(Errors.short.rawValue)
            // errorDescription += (Errors.short.rawValue + "\n")
        }
    }
    
    private func specificTextTest(text: String, label: String) {
        
        switch label {
        case "E-mail":
            if !text.contains("@") {
                errorSet.insert(Errors.missingAt.rawValue)
                // errorDescription += (Errors.missingAt.rawValue + "\n")
            }
        case "Password":
            if text.count < 6 {
//            if text.count < 6 || !text.contains("_") {
                errorSet.insert(Errors.weakPassword.rawValue)
                // errorDescription += (Errors.weakPassword.rawValue + "\n")
            }
            tempPassword = text
        case "Confirm Password":
            if tempPassword != text {
                errorSet.insert(Errors.psswrdNoMatch.rawValue)
                // errorDescription += (Errors.psswrdNoMatch.rawValue + "\n")
            }
            tempPassword = nil
        default: break
        }
    }
    
    
    private func convertSetToDescription() {
        for item in errorSet {
            errorDescription += (item + "\n")
        }
        errorSet = []
    }
    

    private func presentAlert(inCaseOfAlert controller: UIViewController, isAuthError: Bool? = nil, error: Error? = nil) {
        let title = (isAuthError ?? false) ? "Error" : "Invalid Data Entry"
        let description = (isAuthError ?? false) ? error!.localizedDescription : errorDescription
               
        let alert = UIAlertController(title: "Invalid Data Entry", message: errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        controller.present(alert, animated: true)
    }
    
    
    private  func saturateUserData(with fields: [TextFieldWithLabelStack], _ isRegistration: Bool) {
        var nameIndex = 0
        var surnameIndex = 1
        var emailIndex = 2
        var passwordIndex = 3
        
        if isRegistration {
            firstName = fields[nameIndex].textField.text!
            lastName = fields[surnameIndex].textField.text!
        } else {
            emailIndex = 0
            passwordIndex = 1
        }
        validatedEmail = fields[emailIndex].textField.text!
        validatedPassword = fields[passwordIndex].textField.text!
    }
}
