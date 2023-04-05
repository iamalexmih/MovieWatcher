//
//  Resource.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import Foundation

enum Resources {
    enum Colors {
        static let accent = "accentColor"
        static let backGround = "bgColor"
        static let cellIcon = "cellIconColor"
        static let inactive = "inactiveColor"
        static let secondText = "secondTextColor"
        static let text = "textColor"
        static let categoryColour = "categoryColor"
    }
    
    
    enum Image {
        static let imageExample = "imageExample"
        static let searchImage = "magnifyingglass"
        static let closeImage = "multiply"
        static let filterImage = "slider.horizontal.3"
        static let tabBarHome = "GroupHome"
        static let tabBarFavorites = "Heart"
        static let tabBarFavoritesFill = "HeartFill"
        static let tabBarSetting = "Profile"
        static let tabBarSettingFill = "ProfileFill"
        static let tabBarSearch = "Search"
        static let tabBarSearchFill = "SearchFill"
        static let tabBarRecentWatch = "Video"
        static let tabBarRecentWatchFill = "Subtract"
        static let googleSymbol = "googleSymbol"
    }
    
    enum Font {
        static let jakartaFontSemiBold = "PlusJakartaSansRoman-SemiBold"
        static let jakartaFont = "PlusJakartaSans-Regular"
        
//    Family: Plus Jakarta Sans Font names: ["PlusJakartaSansRoman-ExtraLight",
//        "PlusJakartaSansRoman-Light", "PlusJakartaSansRoman-Medium", "PlusJakartaSansRoman-Bold", "PlusJakartaSansRoman-ExtraBold"]
    }
}
