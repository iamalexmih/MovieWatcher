//
//  ListSection.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 06.04.2023.
//

import Foundation

enum ListSection {
//    case person([ListItem])
    case popularCategory([ListItem])
    case popularCategoryButton([ListItem])
    case boxOffice([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .popularCategory(let items),
                .popularCategoryButton(let items),
                .boxOffice(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
//        case .person(_):
//            return ""
        case .popularCategory(_):
            return ""
        case .popularCategoryButton(_):
            return "Category"
        case .boxOffice(_):
            return "Box Office"
        }
    }
}
