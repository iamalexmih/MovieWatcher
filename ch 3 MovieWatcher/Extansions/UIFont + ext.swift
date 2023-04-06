//
//  UIFont + ext.swift
//  ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 06.04.2023.
//

import UIKit


extension UIFont {
    // MARK: Jakarta Font
    static func jakartaLight(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSans-Light", size: size) ?? UIFont()
    }
    static func jakartaMedium(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSans-Medium", size: size) ?? UIFont()
    }
    static func jakartaRegular(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSans-Regular", size: size) ?? UIFont()
    }
    static func jakartaItalic(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSans-Italic", size: size) ?? UIFont()
    }

    static func jakartaBold(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSans-Bold", size: size) ?? UIFont()
    }
    
    // MARK: Jakarta Roman Font
    static func jakartaRomanExtraLigh(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSansRoman-ExtraLight", size: size) ?? UIFont()
    }
    static func jakartaRomanLight(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSansRoman-Light", size: size) ?? UIFont()
    }
    static func jakartaRomanMedium(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSansRoman-Medium", size: size) ?? UIFont()
    }
    static func jakartaRomanSemiBold(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSansRoman-SemiBold", size: size) ?? UIFont()
    }
    static func jakartaRomanBold(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSansRoman-Bold", size: size) ?? UIFont()
    }
    static func jakartaRomanExtraBold(size: CGFloat) -> UIFont {
        UIFont(name: "PlusJakartaSansRoman-ExtraBold", size: size) ?? UIFont()
    }
    
    // MARK: Montserrat Font
    static func montserratThin(size: CGFloat) -> UIFont {
        UIFont(name: "Montserrat-Thin", size: size) ?? UIFont()
    }
    static func montserratRomanExtraLight(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-ExtraLight", size: size) ?? UIFont()
    }
    static func montserratRomanLight(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-Light", size: size) ?? UIFont()
    }
    static func montserratRomanMedium(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-Medium", size: size) ?? UIFont()
    }
    static func montserratRomanSemiBold(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-SemiBold", size: size) ?? UIFont()
    }
    static func montserratRomanBold(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-Bold", size: size) ?? UIFont()
    }
    static func montserratRomanExtraBold(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-ExtraBold", size: size) ?? UIFont()
    }
    static func montserratRomanBlack(size: CGFloat) -> UIFont {
        UIFont(name: "MontserratRoman-Black", size: size) ?? UIFont()
    }
}
