//
//  RecipeError.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 05.04.2023.
//

import Foundation



protocol LocalizedError: Error {
    var errorDescription: String { get }
}



public enum RecipeError: LocalizedError {
    
    var errorDescription: String {
        switch self {
        case .urlNotCreate:
            return "URL не создан"
        case .internetConnectionLost:
            return "Проверьте интернет соединение"
        case .dataError:
            return "Что-то не так с данными"
        case .decodeError:
            return "Ошибка при декодировании данных"
        }
    }
    
    case urlNotCreate
    case internetConnectionLost
    case dataError
    case decodeError
}
