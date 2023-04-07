//
//  MockData.swift
//  ch 3 MovieWatcher
//
//  Created by Михаил Позялов on 06.04.2023.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
//    let person: ListSection = {
//        .person([.init(name: "Vasya", image: Resources.Image.googleSymbol, category: "War", time: 18)])
//    }()
    
    let popularCategory: ListSection = {
        .popularCategory([.init(name: "jjjjjjj", image: "filmPoster", category: "Comedy", time: 19),
                         .init(name: "gggggggg", image: "filmPoster", category: "Drama", time: 19),
                         .init(name: "wwwwwwww", image: "filmPoster", category: "Comedy", time: 19),
                         .init(name: "hhhhhhh", image: "filmPoster", category: "War", time: 19),
                         .init(name: "tttttt", image: "filmPoster", category: "War", time: 19),
                         .init(name: "kkkkkkk", image: "filmPoster", category: "Drama", time: 19),
                         .init(name: "lllllll", image: "filmPoster", category: "Comedy", time: 19),
                         .init(name: "yyyyyyy", image: "filmPoster", category: "War", time: 19),
                         .init(name: "uuuuuuu", image: "filmPoster", category: "Drama", time: 19),
                         .init(name: "ooooooo", image: "filmPoster", category: "Comedy", time: 19)])
    }()
    
    let popularCategoryButton: ListSection = {
        .popularCategoryButton([.init(name: "", image: "", category: "", time: 0)])
    }()
    
    let boxOffice: ListSection = {
        .boxOffice([.init(name: "test1", image: "filmPoster", category: "Drama", time: 19),
                    .init(name: "test2", image: "filmPoster", category: "War", time: 45)])
    }()
    
    var pageData: [ListSection] {
        [popularCategory, popularCategoryButton, boxOffice]
    }
}
